/**
 * bootbox.js [v4.4.0]
 *
 * http://bootboxjs.com/license.txt
 */

// @see https://github.com/makeusabrew/bootbox/issues/180
// @see https://github.com/makeusabrew/bootbox/issues/186
(function (root, factory) {

    "use strict";
    if (typeof define === "function" && define.amd) {
        // AMD. Register as an anonymous module.
        define(["jquery"], factory);
    } else if (typeof exports === "object") {
        // Node. Does not work with strict CommonJS, but
        // only CommonJS-like environments that support module.exports,
        // like Node.
        module.exports = factory(require("jquery"));
    } else {
        // Browser globals (root is window)
        root.common = factory(root.jQuery);
    }

}(this, function init($, undefined) {

    "use strict";
    // the base DOM structure needed to create a modal
    var templates = {
        dialog:
            "<div class='bootbox modal' tabindex='-1' role='dialog'>" +
            "<div class='modal-dialog'>" +
            "<div class='modal-content'>" +
            "<div class='modal-body'><div class='bootbox-body'></div></div>" +
            "</div>" +
            "</div>" +
            "</div>",
        header:
            "<div class='modal-header'>" +
            "<h4 class='modal-title'></h4>" +
            "</div>",
        footer:
            "<div class='modal-footer'></div>",
        closeButton:
            "<button type='button' class='bootbox-close-button close' data-dismiss='modal' aria-hidden='true'></button>",
        form:
            "<form class='bootbox-form'></form>",
        inputs: {
            text:
                "<input class='bootbox-input bootbox-input-text form-control' autocomplete=off type=text />",
            textarea:
                "<textarea class='bootbox-input bootbox-input-textarea form-control'></textarea>",
            email:
                "<input class='bootbox-input bootbox-input-email form-control' autocomplete='off' type='email' />",
            select:
                "<select class='bootbox-input bootbox-input-select form-control'></select>",
            checkbox:
                "<div class='checkbox'><label><input class='bootbox-input bootbox-input-checkbox' type='checkbox' /></label></div>",
            date:
                "<input class='bootbox-input bootbox-input-date form-control' autocomplete=off type='date' />",
            time:
                "<input class='bootbox-input bootbox-input-time form-control' autocomplete=off type='time' />",
            number:
                "<input class='bootbox-input bootbox-input-number form-control' autocomplete=off type='number' />",
            password:
                "<input class='bootbox-input bootbox-input-password form-control' autocomplete='off' type='password' />"
        }
    };

    var defaults = {
        // default language
        locale: "en",
        // show backdrop or not. Default to static so user has to interact with dialog
        backdrop: "static",
        // animate the modal in/out
        animate: true,
        // additional class string applied to the top level dialog
        className: null,
        // whether or not to include a close button
        closeButton: true,
        // show the dialog immediately by default
        show: true,
        // dialog container
        container: "body"
    };

    // our public object; augmented after our private API
    var exports = {};

    /**
     * @private
     */
    function _t(key) {
        var locale = locales[defaults.locale];
        return locale ? locale[key] : locales.en[key];
    }

    function processCallback(e, dialog, callback) {
        e.stopPropagation();
        e.preventDefault();

        // by default we assume a callback will get rid of the dialog,
        // although it is given the opportunity to override this

        // so, if the callback can be invoked and it *explicitly returns false*
        // then we'll set a flag to keep the dialog active...
        var preserveDialog = $.isFunction(callback) && callback.call(dialog, e) === false;

        // ... otherwise we'll bin it
        if (!preserveDialog) {
            dialog.modal("hide");
        }
    }

    function getKeyLength(obj) {
        // @TODO defer to Object.keys(x).length if available?
        var k, t = 0;
        for (k in obj) {
            t++;
        }
        return t;
    }

    function each(collection, iterator) {
        var index = 0;
        $.each(collection, function (key, value) {
            iterator(key, value, index++);
        });
    }

    function sanitize(options) {
        var buttons;
        var total;

        if (typeof options !== "object") {
            throw new Error("Please supply an object of options");
        }

        if (!options.message) {
            throw new Error("Please specify a message");
        }

        // make sure any supplied options take precedence over defaults
        options = $.extend({}, defaults, options);

        if (!options.buttons) {
            options.buttons = {};
        }

        buttons = options.buttons;

        total = getKeyLength(buttons);

        each(buttons, function (key, button, index) {

            if ($.isFunction(button)) {
                // short form, assume value is our callback. Since button
                // isn't an object it isn't a reference either so re-assign it
                button = buttons[key] = {
                    callback: button
                };
            }

            // before any further checks make sure by now button is the correct type
            if ($.type(button) !== "object") {
                throw new Error("button with key " + key + " must be an object");
            }

            if (!button.label) {
                // the lack of an explicit label means we'll assume the key is good enough
                button.label = key;
            }

            if (!button.className) {
                if (total <= 2 && index === total - 1) {
                    // always add a primary to the main option in a two-button dialog
                    button.className = "btn-primary";
                } else {
                    button.className = "btn-default";
                }
            }
        });

        return options;
    }

    /**
     * map a flexible set of arguments into a single returned object
     * if args.length is already one just return it, otherwise
     * use the properties argument to map the unnamed args to
     * object properties
     * so in the latter case:
     * mapArguments(["foo", $.noop], ["message", "callback"])
     * -> { message: "foo", callback: $.noop }
     */
    function mapArguments(args, properties) {
        var argn = args.length;
        var options = {};

        if (argn < 1) {
            throw new Error("Invalid argument length");
        }

        if (argn > 2) {
            options[properties[0]] = args[4];
            options[properties[1]] = args[5];
        } else if (argn === 2 || typeof args[0] === "string") {
            options[properties[0]] = args[0];
            options[properties[1]] = args[1];
        } else {
            options = args[0];
        }

        return options;
    }

    /**
     * merge a set of default dialog options with user supplied arguments
     */
    function mergeArguments(defaults, args, properties) {
        return $.extend(
            // deep merge
            true,
            // ensure the target is an empty, unreferenced object
            {},
            // the base options object for this type of dialog (often just buttons)
            defaults,
            // args could be an object or array; if it's an array properties will
            // map it to a proper options object
            mapArguments(
                args,
                properties
            )
        );
    }

    /**
     * this entry-level method makes heavy use of composition to take a simple
     * range of inputs and return valid options suitable for passing to bootbox.dialog
     */
    function mergeDialogOptions(className, labels, properties, args) {
        //  build up a base set of dialog properties
        var baseOptions = {
            className: "bootbox-" + className,
            buttons: createLabels.apply(null, labels)
        };

        // ensure the buttons properties generated, *after* merging
        // with user args are still valid against the supplied labels
        return validateButtons(
            // merge the generated base properties with user supplied arguments
            mergeArguments(
                baseOptions,
                args,
                // if args.length > 1, properties specify how each arg maps to an object key
                properties
            ),
            labels
        );
    }

    /**
     * from a given list of arguments return a suitable object of button labels
     * all this does is normalise the given labels and translate them where possible
     * e.g. "ok", "confirm" -> { ok: "OK, cancel: "Annuleren" }
     */
    function createLabels() {
        var buttons = {};

        for (var i = 0, j = arguments.length; i < j; i++) {
            var argument = arguments[i];
            var key = argument.toLowerCase();
            var value = argument.toUpperCase();

            buttons[key] = {
                label: _t(value)
            };
        }

        return buttons;
    }

    function validateButtons(options, buttons) {
        var allowedButtons = {};
        each(buttons, function (key, value) {
            allowedButtons[value] = true;
        });

        each(options.buttons, function (key) {
            if (allowedButtons[key] === undefined) {
                throw new Error("button key " + key + " is not allowed (options are " + buttons.join("\n") + ")");
            }
        });

        return options;
    }

    exports.alert = function () {
        var options;

        options = mergeDialogOptions("alert", ["ok"], ["message", "callback"], arguments);

        if (options.callback && !$.isFunction(options.callback)) {
            throw new Error("alert requires callback property to be a function when provided");
        }

        /**
         * overrides
         */
        options.buttons.ok.callback = options.onEscape = function () {
            if ($.isFunction(options.callback)) {
                return options.callback.call(this);
            }
            return true;
        };

        return exports.dialog(options);
    };

    exports.prompt = function () {
        var options;
        var defaults;
        var dialog;
        var form;
        var input;
        var shouldShow;
        var inputOptions;

        // we have to create our form first otherwise
        // its value is undefined when gearing up our options
        // @TODO this could be solved by allowing message to
        // be a function instead...
        form = $(templates.form);

        // prompt defaults are more complex than others in that
        // users can override more defaults
        // @TODO I don't like that prompt has to do a lot of heavy
        // lifting which mergeDialogOptions can *almost* support already
        // just because of 'value' and 'inputType' - can we refactor?
        defaults = {
            className: "bootbox-prompt",
            buttons: createLabels("cancel", "confirm"),
            value: "",
            inputType: "text"
        };

        options = validateButtons(
            mergeArguments(defaults, arguments, ["title", "callback"]),
            ["cancel", "confirm"]
        );

        // capture the user's show value; we always set this to false before
        // spawning the dialog to give us a chance to attach some handlers to
        // it, but we need to make sure we respect a preference not to show it
        shouldShow = (options.show === undefined) ? true : options.show;

        /**
         * overrides; undo anything the user tried to set they shouldn't have
         */
        options.message = form;

        options.buttons.cancel.callback = options.onEscape = function () {
            return options.callback.call(this, null);
        };

        options.buttons.confirm.callback = function () {
            var value;

            switch (options.inputType) {
                case "text":
                case "textarea":
                case "email":
                case "select":
                case "date":
                case "time":
                case "number":
                case "password":
                    value = input.val();
                    break;

                case "checkbox":
                    var checkedItems = input.find("input:checked");

                    // we assume that checkboxes are always multiple,
                    // hence we default to an empty array
                    value = [];

                    each(checkedItems, function (_, item) {
                        value.push($(item).val());
                    });
                    break;
            }

            return options.callback.call(this, value);
        };

        options.show = false;

        // prompt specific validation
        if (!options.title) {
            throw new Error("prompt requires a title");
        }

        if (!$.isFunction(options.callback)) {
            throw new Error("prompt requires a callback");
        }

        if (!templates.inputs[options.inputType]) {
            throw new Error("invalid prompt type");
        }

        // create the input based on the supplied type
        input = $(templates.inputs[options.inputType]);

        switch (options.inputType) {
            case "text":
            case "textarea":
            case "email":
            case "date":
            case "time":
            case "number":
            case "password":
                input.val(options.value);
                break;

            case "select":
                var groups = {};
                inputOptions = options.inputOptions || [];

                if (!$.isArray(inputOptions)) {
                    throw new Error("Please pass an array of input options");
                }

                if (!inputOptions.length) {
                    throw new Error("prompt with select requires options");
                }

                each(inputOptions, function (_, option) {

                    // assume the element to attach to is the input...
                    var elem = input;

                    if (option.value === undefined || option.text === undefined) {
                        throw new Error("given options in wrong format");
                    }

                    // ... but override that element if this option sits in a group

                    if (option.group) {
                        // initialise group if necessary
                        if (!groups[option.group]) {
                            groups[option.group] = $("<optgroup/>").attr("label", option.group);
                        }

                        elem = groups[option.group];
                    }

                    elem.append("<option value='" + option.value + "'>" + option.text + "</option>");
                });

                each(groups, function (_, group) {
                    input.append(group);
                });

                // safe to set a select's value as per a normal input
                input.val(options.value);
                break;

            case "checkbox":
                var values = $.isArray(options.value) ? options.value : [options.value];
                inputOptions = options.inputOptions || [];

                if (!inputOptions.length) {
                    throw new Error("prompt with checkbox requires options");
                }

                if (!inputOptions[0].value || !inputOptions[0].text) {
                    throw new Error("given options in wrong format");
                }

                // checkboxes have to nest within a containing element, so
                // they break the rules a bit and we end up re-assigning
                // our 'input' element to this container instead
                input = $("<div/>");

                each(inputOptions, function (_, option) {
                    var checkbox = $(templates.inputs[options.inputType]);

                    checkbox.find("input").attr("value", option.value);
                    checkbox.find("label").append(option.text);

                    // we've ensured values is an array so we can always iterate over it
                    each(values, function (_, value) {
                        if (value === option.value) {
                            checkbox.find("input").prop("checked", true);
                        }
                    });

                    input.append(checkbox);
                });
                break;
        }

        // @TODO provide an attributes option instead
        // and simply map that as keys: vals
        if (options.placeholder) {
            input.attr("placeholder", options.placeholder);
        }

        if (options.pattern) {
            input.attr("pattern", options.pattern);
        }

        if (options.maxlength) {
            input.attr("maxlength", options.maxlength);
        }

        // now place it in our form
        form.append(input);

        form.on("submit", function (e) {
            e.preventDefault();
            // Fix for SammyJS (or similar JS routing library) hijacking the form post.
            e.stopPropagation();
            // @TODO can we actually click *the* button object instead?
            // e.g. buttons.confirm.click() or similar
            dialog.find(".btn-primary").click();
        });

        dialog = exports.dialog(options);

        // clear the existing handler focusing the submit button...
        dialog.off("shown.bs.modal");

        // ...and replace it with one focusing our input, if possible
        dialog.on("shown.bs.modal", function () {
            // need the closure here since input isn't
            // an object otherwise
            input.focus();
        });

        if (shouldShow === true) {
            dialog.modal("show");
        }

        return dialog;
    };

    exports.dialog = function (options) {
        options = sanitize(options);

        var dialog = $(templates.dialog);
        var innerDialog = dialog.find(".modal-dialog");
        var body = dialog.find(".modal-body");
        var buttons = options.buttons;
        var buttonStr = "";
        var callbacks = {
            onEscape: options.onEscape
        };

        if ($.fn.modal === undefined) {
            throw new Error(
                "$.fn.modal is not defined; please double check you have included " +
                "the Bootstrap JavaScript library. See http://getbootstrap.com/javascript/ " +
                "for more details."
            );
        }

        each(buttons, function (key, button) {

            // @TODO I don't like this string appending to itself; bit dirty. Needs reworking
            // can we just build up button elements instead? slower but neater. Then button
            // can just become a template too
            buttonStr += "<button data-bb-handler='" + key + "' type='button' class='btn " + button.className + "'>" + button.label + "</button>";
            callbacks[key] = button.callback;
        });

        body.find(".bootbox-body").html(options.message);

        if (options.animate === true) {
            dialog.addClass("fade");
        }

        if (options.className) {
            dialog.addClass(options.className);
        }

        if (options.size === "large") {
            innerDialog.addClass("modal-lg");
        } else if (options.size === "small") {
            innerDialog.addClass("modal-sm");
        }

        if (options.title) {
            body.before(templates.header);
        }

        if (options.closeButton) {
            var closeButton = $(templates.closeButton);

            if (options.title) {
                dialog.find(".modal-header").prepend(closeButton);
            } else {
                closeButton.css("margin-top", "-10px").prependTo(body);
            }
        }

        if (options.title) {
            dialog.find(".modal-title").html(options.title);
        }

        if (buttonStr.length) {
            body.after(templates.footer);
            dialog.find(".modal-footer").html(buttonStr);
        }


        /**
         * Bootstrap event listeners; used handle extra
         * setup & teardown required after the underlying
         * modal has performed certain actions
         */

        dialog.on("hidden.bs.modal", function (e) {
            // ensure we don't accidentally intercept hidden events triggered
            // by children of the current dialog. We shouldn't anymore now BS
            // namespaces its events; but still worth doing
            if (e.target === this) {
                dialog.remove();
            }
        });

        /*
         dialog.on("show.bs.modal", function() {
         // sadly this doesn't work; show is called *just* before
         // the backdrop is added so we'd need a setTimeout hack or
         // otherwise... leaving in as would be nice
         if (options.backdrop) {
         dialog.next(".modal-backdrop").addClass("bootbox-backdrop");
         }
         });
         */

        dialog.on("shown.bs.modal", function () {
            dialog.find(".btn-primary:first").focus();
        });

        /**
         * Bootbox event listeners; experimental and may not last
         * just an attempt to decouple some behaviours from their
         * respective triggers
         */

        if (options.backdrop !== "static") {
            // A boolean true/false according to the Bootstrap docs
            // should show a dialog the user can dismiss by clicking on
            // the background.
            // We always only ever pass static/false to the actual
            // $.modal function because with `true` we can't trap
            // this event (the .modal-backdrop swallows it)
            // However, we still want to sort of respect true
            // and invoke the escape mechanism instead
            dialog.on("click.dismiss.bs.modal", function (e) {
                // @NOTE: the target varies in >= 3.3.x releases since the modal backdrop
                // moved *inside* the outer dialog rather than *alongside* it
                if (dialog.children(".modal-backdrop").length) {
                    e.currentTarget = dialog.children(".modal-backdrop").get(0);
                }

                if (e.target !== e.currentTarget) {
                    return;
                }

                dialog.trigger("escape.close.bb");
            });
        }

        dialog.on("escape.close.bb", function (e) {
            if (callbacks.onEscape) {
                processCallback(e, dialog, callbacks.onEscape);
            }
        });

        /**
         * Standard jQuery event listeners; used to handle user
         * interaction with our dialog
         */

        dialog.on("click", ".modal-footer button", function (e) {
            var callbackKey = $(this).data("bb-handler");

            processCallback(e, dialog, callbacks[callbackKey]);
        });

        dialog.on("click", ".bootbox-close-button", function (e) {
            // onEscape might be falsy but that's fine; the fact is
            // if the user has managed to click the close button we
            // have to close the dialog, callback or not
            processCallback(e, dialog, callbacks.onEscape);
        });

        dialog.on("keyup", function (e) {
            if (e.which === 27) {
                dialog.trigger("escape.close.bb");
            }
        });

        // the remainder of this method simply deals with adding our
        // dialogent to the DOM, augmenting it with Bootstrap's modal
        // functionality and then giving the resulting object back
        // to our caller

        $(options.container).append(dialog);

        dialog.modal({
            backdrop: options.backdrop ? "static" : false,
            keyboard: false,
            show: false
        });

        if (options.show) {
            dialog.modal("show");
        }

        // @TODO should we return the raw element here or should
        // we wrap it in an object on which we can expose some neater
        // methods, e.g. var d = bootbox.alert(); d.hide(); instead
        // of d.modal("hide");

        /*
         function BBDialog(elem) {
         this.elem = elem;
         }

         BBDialog.prototype = {
         hide: function() {
         return this.elem.modal("hide");
         },
         show: function() {
         return this.elem.modal("show");
         }
         };
         */

        return dialog;

    };

    exports.setDefaults = function () {
        var values = {};

        if (arguments.length === 2) {
            // allow passing of single key/value...
            values[arguments[0]] = arguments[1];
        } else {
            // ... and as an object too
            values = arguments[0];
        }

        $.extend(defaults, values);
    };

    exports.hideAll = function () {
        $(".bootbox").modal("hide");

        return exports;
    };


    /**
     * standard locales. Please add more according to ISO 639-1 standard. Multiple language variants are
     * unlikely to be required. If this gets too large it can be split out into separate JS files.
     */
    var locales = {
        bg_BG: {
            OK: "Ок",
            CANCEL: "Отказ",
            CONFIRM: "Потвърждавам"
        },
        br: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Sim"
        },
        cs: {
            OK: "OK",
            CANCEL: "Zrušit",
            CONFIRM: "Potvrdit"
        },
        da: {
            OK: "OK",
            CANCEL: "Annuller",
            CONFIRM: "Accepter"
        },
        de: {
            OK: "OK",
            CANCEL: "Abbrechen",
            CONFIRM: "Akzeptieren"
        },
        el: {
            OK: "Εντάξει",
            CANCEL: "Ακύρωση",
            CONFIRM: "Επιβεβαίωση"
        },
        en: {
            OK: "OK",
            CANCEL: "Cancel",
            CONFIRM: "OK"
        },
        es: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Aceptar"
        },
        et: {
            OK: "OK",
            CANCEL: "Katkesta",
            CONFIRM: "OK"
        },
        fa: {
            OK: "قبول",
            CANCEL: "لغو",
            CONFIRM: "تایید"
        },
        fi: {
            OK: "OK",
            CANCEL: "Peruuta",
            CONFIRM: "OK"
        },
        fr: {
            OK: "OK",
            CANCEL: "Annuler",
            CONFIRM: "D'accord"
        },
        he: {
            OK: "אישור",
            CANCEL: "ביטול",
            CONFIRM: "אישור"
        },
        hu: {
            OK: "OK",
            CANCEL: "Mégsem",
            CONFIRM: "Megerősít"
        },
        hr: {
            OK: "OK",
            CANCEL: "Odustani",
            CONFIRM: "Potvrdi"
        },
        id: {
            OK: "OK",
            CANCEL: "Batal",
            CONFIRM: "OK"
        },
        it: {
            OK: "OK",
            CANCEL: "Annulla",
            CONFIRM: "Conferma"
        },
        ja: {
            OK: "OK",
            CANCEL: "キャンセル",
            CONFIRM: "確認"
        },
        lt: {
            OK: "Gerai",
            CANCEL: "Atšaukti",
            CONFIRM: "Patvirtinti"
        },
        lv: {
            OK: "Labi",
            CANCEL: "Atcelt",
            CONFIRM: "Apstiprināt"
        },
        nl: {
            OK: "OK",
            CANCEL: "Annuleren",
            CONFIRM: "Accepteren"
        },
        no: {
            OK: "OK",
            CANCEL: "Avbryt",
            CONFIRM: "OK"
        },
        pl: {
            OK: "OK",
            CANCEL: "Anuluj",
            CONFIRM: "Potwierdź"
        },
        pt: {
            OK: "OK",
            CANCEL: "Cancelar",
            CONFIRM: "Confirmar"
        },
        ru: {
            OK: "OK",
            CANCEL: "Отмена",
            CONFIRM: "Применить"
        },
        sq: {
            OK: "OK",
            CANCEL: "Anulo",
            CONFIRM: "Prano"
        },
        sv: {
            OK: "OK",
            CANCEL: "Avbryt",
            CONFIRM: "OK"
        },
        th: {
            OK: "ตกลง",
            CANCEL: "ยกเลิก",
            CONFIRM: "ยืนยัน"
        },
        tr: {
            OK: "Tamam",
            CANCEL: "İptal",
            CONFIRM: "Onayla"
        },
        zh_CN: {
            OK: "OK",
            CANCEL: "取消",
            CONFIRM: "确认"
        },
        zh_TW: {
            OK: "OK",
            CANCEL: "取消",
            CONFIRM: "確認"
        }
    };

    exports.addLocale = function (name, values) {
        $.each(["OK", "CANCEL", "CONFIRM"], function (_, v) {
            if (!values[v]) {
                throw new Error("Please supply a translation for '" + v + "'");
            }
        });

        locales[name] = {
            OK: values.OK,
            CANCEL: values.CANCEL,
            CONFIRM: values.CONFIRM
        };

        return exports;
    };

    exports.removeLocale = function (name) {
        delete locales[name];

        return exports;
    };

    exports.setLocale = function (name) {
        return exports.setDefaults("locale", name);
    };

    exports.init = function (_$) {
        return init(_$ || $);
    };

    // begin NhatMQ1
    var definition = {
        spinner: '#spinner',
        gridData: '#gridData',
        modal_backdrop: '.modal-backdrop'
    }

    exports.getCurrentDay = function () {
        return new Date().getDate();
    };

    exports.getCurrentMonth = function () {
        return (new Date).getMonth() + 1;
    };

    exports.getCurrentYear = function () {
        return new Date().getFullYear();
    };

    exports.getCurrentQuater = function () {
        return Math.floor(((common.getCurrentMonth() + 11) / 3) % 4) + 1;
    };

    exports.setFullWidth = function () {
        $('body').removeClass();
        $('body').addClass('page-header-fixed page-full-width');
        $('.page-sidebar').css('display', 'none');
    };

    exports.setFullSidebar = function () {
        $('body').removeClass();
        $('body').addClass('page-header-fixed');
    };

    exports.setMinimumSidebar = function () {
        $('body').removeClass();
        $('body').addClass('page-header-fixed page-sidebar-closed');
    };

    exports.commonInit = function () {
        exports.setAutoHight();

        var $toastrMessage = $('#toastrMessage');
        var strMessage = '';
        var arrMessage = [];

        if ($toastrMessage.val().length) {
            strMessage = $toastrMessage.val();
            arrMessage = strMessage.split(';');

            if (arrMessage[0] != '') {
                exports.showToastr(arrMessage[0], arrMessage[1], arrMessage[2], arrMessage[3]);
            }
        }
    };

    exports.showSpinner = function () {
        var $spinner = $(definition.spinner);
        $(definition.spinner).modal('show');
        $(definition.spinner).css('display', 'block');
        $(definition.spinner).addClass('show');
        $(definition.modal_backdrop).removeClass('show');
        $(definition.modal_backdrop).addClass('show');
        $("body").addClass("modal-open");
    };

    exports.hideSpinner = function () {
        var $spinner = $(definition.spinner);
        $(definition.gridData).css('display', 'block');
        $(definition.spinner).modal('hide');
        $(definition.spinner).css('display', 'none');
        $(definition.spinner).removeClass('show');
        $(definition.modal_backdrop).removeClass('show');
        $(definition.modal_backdrop).addClass('hide');
        $("body").removeClass("modal-open");
    };

    exports.showSpinnerActive = function () {
        $('#spinner_active').modal('show');
    };

    exports.hideSpinnerActive = function () {
        var delayInMilliseconds = 300; //0.3 second
        setTimeout(function () {
            $('#spinner_active').modal('hide');
        }, delayInMilliseconds);
    };

    // collapse
    exports.collapse = function (idBox) {
        var $boxTitle = $(idBox + ' .portlet-title a');
        var $boxBody = $(idBox + ' .portlet-body');
        if ($boxTitle.hasClass('collapse')) {
            $boxTitle.removeClass('collapse').addClass('expand');
            $boxBody.css('display', 'none');
        }
    }

    // expand
    exports.expand = function (idBox) {
        var $boxTitle = $(idBox + ' .portlet-title a');
        var $boxBody = $(idBox + ' .portlet-body');
        if ($boxTitle.hasClass('expand')) {
            $boxTitle.removeClass('expand').addClass('collapse');
            $boxBody.css('display', 'block');
        }

    };

    //set auto height content
    exports.setAutoHight = function () {
        //debugger;
        var maxHeight = screen.height;
        //hoavd2:03062020: Tam thoi rao lai
        if (maxHeight != null) {
            maxHeight = maxHeight - 400;
            // $('.page-content').css('min-height', maxHeight + 'px');
            $('.page-content').css('min-height', 650 + 'px');
        }
    };

    // get title
    exports.titleContent = function (iconClass, content) {
        var _iconClass = '<i class="icon-warning-sign"></i> ';
        if (iconClass) {
            _iconClass = '<i class="' + iconClass + '"></i> ';
        }

        return _iconClass + content;
    };

    // get lable
    exports.labelContent = function (iconClass, content) {
        var _iconClass = '';
        //debugger;
        if (iconClass) {
            _iconClass = '<i class="' + iconClass + '"></i> ';
        }

        return _iconClass + content;
    };

    // get conent message
    exports.messageContent = function (iconClass, iconSize, character, content) {
        var _iconClass = '';
        var _character = '';
        var _iconSize = '';

        if (character) {
            _character = character;
        }

        _iconSize = getIconSize(iconSize);

        if (iconClass) {
            _iconClass = '<i class="' + iconClass + _iconSize + '">' + _character + '</i> ';
        } else {
            _iconClass = '<i class= "icon-ok-sign ' + _iconSize + '">' + _character + '</i> ';
        }

        console.log(_iconClass + content);
        return _iconClass + content;
    };

    // alert default error!
    exports.alertDefaultError = function () {
        common.dialog({
            message: '<i class="icon-frown fa-3x">!</i> Lỗi hệ thống: xin vui lòng liên hệ IT Service Desk để được trợ giúp.',
            title: '<i class="icon-warning-sign"></i> Lỗi',
            buttons: {
                error: {
                    label: '<i class="icon-ok"></i> OK',
                    className: 'btn red'
                }
            }
        });
    };

    // alert message with params
    exports.alertMessage = function (iconTitle, iconContent, iconSize, character, title, message) {
        var _iconTitle = '';
        var _iconContent = '';
        var _character = '';
        var _iconSize = '';

        if (character) {
            _character = character;
        }

        _iconSize = getIconSize(iconSize);

        if (iconContent != null) {
            _iconContent = iconContent + ' fa-3x';
        } else {
            _iconContent = 'icon-info-sign fa-3x';
        }

        if (iconTitle != null) {
            _iconTitle = iconTitle;
        } else {
            _iconTitle = 'icon-warning-sign';
        }

        common.dialog({
            message: exports.messageContent(_iconContent, _iconSize, _character, message),
            title: exports.titleContent(_iconTitle, title),
            buttons: {
                alert: {
                    label: '<i class="icon-ok"></i> OK',
                    className: 'btn-primary'
                }
            }
        });
    };

    // confirm dialog
    exports.confirm = function (iconTitle, iconContent, iconSize, titleContent, messageContent) {
        //exports.confirm = function() {
        var options;
        options = mergeDialogOptions("confirm", ["cancel", "confirm"], ["message", "callback"], arguments);

        var _iconTitle = '';
        var _iconContent = '';
        var _iconSize = '';

        _iconSize = getIconSize(iconSize);

        if (iconContent) {
            _iconContent = iconContent + _iconSize;
        } else {
            _iconContent = 'icon-ok-sign' + _iconSize;
        }

        if (iconTitle) {
            _iconTitle = iconTitle;
        } else {
            _iconTitle = 'icon-warning-sign';
        }

        return exports.dialog({
            message: common.messageContent(iconContent, iconSize, null, messageContent),
            title: common.titleContent(iconTitle, titleContent),
            buttons: {
                confirm: {
                    label: common.labelContent('icon-ok', 'OK'),
                    className: "btn green",
                    callback: function () {
                        return options.callback.call(this, true);
                    }
                },
                cancel: {
                    label: common.labelContent('icon-ban-circle', 'Cancel'),
                    className: "btn yellow",
                    callback: function () {
                        return options.callback.call(this, false);
                    }
                }
            }
        });
    };

    function getIconSize(iconSize) {
        var _iconSize = '';
        switch (iconSize) {
            case 'S':
                return ' fa-1x';
                break;
            case 'M':
                return ' fa-2x';
                break;
            case 'L':
                return ' fa-3x';
                break;
            case 'B':
                return ' fa-4x';
                break;
            default:
                return ' fa-1x';
                break;
        }
    }

    exports.showToastr2 = function (strMessage) {
        var arrMessage = [];
        if (strMessage.length) {
            arrMessage = strMessage.split(';');
            if (arrMessage[0] != '') {
                exports.showToastr(arrMessage[0], arrMessage[1], arrMessage[2], arrMessage[3]);
            }
        }
    };

    //show toastr notification
    exports.showToastr = function (shortCutFunction, title, msg, position) {
        var i = -1,
            toastCount = 0,
            $toastlast,
            getMessage = function () {
                var msgs = ['Hello, some notification sample goes here',
                    '<div><input class="form-control input-small" value="textbox"/>&nbsp;<a href="http://themeforest.net/item/metronic-responsive-admin-dashboard-template/4021469?ref=keenthemes" target="_blank">Check this out</a></div><div><button type="button" id="okBtn" class="btn blue">Close me</button><button type="button" id="surpriseBtn" class="btn default" style="margin: 0 8px 0 8px">Surprise me</button></div>',
                    'Did you like this one ? :)',
                    'Totally Awesome!!!',
                    'Yeah, this is the Metronic!',
                    'Explore the power of Metronic. Purchase it now!'
                ];
                i++;
                if (i === msgs.length) {
                    i = 0;
                }

                return msgs[i];
            };

        var showDuration = 1000; // $('#showDuration');
        var hideDuration = 1000; //$('#hideDuration');
        var timeOut = 5000; //$('#timeOut');
        var extendedTimeOut = 1000; //$('#extendedTimeOut');
        var showEasing = 'swing'; // $('#showEasing');
        var hideEasing = 'linear'; //$('#hideEasing');
        var showMethod = 'fadeIn'; //$('#showMethod');
        var hideMethod = 'fadeOut'; //$('#hideMethod');
        var toastIndex = toastCount++;

        toastr.options = {
            closeButton: true,
            debug: false,
            positionClass: position,
            onclick: null
        };

        console.log(toastr.options);

        toastr.options.showDuration = showDuration;
        toastr.options.hideDuration = hideDuration;
        toastr.options.timeOut = timeOut;
        toastr.options.extendedTimeOut = extendedTimeOut;
        toastr.options.showEasing = showEasing;
        toastr.options.hideEasing = hideEasing;
        toastr.options.showMethod = showMethod;
        toastr.options.hideMethod = hideMethod;

        if (!msg) {
            msg = getMessage();
        }

        $("#toastrOptions").text("Command: toastr[" + shortCutFunction + "](\"" + msg + (title ? "\", \"" + title : '') + "\")\n\ntoastr.options = " + JSON.stringify(toastr.options, null, 2));

        var $toast = toastr[shortCutFunction](msg, title); // Wire up an event handler to a button in the toast, if it exists
        $toastlast = $toast;
        if ($toast.find('#okBtn').length) {
            $toast.delegate('#okBtn', 'click', function () {
                alert('you clicked me. i was toast #' + toastIndex + '. goodbye!');
                $toast.remove();
            });
        }
        if ($toast.find('#surpriseBtn').length) {
            $toast.delegate('#surpriseBtn', 'click', function () {
                alert('Surprise! you clicked me. i was toast #' + toastIndex + '. You could perform an action here.');
            });
        }
    };

    exports.groupTables = function (table, startIndex, total) {
        var $rows = $(table + ' tr:has(td)');
        groupTable($rows, startIndex, total);
        $(table + ' .deleted').remove();
    }

    // group Table
    function groupTable($rows, startIndex, total) {
        if (total === 0) {
            return;
        }
        var i, currentIndex = startIndex, count = 1, lst = [];
        var tds = $rows.find('td:eq(' + currentIndex + ')');
        var ctrl = $(tds[0]);
        lst.push($rows[0]);
        for (i = 1; i <= tds.length; i++) {
            if (ctrl.text() == $(tds[i]).text()) {
                count++;
                $(tds[i]).addClass('deleted');
                lst.push($rows[i]);
            } else {
                if (count > 1) {
                    ctrl.attr('rowspan', count);
                    groupTable($(lst), startIndex + 1, total - 1)
                }
                count = 1;
                lst = [];
                ctrl = $(tds[i]);
                lst.push($rows[i]);
            }
        }
    };

    exports.monthpicker = function (monthpicker) {
        $(monthpicker).datepicker({
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            dateFormat: "mm/yy",
            beforeShow: function (e, t) {
                $(this).datepicker("hide");
                $("#ui-datepicker-div").addClass("hide-calendar");
                $("#ui-datepicker-div").addClass('MonthDatePicker');
            },
            onClose: function (dateText, inst) {
                var iMonth = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var iYear = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(iYear, iMonth, 1));
            }
        });
    }

    exports.activeMenuSidebar = function (idMenu) {
        var id = $(idMenu).closest('li >a');
        $(idMenu).closest('li').addClass('active');
        $(idMenu).closest('li').parent().closest('li').removeClass();
        $(idMenu).closest('li').parent().closest('li').addClass('active open');
        $('.page-sidebar-menu .active.open >a span.arrow').addClass('open');
        $('.page-sidebar-menu .active.open >a').append('<span class="selected"></span>');
        /*$('.page-sidebar-menu > li .arrow').addClass('open');*/
    };

    exports.getUrlVars = function () {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    }

    exports.goTop = function () {
        $("html, body").animate({scrollTop: 0}, "slow");
    }

    exports.setDefaultUrl = function (defaultUrl) {
        var pathName = $(location).attr('pathname');
        var indexUrl = '#';
        if (pathName) {
            var projectName = pathName.split('/')[1];

            if (projectName && defaultUrl) {
                indexUrl = '/' + projectName + defaultUrl;
            }
        }

        $('#topLogo').attr('href', indexUrl);
    };
    exports.formartNumber = function (id) {
        var fnf = document.getElementById(id);
        fnf.addEventListener('keyup', function (evt) {
            var n = parseInt(this.value.replace(/\D/g, ''), 10);
            fnf.value = n.toLocaleString() === 'NaN' ? 0 : n.toLocaleString();
        }, false);
    }

    exports.formatMoney = function (amount, decimalCount, decimal, thousands) {
        try {
            decimalCount = Math.abs(decimalCount);
            decimalCount = isNaN(decimalCount) ? 2 : decimalCount;

            var negativeSign = amount < 0 ? "-" : "";

            var i = parseInt(amount = Math.abs(Number(amount) || 0).toFixed(decimalCount)).toString();
            var j = (i.length > 3) ? i.length % 3 : 0;

            return negativeSign + (j ? i.substr(0, j) + thousands : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");
        } catch (e) {
            console.log(e)
        }
    };
    // end NhatMQ1

    return exports;

}));

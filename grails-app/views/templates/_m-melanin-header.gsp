<%@ page import="com.commons.Constant; com.melanin.commons.*" %>
<style>
.text-icon {
    padding: 5px;
    background: #5bc2bc;
    margin-right: 10px;
}
</style>

<div id="m-melanin-header" class="header-inner">
    <!-- BEGIN LOGO -->
    <a class="navbar-brand pull-left" href="${grailsApplication.config.msb.platto.melanin.defaultUrl}" id="topLogo">
        <img id="m-melanin-logo" class="img-responsive" src="${logoURL}"
             alt="add a logo.png into web-app/images folder" height="40" width="60" style="margin: auto 0;"/>
    </a>

    <g:hiddenField id="defaultUrl" name="defaultUrl" value="${grailsApplication.config.msb.platto.melanin.defaultUrl}"/>
    <!-- END LOGO -->
    <!-- BEGIN RESPONSIVE MENU TOGGLER -->
    <a href="javascript:;" class="navbar-toggle" onclick="navbar_toggle()">
        <img src="${menuTogglerURL}" alt=""/>
    </a>
    <g:hiddenField id="defaultToggle" name="defaultToggle" value="off"/>
    <!-- END RESPONSIVE MENU TOGGLER -->
    <!-- BEGIN TOP NAVIGATION MENU -->
    <ul class="nav navbar-nav pull-right">
        <!-- BEGIN USER LOGIN DROPDOWN -->
        <li class="dropdown user" style="display: none">
            <a href="#" class="dropdown-toggle notification" data-toggle="dropdown" data-hover="dropdown"
               data-close-others="true">
                %{--<img alt="" class="img-circle" src="${avatarURL}"/>--}%

                <i class="glyphicon glyphicon-bell" style="color: #0b2c89 !important;"></i>
                <span class="badge" id="countNotify"></span>
            </a>

            <ul class="dropdown-menu" id="list-notify">
                <li><a href="#" data-toggle="modal">Không có thông tin mới !</a></li>
            </ul>
        </li>
        <li class="dropdown user">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
%{--            <img alt="" class="img-circle" src="${avatarURL}"/>--}%
                <sec:ifLoggedIn>
                    <span class="username hidden-480">
                        <sec:loggedInUserInfo field="username"/>
                    </span>
                </sec:ifLoggedIn>
                <i class="icon-angle-down"></i>
            </a>

            <ul class="dropdown-menu">
                <li><a href="#form_modal2" data-toggle="modal"><i class="icon-lock "></i> Đổi mật khẩu</a></li>
                <!-- <li><a href="${Conf.findByLabel('help-file-url') ? Conf.findByLabel('help-file-url').value : '#'}"><i class="icon-envelope m-melanin-change-password-trigger"></i> Hướng dẫn</a></li>  -->
                <li><a href="#" id="m-melanin-logout"><i class="icon-key"></i> Thoát</a></li>
            </ul>
        </li>

        <li style="display: none">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
               aria-expanded="false"><g:message code="languages"/> <span class="caret"></span></a>

            <ul class="dropdown-menu">
                <navBar:localeDropdownListItems uri="${request.forwardURI}"/>
            </ul>
        </li>


        <li class="dropdown user" style="display: block;">
            <div style="margin-top:17px;">
                <a href="${createLink(controller: 'direct', action: 'downloadFileHDSD')}" class=""
                   title="Tải xuống hướng dẫn sử dụng">
                    <i class="icon-question-sign" style="color: #0b2c89 !important;"></i>
                </a>
            </div>
        </li>

        <li class="dropdown user" style="display: block;">
            <div style="margin-top:17px;">
                (<span id="m-melanin-time-out"></span>, <a href="#" id="m-melanin-refresh-timeout">refresh</a>)
            </div>
        </li>
        <!-- END USER LOGIN DROPDOWN -->
    </ul>
    %{--<g:hiddenField name="m-melanin-time-out"/>--}%
    <!-- END TOP NAVIGATION MENU -->
    <div id="m-melanin-app-descriptions" class="hor-menu hidden-xs">${appDescriptions}</div>

    <div class="pull-right">
        <sec:ifLoggedIn>
            <g:if test="${grailsApplication.config.msb.platto.melanin.searchController}">
                <div id="m-melanin-global-search">

                </div>
            </g:if>

            <g:else>
                <g:if env="development"><div id="m-melanin-global-search">
                    <a class="right" href="#"
                       onclick="javascript:alert('To enable this global search box, pass showSearchBox param to the m-melanin-header template in your main.gsp.');
                       return false;">
                        Global search is disabled.</a></div>
                </g:if>
            </g:else>
        </sec:ifLoggedIn>
    </div>

    <div id="form_modal2" class="modal fade in" role="dialog" aria-hidden="true">
        <div class="modal-dialog" style="width: 600px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">Đổi password</h4>
                </div>

                <div class="modal-body">
                    <g:form name="m-melanin-change-password-form" action="changePassword" controller="melanin"
                            class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-md-4">Nhập password cũ <span class="required">*</span>
                            </label>

                            <div class="col-md-8">
                                <g:passwordField id="m-melanin-old-password" name="oldPassword" data-required="1"
                                                 class="form-control" required="true"/>
                                <span class="help-block">Nhập password truy cập được cấp vào phần mềm này.</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-4">Nhập password mới <span class="required">*</span>
                            </label>

                            <div class="col-md-8">
                                <g:passwordField id="m-melanin-new-password" name="newPassword" class="form-control"
                                                 required="true"/>
                                <span class="help-block">Nhập password mới.</span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-md-4">Nhập lại password <span class="required">*</span>
                            </label>

                            <div class="col-md-8">
                                <g:passwordField id="retypePassword" name="retypePassword" class="form-control "/>
                                <span class="help-block">Nhập lại password mới.</span>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <a href="#" class="btn green" id="m-melanin-change-password-confirm-button"><i
                                    class="icon-ok"></i> OK</a>
                            <a href="#" class="btn yellow" data-dismiss="modal" aria-hidden="true"
                               id="m-melanin-change-password-cancel-button"><i class="icon-ban-circle"></i> Cancel</a>
                        </div>

                    </g:form>
                </div>
            </div>
        </div>
    </div>
    <script>
        function viewNotify(id, link) {
            $.ajax({
                type: "POST",
                data: {id: id},
                async: true,
                url: "${createLink(controller:'notification',action:'viewNotify')}",
                success: function (data) {
                    window.location.href = link
                },
                error: function (jqXHR, textStatus, errorThrown) {
                }
            });
        }

        %{--function loadNotify() {--}%
        %{--    $.ajax({--}%
        %{--        type: "POST",--}%
        %{--        async: true,--}%
        %{--        url: "${createLink(controller:'notification',action:'getcount_notify')}",--}%
        %{--        success: function (data) {--}%
        %{--            $("#countNotify").html(data.number === 0 ? '' : data.number);--}%
        %{--            if (data.list) {--}%
        %{--                var html = "";--}%
        %{--                $.each(data.list, function (key, val) {--}%
        %{--                    html += '<li><a href="javascript:void(0)" onclick="viewNotify(' + val.id + ', ' + "'" + val.linkPage + "'" + ')"><span  class="text-icon">' + val.typeNotify + '</span > ' + val.titleNotify + '</a></li>';--}%
        %{--                });--}%
        %{--                $("#list-notify").html(html)--}%
        %{--            }--}%
        %{--        },--}%
        %{--        error: function (jqXHR, textStatus, errorThrown) {--}%
        %{--        }--}%
        %{--    });--}%
        %{--}--}%
    </script>

    <sec:ifLoggedIn>
        <script type="text/javascript" charset="utf-8">
            var TIME_OUT = ${grailsApplication.config.msb.platto.melanin.appTimeOut};
            var mMelaninTimeOut = TIME_OUT;
            var timeOutInterval = setInterval('changeTimeOut()', 1000);
            var timeOutInterval2 = setInterval('keep_login_session_alive()', 120000);

            //            function changeTimeOut() {
            //                refreshTimeOut();
            //            }

            function changeTimeOut() {
                if (mMelaninTimeOut == 0) {
                    document.location = "${createLink(controller:'logout')}";
                    jquery_alert('Thông báo', 'Bạn đã bị log out khỏi phần mềm. Xin vui lòng <strong><u>lưu lại các dữ liệu đang xử lý vào file word bên ngoài</u></strong> và login lại.');
                    clearInterval(timeOutInterval);
                    clearInterval(timeOutInterval2);
                    return;
                }
                $("#m-melanin-time-out").html(mMelaninTimeOut--);
                if (mMelaninTimeOut == 60) {
                    alert('Chú ý! Bạn sắp hết thời gian của tab này!');
                    common.dialog({
                        message: 'Bạn sẽ tự động bị log out ra khỏi hệ thống trong vòng 60 giây nữa, bạn có muốn thêm thời gian không?',
                        title: '<i class="icon-warning-sign"></i> Thông báo',
                        buttons: {
                            comfirm: {
                                label: '<i class="icon-ok"></i> OK',
                                className: 'btn red',
                                callback: function () {
                                    refreshTimeOut();
                                }
                            },
                            cancel: {
                                label: '<i class="icon-ban-circle"></i> Cancel',
                                className: 'btn yellow'
                            }
                        }
                    });
                }
            }

            function refreshTimeOut() {
                $.get("${createLink(controller:'melanin',action:'refresh')}", function (data) {
                    if (data === '1' || data === 1) {
                        mMelaninTimeOut = TIME_OUT;
                    } else {
                        document.location = "${createLink(controller:'melanin',action:'logout')}";
                        common.showToastr('warning', 'Thông báo', 'Bạn đã bị log out!', 'toast-top-right');
                    }
                });
            }

            //giữ các session login k bị logout
            function keep_login_session_alive() {
                $.get("${createLink(controller:'melanin',action:'keep_login_session')}", function (data) {
                    if (data === '1' || data === 1) {
                        console.log('keep login...');
                    } else {
                        document.location = "${createLink(controller:'melanin',action:'logout')}";
                        common.showToastr('warning', 'Thông báo', 'Bạn đã bị log out!', 'toast-top-right');
                    }
                });
            }

            $(document).ready(function () {
                %{--<sec:ifLoggedIn>--}%
                %{--setInterval(function () {--}%
                %{--loadNotify()--}%
                %{--}, 500000000);--}%
                %{--</sec:ifLoggedIn>--}%
                $("#lang_en").live('click', function () {
                    var link = $(location).attr('href');
                    if (link.indexOf('?') > 0) {
                        if (link.indexOf('lang=en') > 0) {
                            window.location = link
                        } else if (link.indexOf('lang=vi') > 0) {
                            window.location = link.replace('=vi', '=en')
                        } else {
                            window.location = link + '&lang=en'
                        }
                    } else {
                        window.location = link + '?lang=en'
                    }
                });
                $("#lang_vi").live('click', function () {
                    var link = $(location).attr('href');
                    if (link.indexOf('?') > 0) {
                        if (link.indexOf('lang=vi') > 0) {
                            window.location = link
                        } else if (link.indexOf('lang=en') > 0) {
                            window.location = link.replace('=en', '=vi')
                        } else {
                            window.location = link + '&lang=en'
                        }
                    } else {
                        window.location = link + '?lang=vi'
                    }
                })
                // setTimeout(function () {
                //     loadNotify();
                // }, 2000)

            });

            $(function () {
                //search key: melanin_validate
                //melanin_validate.change_password();

                $("#m-melanin-change-password-dialog").dialog({
                    modal: true,
                    'autoOpen': false,
                    width: "55%",
                    height: "auto"
                });
                $(".m-melanin-change-password-trigger").click(function () {
                    $("#m-melanin-change-password-dialog").dialog('open');

                    //return false;
                });

                $("#m-melanin-change-password-cancel-button").click(function () {
                    //debugger;
                    $("#m-melanin-change-password-dialog").dialog('close');
                    //return false;
                });
                $("#m-melanin-change-password-confirm-button").click(function () {
                    if ($("form[name=m-melanin-change-password-form]").validate()) {
                        $.post('${createLink(controller:'melanin',action:'changePassword')}', $("#m-melanin-change-password-form").serialize(),
                            function (result) {
                                if (result == 1) {
                                    $('#form_modal2').modal('hide');
                                    common.showToastr('success', 'Thông báo', 'Password đã được đổi thành công.', 'toast-top-right');
                                } else {
                                    common.showToastr('warning', 'Thông báo', 'Password cũ không chính xác, xin vui lòng nhập lại.', 'toast-top-right');
                                    $('#m-melanin-old-password').focus();
                                }
                            });
                    }
                    //return false;
                });

                $("#m-melanin-refresh-timeout").click(function () {
                    refreshTimeOut();
                    return false;
                });
                $("#m-melanin-logout").click(function () {
                    //jquery_confirm('Xác nhận','Bạn có muốn logout khỏi chương trình này?',function(){
                    document.location = "${createLink(controller:'melanin',action:'logout')}";
//                    window.localStorage.setItem('logged_in', false);
                    //});
                    //return false;
                });
            });

            function navbar_toggle() {
                var defaultToggle = $("#defaultToggle").val()
                if (defaultToggle == "off") {
                    $(".page-sidebar").addClass("in");
                    $(".page-sidebar").removeClass("collapse");
                    $("#defaultToggle").val("on")
                } else {
                    $(".page-sidebar").removeClass("in");
                    $(".page-sidebar").addClass("collapse");
                    $("#defaultToggle").val("off")
                }

            }
        </script>
    </sec:ifLoggedIn>
</div>

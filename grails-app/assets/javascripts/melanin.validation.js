/**
 * Created by nhatmq1 on 12/22/2015.
 */

var errorMsg = $('.alert-danger');
jQuery.validator.addClassRules({
    requiredz: {
        required: true
    },
    numberz: {
        number: true,
        maxlength: 20
    },
    percenz: {
        number: true,
        maxlength: 3
    },
    vnDatez: {
        vnDate: true
    }
});
melanin_validate = {
    jobtitle: function () {

        $('#m-melanin-form-jobTitle-details').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rule: {
                name: 'required'
            },

            messages: {
                name: 'Vui lòng nhập tên chức danh.'
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                App.scrollTo(errorMsg, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }
        });
    },

    requestmap: function () {
        $('form[name=m-melanin-form-requestmap-details]').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rule: {
                url: 'required',
                configAttribute: 'required'
            },

            messages: {
                url: 'Vui lòng nhập url.',
                configAttribute: 'Vui lòng nhập configAttribute.'
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                App.scrollTo(errorMsg, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }
        });
    },

    role_validate: function () {
        $('form[name=m-melanin-form-role-details]').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rule: {
                authority: 'required',
                rolename: 'required',
                roleGroup: 'required',
                active: 'required'
            },

            messages: {
                authority: 'Vui lòng nhập giá trị',
                rolename: 'Vui lòng nhập giá trị',
                roleGroup: 'Vui lòng nhập giá trị',
                active: 'Vui lòng nhập giá trị'
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                App.scrollTo(errorMsg, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }

        });
    },

    branch: function () {
        $('#branch-form').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rule: {
                authority: 'required',
            },

            messages: {
                authority: 'Vui lòng nhập authority.',
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                App.scrollTo(errorMsg, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }

        })
    },

    user: function () {
        var form = $('form[name=m-melanin-form-user-details]');

        $('form[name=m-melanin-form-user-details]').validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            rules: {
                branchID: 'required',
                username: 'required',
                fullname: 'required',
                maNhanVien: 'required',
                chucVu: 'required',
                email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                branchID: 'Vui lòng chọn đơn vị.',
                username: 'Vui lòng nhập user name.',
                fullname: 'Vui lòng nhập full name.',
                email: 'Vui lòng nhập đúng định dạng email'
            },

            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                App.scrollTo(errorMsg, -200);
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }
        })
    },

    change_password: function () {
        $("form[name=m-melanin-change-password-form]").validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",

            rules: {
                newPassword: "required",
                retypePassword: {
                    equalTo: "#m-melanin-new-password"
                }
            },
            messages: {
                oldPassword: 'Vui lòng nhập mật khẩu cũ.',
                newPassword: 'Vui lòng nhập mật khẩu mới.',
                retypePassword: {
                    equalTo: 'Xác nhận mật khẩu phải trùng với mật khẩu mới.'
                },
            },

            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            }
        });
    },
    valid_form: function (formname) {
        $(formname).validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            errorPlacement: function(error, element) {
                if(element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            },
            ignore: "",
            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                alertMsg.setAlertErrorMsg();
                App.scrollTo(errorMsg, -200);
            },
            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            },
            rules: {
                email: {
                    email: true
                }
            },
            messages: {
                email: 'Vui lòng nhập đúng định dạng email'
            },

            submitHandler: function (form) {
                form.submit();
            }
        });
    },
    valid_timkiemKh: function (formname) {
        $(formname).validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                alertMsg.setAlertErrorMsg();
                App.scrollTo(errorMsg, -200);
            },
            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            },
            rules: {
                msThue: {
                    required: function (element) {
                        return ($('#maCic').val().length == 0) && ($('#dkkd').val().length == 0) && $('#loaiKh').val() == 'P';
                    }
                },
                dkkd: {
                    required: function (element) {
                        return ($('#maCic').val().length == 0) && ($('#msThue').val().length == 0) && $('#loaiKh').val() == 'P';
                    }
                },
                soCmt: {
                    required: function (element) {
                        return ($('#maCic').val().length == 0) && $('#loaiKh').val() == 'T';
                    }
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    },
    valid_timkiemKhChung: function (formname) {
        $(formname).validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "",
            invalidHandler: function (event, validator) { //display error alert on form submit
                errorMsg.show();
                alertMsg.setAlertErrorMsg();
                App.scrollTo(errorMsg, -200);
            },
            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            },
            rules: {
                msThue: {
                    required: function (element) {
                        return  ($('#dkkd').val().length == 0) && $('#loaiKh').val() == 'P';
                    }
                },
                dkkd: {
                    required: function (element) {
                        return ($('#msThue').val().length == 0) && $('#loaiKh').val() == 'P';
                    }
                },
                soCmt: {
                    required: function (element) {
                        return $('#loaiKh').val() == 'T';
                    }
                }
            },
            submitHandler: function (form) {
                form.submit();
            }
        });
    }
}
alertMsg = {
    setAlertErrorMsg: function () {
        errorMsg.html('');
        errorMsg.append('<button class="close" data-dismiss="alert"></button>  Lỗi validate dữ liệu. Vui lòng kiểm tra phía dưới!')
    }
}


/**
 * Created by lamnt3 on 11/3/2016.
 */
validz = {
    valid_form_timkiem: function () {
        $('#form_timkiem').validate({
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
                user: {
                    required: true
                },
                module:{
                    required: true
                }
            },
            messages: {
                user: {
                    required: "This field is required."
                },
                module: {
                    required: "This field is required."
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
        //errorMsg.text(' Lỗi validate dữ liệu. Vui lòng kiểm tra phía dưới!');
        errorMsg.html('');
        errorMsg.append('<button class="close" data-dismiss="alert"></button>  Lỗi validate dữ liệu. Vui lòng kiểm tra phía dưới!')
    }
}
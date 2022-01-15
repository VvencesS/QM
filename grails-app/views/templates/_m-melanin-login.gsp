<g:form id="loginForm" controller='${postUrl ?: "/login/authenticate"}' method='POST' name='m-melanin-login-form'
        style="background-color: rgba(255, 255, 255, 0.3);padding: 10px; border: 1px solid silver; margin-top:120px;"
        url='${postUrl ?: request.contextPath + "/login/authenticate"}'>
    <h3 class="form-title" style="font-weight: bold !important; color: #fff;">ĐĂNG NHẬP</h3>

    <div class="alert alert-error hide">
        <button class="close" data-dismiss="alert"></button>
        <span>Enter any username and password.</span>
    </div>

    <div style="display:none">
        <g:if test="${params.login_error}">
            <li><div id="loginMessage" class="alert-message error">Thông tin bạn nhập không chính xác.</div></li>
        </g:if>
        <g:if env="development">
            <li><div class="alert-message info">Login info: admin/admin, developer/developer</div></li>
        </g:if>
    </div>

    <div class="form-group">
        <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
        <label class="control-label visible-ie8 visible-ie9">Mã truy cập</label>

        <div class="input-icon">
            <i class="icon-user"></i>
            <g:textField placeholder="${message(code: 'login.taikhoandangnhap')}" type="text" name="${usernameParameter ?: 'username'}"
                         class=" form-control placeholder-no-fix validate[required]" autocomplete="off"
                         oninput="this.value = this.value.toLowerCase()"/>
        </div>
    </div>

    <div class="form-group">
        <label class="control-label visible-ie8 visible-ie9">Mật khẩu</label>

        <div class="input-icon">
            <i class="icon-lock"></i>
            <g:passwordField placeholder="${message(code: 'login.matkhau')}" name="${passwordParameter ?: 'password'}" type="password"
                             class="form-control validate[required]"/>
        </div>
    </div>

    <div class="form-actions" style="background-color: rgba(255, 255, 255, 0.3);border-top: none;">
        <label class="checkbox" style="float:left; color: white">
            <input type="checkbox" name="${rememberMeParameter ?: 'remember-me'}" value="1"/> Ghi nhớ mật khẩu
        </label>
        <button type="submit" class="btn red pull-right" name="m-melanin-login-button" style="width:-webkit-fill-available; width:-moz-available">
            Login <i class="m-icon-swapright m-icon-white"></i>
        </button>
    </div>
</g:form>

<script type="text/javascript" charset="utf-8">
    $(document).on('keypress',function(e) {
        if (e.which == 10 || e.which == 13) {
            // debugger;
            $('#loginForm').submit();
            //deo hieu sao no lai ko nhan lan dau tien go enter
            var delayInMilliseconds = 20000; //0.5 second
            setTimeout(function () {
                $('#loginForm').submit();
            }, delayInMilliseconds);
        }
    });

    $(function () {
        // $('form').each(function () {
        //     $(this).find('input').keypress(function (e) {
        //         // Enter pressed?
        //         if (e.which == 10 || e.which == 13) {
        //             // debugger;
        //             // common.showSpinner();
        //             var delayInMilliseconds = 500; //0.3 second
        //             setTimeout(function () {
        //                 // this.form.submit();
        //                 $('#loginForm').submit();
        //             }, delayInMilliseconds);
        //         }
        //     });
        // });

        var $loginMesage = $('#loginMessage');

        if ($loginMesage.html() != undefined) {
            common.showToastr('error', 'Thông báo', $loginMesage.html(), 'toast-top-right');
        }

        $("form[id=m-melanin-login-form]").validationEngine();
        %{--$("#m-melain-login-help").click(function () {--}%
        %{--    common.alertMessage(null, null, 'Trợ giúp', 'Xin vui lòng đọc hướng dẫn sử dụng tại ' +--}%
        %{--        "<a href='${grailsApplication.config.msb.platto.melanin.helpDocument}'>địa chỉ này</a> hoặc liên hệ IT Service Desk để được hổ trợ thêm.");--}%
        %{--    return false;--}%
        %{--})--}%
    });
</script>
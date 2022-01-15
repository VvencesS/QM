<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    %{--        <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>--}%
    <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}"/></title>
    <g:render template="/templates/m-melanin-html-head" model="[theme: 'ui-lightness']"/>

    <g:layoutHead/>
</head>

<body class="page-header-fixed" style="background: #fff;">
<!-- BEGIN HEADER -->
<div class="header navbar navbar-inverse navbar-fixed-top">
    <g:render template="/templates/m-melanin-header-login"
              model="${[logoURL        : resource(dir: 'images', file: 'logomsb.png'),
                        avatarURL      : resource(dir: 'images', file: 'avatar.jpg'),
                        menuTogglerURL : resource(dir: 'images', file: 'menu-toggler.png'),
                        appDescriptions: grailsApplication.config.msb.platto.melanin.appDescription]}"/>
    <div class="tam-hotline pull-right">
        <span class="text-black">Điện thoại hỗ trợ:<br>Email:</span>

        <span class="phone-number text-active"><strong>${grailsApplication.config.msb.platto.melanin.appContactPhone}<br> <a
                href="mailto:${grailsApplication.config.msb.platto.melanin.appContactEmail}">${grailsApplication.config.msb.platto.melanin.appContactEmail}</a>
        </strong>
        </span>
    </div>
</div>
<!-- END HEADER -->
<div class="clearfix"></div>


<section class="login-page">
    <div class="fullscreen-template" id="slider-wrapper">
        <!-- masterslider -->
        <div class="master-slider ms-skin-default" id="main-slider">
            <img src="${resource(dir: 'images', file: 'bg.jpg')}" alt="Cover login"/>
        </div>
        <!-- end of masterslider -->
    </div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-md-8">
            </div>

            <div class="col-md-3">
                <g:render template="/templates/m-melanin-login"/>
            </div>
        </div>
    </div>
</section>
<!-- BEGIN BODY -->
%{--    	<div class="page-container">--}%
%{--    		<div class="page-content" style="margin-left:0; padding:0px;">--}%
%{--    			<g:layoutBody />--}%
%{--    		</div>--}%

%{--    	</div>--}%

<!-- END BODY -->
<!-- BEGIN FOOTER -->
<div class="footer footer-fixed-bottom" style="background-color:#37383c">
    <div class="footer-inner">
        &copy; ${com.melanin.commons.Conf.findByLabel('copyright').value}
    </div>

    <div class="footer-tools">
        <span class="go-top">
            <i class="icon-angle-up"></i>
        </span>
    </div>
</div>


<!-- END CORE PLUGINS -->
<asset:javascript src="assets/scripts/app.js"/>
<script>
    jQuery(document).ready(function () {
        $('.navbar-nav').css('display', 'none');
        App.init();
    });
</script>

</body>
</html>
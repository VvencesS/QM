<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>
		<g:render  template="/templates/m-melanin-html-head" model="[theme:'ui-lightness']"/>
		<g:layoutHead />
    </head>
    <body class="page-header-fixed">
    	<!-- BEGIN HEADER -->
    	<div class="header navbar navbar-inverse navbar-fixed-top">
		<g:render  template="/templates/m-melanin-header"
				   model="${[	logoURL:resource(dir:'images',file:'logomsb.png'),
								 avatarURL:resource(dir:'images',file:'avatar.jpg'),
								 menuTogglerURL:resource(dir:'images',file:'menu-toggler.png'),
								 appDescriptions:grailsApplication.config.msb.platto.melanin.appDescription]}"/>
		</div>
    	<!-- END HEADER -->
    	
    	<!-- BEGIN MENU -->
    	<div class="hor-menu hidden-sm hidden-xs">
    	</div>
    	<!-- END MENU -->
    	
    	<div class="clearfix"></div>
    	<!-- BEGIN BODY -->
    	<div class="page-container">
    		
    	<g:layoutBody />
    	</div>
    	
    	<!-- END BODY -->
    	
    	<!-- BEGIN FOOTER -->
    	<div class="footer">
                <div class="footer-inner">
                        2020 © TNTech.
                </div>
                <div class="footer-tools">
                        <span class="go-top">
                        <i class="icon-angle-up"></i>
                        </span>
                </div>
        </div>
       
	</body>
</html>
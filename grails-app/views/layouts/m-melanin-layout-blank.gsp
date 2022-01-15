<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>
		<g:render template="/templates/m-melanin-html-head" model="[theme:'ui-lightness']"/>
		<g:layoutHead />
    </head>
    <body>
		<div id="m-melanin-page-wrap" class="m-melanin">
			<g:layoutBody />
	
		</div>
		
		<div id="load_spinner" title="Processing..." class="center margin-10" >
		    <center>
		        Please wait while your request is being processed...<br/>
		        <img alt="spinner" src="${resource(dir:'images',file:'loading.gif')}"/></center>
		</div>
	</body>
</html>
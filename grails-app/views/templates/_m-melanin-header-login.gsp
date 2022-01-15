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

    %{--<g:hiddenField name="m-melanin-time-out"/>--}%
    <!-- END TOP NAVIGATION MENU -->
    <div id="m-melanin-app-descriptions" class="hor-menu hidden-xs">${appDescriptions}</div>
</div>

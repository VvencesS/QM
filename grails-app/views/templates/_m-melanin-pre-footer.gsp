<%@page import="com.melanin.commons.*" %>

<div class="page-prefooter">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12 footer-block">
                <h2>About</h2>
                <p>${grailsApplication.config.msb.platto.melanin.appAbout}</p>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12 footer-block">
                <h2>Follow Us On</h2>
                <ul class="social-icons">
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnRss}" target="_blank" data-original-title="rss" class="rss"></a>
                    </li>
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnFacebook}" target="_blank" data-original-title="facebook" class="facebook"></a>
                    </li>
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnTwiter}" target="_blank" data-original-title="twitter" class="twitter"></a>
                    </li>
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnGoogleplus}" target="_blank" data-original-title="googleplus" class="googleplus"></a>
                    </li>
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnLinkedIn}" target="_blank" data-original-title="linkedin" class="linkedin"></a>
                    </li>
                    <li>
                        <a href="${grailsApplication.config.msb.platto.melanin.appFlowUsOnYouTube}" target="_blank" data-original-title="youtube" class="youtube"></a>
                    </li>
<%--                    <li>--%>
<%--                        <a href="javascript:;" data-original-title="vimeo" class="vimeo"></a>--%>
<%--                    </li>--%>
                </ul>
            </div>
            <div class="col-md-3 col-sm-6 col-xs-12 footer-block">
                <h2>Contacts</h2>
                <address class="margin-bottom-40">
                    Phone: ${grailsApplication.config.msb.platto.melanin.appContactPhone}<br>
                    Email: <a href="mailto:${grailsApplication.config.msb.platto.melanin.appContactEmail}">${grailsApplication.config.msb.platto.melanin.appContactEmail}</a>
                </address>
            </div>
        </div>
    </div>
</div>
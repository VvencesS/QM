<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>
</head>
<body>
<content tag="nav">
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Application Status <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li class="dropdown-item"><a href="#">Environment: ${grails.util.Environment.current.name}</a></li>
            <li class="dropdown-item"><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>
            <li class="dropdown-item"><a href="#">App version:
                <g:meta name="info.app.version"/></a>
            </li>
            <li role="separator" class="dropdown-divider"></li>
            <li class="dropdown-item"><a href="#">Grails version:
                <g:meta name="info.app.grailsVersion"/></a>
            </li>
            <li class="dropdown-item"><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
            <li class="dropdown-item"><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
            <li role="separator" class="dropdown-divider"></li>
            <li class="dropdown-item"><a href="#">Reloading active: ${grails.util.Environment.reloadingAgentEnabled}</a></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Artefacts <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <li class="dropdown-item"><a href="#">Controllers: ${grailsApplication.controllerClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Domains: ${grailsApplication.domainClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Services: ${grailsApplication.serviceClasses.size()}</a></li>
            <li class="dropdown-item"><a href="#">Tag Libraries: ${grailsApplication.tagLibClasses.size()}</a></li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Installed Plugins <span class="caret"></span></a>
        <ul class="dropdown-menu">
            <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                <li class="dropdown-item"><a href="#">${plugin.name} - ${plugin.version}</a></li>
            </g:each>
        </ul>
    </li>
</content>

<div class="svg" role="presentation">
    <div class="grails-logo-container">
        <asset:image src="grails-cupsonly-logo-white.svg" class="grails-logo"/>
    </div>
</div>

<div id="content" role="main">
    <section class="row colset-2-its">
        <h1>Welcome to Grails</h1>

        <p>
            Congratulations, you have successfully started your first Grails application! At the moment
            this is the default page, feel free to modify it to either redirect to a controller or display
            whatever content you may choose. Below is a list of controllers that are currently deployed in
            this application, click on each to execute its default action:
        </p>

        <div id="controllers" role="navigation">
            <h2>Available Controllers:</h2>
            <ul>
                <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
                    <li class="controller">
                        <g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link>
                    </li>
                </g:each>
            </ul>
        </div>
    </section>
</div>

</body>
</html>








<NOIDUNG_BANTLTIN>
    <TT_NGUOITRACUU>
        <DONVITRACUU>
        </DONVITRACUU>
        <DIACHI>
        </DIACHI>
        <TENTRUYCAP>
        </TENTRUYCAP>
        <DTHOAI>
        </DTHOAI>
        <MSPHIEU>
        </MSPHIEU>
        <THOIGIANYC>
        </THOIGIANYC>
        <THOIGIANTL>
        </THOIGIANTL>
        <TT_TRALOI>
        </TT_TRALOI>
    </TT_NGUOITRACUU>
    <NOIDUNG>
        <TTPHAPLY>
            <MACIC>
            </MACIC>
            <TENKH>
            </TENKH>
            <DIACHI_TRUSOCHINH>
            </DIACHI_TRUSOCHINH>
            <CMND_HC>
            </CMND_HC>
            <GIAYTOKHAC>
            </GIAYTOKHAC>
            <DKKD>
            </DKKD>
            <MST>
            </MST>
            <TGD_GD>
            </TGD_GD>
            <NGUOI_DAIDIENPL>
            </NGUOI_DAIDIENPL>
            <QHTDHT>
            </QHTDHT>
        </TTPHAPLY>
        <CTLOAIVAY>
            <DONG>
                <LOAIVAY>
                </LOAIVAY>
                <NHOM1_VND>
                </NHOM1_VND>
                <NHOM2_VND>
                </NHOM2_VND>
                <NHOM3_VND>
                </NHOM3_VND>
                <NHOM4_VND>
                </NHOM4_VND>
                <NHOM5_VND>
                </NHOM5_VND>
                <NOXAU_KHAC_VND>
                </NOXAU_KHAC_VND>
                <NHOM1_USD>
                </NHOM1_USD>
                <NHOM2_USD>
                </NHOM2_USD>
                <NHOM3_USD>
                </NHOM3_USD>
                <NHOM4_USD>
                </NHOM4_USD>
                <NHOM5_USD>
                </NHOM5_USD>
                <NOXAU_KHAC_USD>
                </NOXAU_KHAC_USD>
            </DONG>
        </CTLOAIVAY>
        <DSTCTDQH>
            <DONG>
                <NGAYSL>
                </NGAYSL>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
            </DONG>
        </DSTCTDQH>
        <DUNO_VAMC>
            <DONG>
                <NGAYSL>
                </NGAYSL>
                <NOGOC_CONLAI>
                </NOGOC_CONLAI>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
            </DONG>
        </DUNO_VAMC>
        <TRAIPHIEU>
            <DONG>
                <NGAYSL>
                </NGAYSL>
                <NGAYPH>
                </NGAYPH>
                <NGAYDH>
                </NGAYDH>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
                <NHOMNO>
                </NHOMNO>
                <GIATRI>
                </GIATRI>
            </DONG>
        </TRAIPHIEU>
        <CAMKETNB>
            <DONG>
                <NGAYSL>
                </NGAYSL>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
                <LOAITIEN>
                </LOAITIEN>
                <NHOMNO>
                </NHOMNO>
                <GIATRI>
                </GIATRI>
                <LSQHTD>
                </LSQHTD>
            </DONG>
        </CAMKETNB>
        <DUNO_12THANG>
            <DONG>
                <THANG>
                </THANG>
                <DUNOVAY>
                </DUNOVAY>
                <DUNOTHE>
                </DUNOTHE>
                <TONGDUNO>
                </TONGDUNO>
            </DONG>
        </DUNO_12THANG>
        <NHOM2_12THANG>
            <DONG>
                <THANG>
                </THANG>
                <NGAYSL>
                </NGAYSL>
                <TONGDUNO>
                </TONGDUNO>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
            </DONG>
        </NHOM2_12THANG>
        <NOXAU_36THANG>
            <DONG>
                <NGAYSL>
                </NGAYSL>
                <MATCTD>
                </MATCTD>
                <TENTCTD>
                </TENTCTD>
                <NHOMNO_CAONHAT>
                </NHOMNO_CAONHAT>
                <NHOMNO>
                </NHOMNO>
                <NGAYPS_NOXAU_CUOICUNG>
                </NGAYPS_NOXAU_CUOICUNG>
                <NOXAU_VND>
                </NOXAU_VND>
                <NOXAU_USD>
                </NOXAU_USD>
            </DONG>
        </NOXAU_36THANG>
    </NOIDUNG>
</NOIDUNG_BANTLTIN>









<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}"/></title>
    <g:render template="/templates/m-melanin-html-head" model="[theme: 'ui-lightness']"/>
    <g:layoutHead/>
</head>

<body class="page-header-fixed">
<!-- BEGIN HEADER -->
<div class="header navbar navbar-inverse navbar-fixed-top">
    <g:render template="/templates/m-melanin-header"
              model="${[logoURL        : resource(dir: 'images', file: 'logo.png'),
                        avatarURL      : resource(dir: 'images', file: 'avatar.jpg'),
                        menuTogglerURL : resource(dir: 'images', file: 'menu-toggler.png'),
                        appDescriptions: grailsApplication.config.msb.platto.melanin.appDescription]}"/>
</div>
<!-- END HEADER -->

<div class="">
    <!-- BEGIN MENU -->
    <div class="">
        <div id="m-melanin-navigation" class="hor-menu hidden-sm hidden-xs">
            <g:render template="/templates/m-melanin-menu"
                      model="${[tabs: com.melanin.commons.MenuItem.findAll("from MenuItem where ordernumber >=0 order by ordernumber, id")]}"/>
        </div>
    </div>
    <!-- END MENU -->
</div>

<div class="clearfix"></div>
<!-- BEGIN BODY -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <!-- begin template menu for mobile device -->
        <g:render template="/templates/m-melanin-mobile-menu"
                  model="${[tabs: com.melanin.commons.MenuItem.findAll("from MenuItem where ordernumber >=0 order by ordernumber, id")]}"/>
        <!-- end template menu for mobile device -->
        <!-- END SIDEBAR MENU -->
    </div>
    <!-- END SIDEBAR -->

</div>

<g:layoutBody/>

<!-- END BODY -->

<!-- BEGIN FOOTER -->
<div class="footer">
    <div class="footer-inner">
        %{--					<img class="power-by" src="${resource(dir:'images', file: 'msb_copyright.jpg') }" alt="copyright"/>--}%
        %{--					<img class="power-by" src="${resource(dir: 'images', file: 'm1tech_powerby.jpg')}" alt="power by"/>--}%
        <img class="power-by" src="../../assets/images/logo-copyright.png" alt="copyright"/>
        <img class="power-by" src="../../assets/images/logo.png" alt="power by"/>
    </div>

    <div class="footer-tools">
        <span class="go-top">
            <i class="icon-angle-up"></i>
        </span>
    </div>
</div>

<input type="hidden" id="toastrMessage" value='${flash.message}'/>

<!-- Form modal -->
<div id="formModal" class="modal fade in" tabindex="-1" role="dialog">
    <div class="modal-dialog" style="width:35%">
        <div class="modal-content" style="width:100%"></div>
    </div>
</div>

%{--        <div class="modal fade" id="spinner" tabindex="-1" data-backdrop="static" data-keyboard="false" role="basic" aria-hidden="true">
           <img src="${resource(dir:'assets/img',file:'ajax-modal-loading.gif')}" alt="" class="loading">
        </div>       --}%

<!-- END CORE PLUGINS -->
<asset:javascript src="assets/scripts/app.js"/>
<script>
    jQuery(document).ready(function () {
        App.init();
        common.commonInit();
    });
</script>

<script type="text/javascript" charset="utf-8">
    $(document).ready(function () {
        common.showSpinner();
        $(".m-melanin-datatable").dataTable({
            'iDisplayLength': 20,
            "sDom": 'frtip<"clearfix">T',
            "oLanguage": {
                "sSearch": "Tìm nhanh:",
                "sZeroRecords": "Không có dữ liệu",
                "sEmptyTable": "Không có dữ liệu",
                "sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ dòng.",
                "sInfoFiltered": "",
                "sInfoEmpty": 'Không tìm thấy dữ liệu.'
            },
            "oTableTools": {
                "sSwfPath": "${resource(dir:'images',file:'copy_cvs_xls.swf')}",
                "aButtons": [
                    {
                        "sExtends": "xls",
                        "sButtonText": "Xuất ra Excel"
                    }
                ]
            }
        });

        common.hideSpinner();
    });
</script>
</body>
</html>
<%@ page import="com.melanin.security.*" %>

<html>
<head>
    %{--    <meta name="layout" content="m-melanin-layout"/>--}%
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Quản lý Sidebar</title>

    %{--    <asset:stylesheet src="css/datatables.min.css"/>--}%
    %{--    <asset:javascript src="datatables.min.js"/>--}%

    <input type="hidden" id="toastrMessage" value='${flash.message}'/>

</head>

<body>
<!-- BEGIN CONTAINER -->
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar navbar-collapse collapse">
    <!-- BEGIN SIDEBAR MENU -->
    <ul class="page-sidebar-menu">
        <li>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            <div class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
        </li>
    </ul>
    <!-- BEGIN SIDEBAR MENU -->
    %{--    <g:render template="/cic/sidebar/sidebar_module_danhmuchethong"></g:render>--}%
    <!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN PAGE TITLE & BREADCRUMB-->
            <h3 class="page-title">
                <span>Sidebar</span>
                <small>- Quản lý Sidebar</small>
            </h3>
            <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                <g:render template="/templates/m-melanin-breadcrum"
                          model="${[
                                  items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                          [href: createLink(controller: 'fingerprint', action: 'index'), title: 'Fingerprint Control Panel', label: 'Fingerprint'],
                                          [href : createLink(controller: 'sidebar', action: 'index_sidebarItem'),
                                           title: 'Quản lý Sidebar', label: 'Quản lý Sidebar']]
                          ]}"/>
            </ul>
            <!-- END PAGE TITLE & BREADCRUMB-->
        </div>
    </div>
    <!-- END PAGE HEADER-->

    <!-- BEGIN PAGE CONTENT-->
    <div class="row">
        <div class="col-md-12">
            <div id="m-melanin-main-content">
                <!-- BEGIN Div them moi chart -->
                <div id="div_ThemMoi"></div>
                <!-- END Div them moi chart -->

                <!-- BEGIN DATA TABLE -->
                <div id="div_dm_Item"></div>
                <!-- END DATA TABLE -->
            </div>
        </div>
    </div>
    <style>
    /*.portlet.box.deepblue {*/
    /*    border: 1px solid #255796;*/
    /*    border-top:1px solid #255796;*/
    /*}*/
    .modal-backdrop {
        overflow: hidden;
    }

    #spinner {
        overflow: hidden;
    }

    .modal-open {
        overflow-x: hidden;
        overflow-y: auto;
    }
    </style>

    <!-- END PAGE CONTENT-->
</div>
<!-- END CONTAINER -->

<script type="text/javascript">

    $(document).ready(function () {
        //Load div danh muc tai san
        $.ajax({
            type: "POST",
            async: false,
            url: "${createLink(controller:'sidebar',action:'lay_div_DMuc_Item')}",
            success: function (data) {
                // common.showSpinner();
                common.hideSpinner();
                // $('#div_dm_taisan').toggle('blind');
                $('#div_dm_Item').html(data.divCC);
                // $('#div_dm_SanPham').show('blind');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                common.hideSpinner();
                if (textStatus === "timeout") {
                    jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                } else {
                    common.hideSpinner();
                    if (jqXHR.status == '403') {
                        common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                    } else {
                        common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                    }
                }
            }
        });

    });

    $(function () {
        set_active_tab('security');
        // tinhNangMoi001
        $("#m-melanin-vertical-navigation-sidebarItem").closest('li').addClass('active');
        $('#m-melanin-vertical-navigation-sidebarItem').append('<span class="selected"></span>');
        $.configureBoxes();
        melanin_validate.role_validate();

        $('.editRow').live('click', function (e) {
            e.preventDefault();
            var id = $(this).attr("rel");
            $.ajax({
                type: "POST",
                async: false,
                data: {id: id},
                url: "${createLink(controller:'sidebar',action:'lay_div_Update')}",
                success: function (data) {
                    if ($('#div_ThemMoi').html() == '') {
                        $('#div_ThemMoi').hide('blind', function () {
                            $('#div_ThemMoi').html(data.divCC);
                            if (data.hdr.roles != null) {
                                $('#rolez').val(data.hdr.roles.split(",")).trigger('change');
                            }
                            $('#div_ThemMoi').show('blind');
                        });
                    } else {
                        common.showSpinner();
                        $('#div_ThemMoi').html(data.divCC);
                        if (data.hdr.roles != null) {
                            $('#rolez').val(data.hdr.roles.split(",")).trigger('change');
                        }
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300)
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    // common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        // common.hideSpinner();
                        if (jqXHR.status == '403') {
                            common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                        } else {
                            common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                        }
                    }
                }
            });
        });
    });
</script>

</body>
</html>
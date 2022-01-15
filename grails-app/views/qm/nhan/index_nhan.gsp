<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Nhãn</title>

    <input type="hidden" id="toastrMessage" value='${flash.message}'/>

    <asset:javascript src="assets/plugins/bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/css/editor.dataTables.css"/>
    <asset:javascript src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/js/dataTables.editor_ng12t8n20.js"/>

</head>

<body>
<!-- BEGIN CONTAINER -->
<!-- BEGIN SIDEBAR -->
%{--<div class="page-sidebar navbar-collapse collapse">
    <!-- BEGIN SIDEBAR MENU -->
    <ul class="page-sidebar-menu">
        <li>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            <div class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
        </li>
    </ul>
    <!-- BEGIN SIDEBAR MENU -->

    <!-- END SIDEBAR MENU -->
</div>--}%
<!-- END SIDEBAR -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
    <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
        <g:render template="/templates/m-melanin-action-bar"
                  model="${[
                          buttons: [
                                  [name: 'button-create', label: 'Tạo mới', class: 'btn-create default', icon: 'icon-plus'],
                          ]
                  ]}"/>
        <g:render template="/templates/m-melanin-breadcrum"
                  model="${[
                          items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                  [href: createLink(controller: 'nhan', action: 'index_Nhan'), title: 'Nhãn', label: 'Nhãn']]
                  ]}"/>
    </ul>
    <!-- END PAGE TITLE & BREADCRUMB-->
    <!-- END PAGE HEADER-->

    <!-- BEGIN PAGE CONTENT-->
    <div id="m-melanin-main-content">
        <!-- BEGIN Div them moi chart -->
        <div id="div_ThemMoi">
        </div>
        <!-- END Div them moi chart -->

        <!-- BEGIN DATA TABLE -->
        <div id="portlet_danhMuc">
        </div>
        <!-- END DATA TABLE -->
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
    </style>

    <!-- END PAGE CONTENT-->
</div>
<!-- END CONTAINER -->

<script type="text/javascript">

    $(document).ready(function () {
        $.ajax({
            type: "POST",
            async: false,
            url: "${createLink(controller:'nhan',action:'layDivDMNhan')}",
            success: function (data) {
                $('#portlet_danhMuc').html(data.divCC);
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
        set_active_tab('NHAN');
        $.configureBoxes();
        melanin_validate.role_validate();

        //nút tạo mới
        $("button[name=button-create]").click(function () {
            $('#div_ThemMoi').hide('blind');
            $.ajax({
                type: "POST",
                async: false,
                data: {crud: ${com.commons.Constant.CRUD_1000}},
                url: "${createLink(controller:'nhan',action:'layDivCRUDNhan')}",
                success: function (data) {
                    common.showSpinner();
                    $('#div_ThemMoi').html(data.divCC);
                    $('#div_ThemMoi').show('blind');
                    setTimeout(function () {
                        common.hideSpinner();
                    }, 300);
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
    });
</script>

</body>
</html>
<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Câu hỏi & Trả lời</title>

    %{--    <asset:stylesheet src="datatables.min.css"/>--}%
    %{--    <asset:javascript src="datatables.min.js"/>--}%


    <input type="hidden" id="toastrMessage" value='${flash.message}'/>

    %{--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--}%
    %{--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--}%
    %{--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--}%

    <asset:javascript src="assets/plugins/bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/css/editor.dataTables.css"/>
    <asset:javascript src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/js/dataTables.editor_ng12t8n20.js"/>
    %{--    <asset:javascript src="assets/plugins/data-tables/moment_js-2.18.1/moment.min.js"/>--}%

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
    <ul class="page-sidebar-menu">
        <g:render template="/m-melanin-fingerprint/sidebar_item/template/div_DynamicSidebar"
                  model="${[menuItemName: 'QA']}"/>
    </ul>

    <!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
    <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
        <g:render template="/templates/m-melanin-action-bar"
                  model="${[
                          buttons: [
                                  [name: 'button-create', label: 'Tạo mới', class: 'btn-create default', icon: 'icon-plus'],
                                  [name: 'button-import-excel', label: 'Import Excel', class: 'green default', icon: 'icon-upload'],
                          ]
                  ]}"/>
        <g:render template="/templates/m-melanin-breadcrum"
                  model="${[
                          items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                  [href: createLink(controller: 'cauHoiVaTraLoi', action: 'index_CauHoiVaTraLoi'), title: 'Câu hỏi & Trả lời', label: 'Câu hỏi & Trả lời']]
                  ]}"/>
    </ul>
    <!-- END PAGE TITLE & BREADCRUMB-->
    <!-- END PAGE HEADER-->

    <!-- BEGIN PAGE CONTENT-->
    <div id="m-melanin-main-content">
        <!-- BEGIN Div them moi chart -->
        <div id="portlet_timKiem">
            <div class="portlet box deepblue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-search"></i>
                        <span>Tìm kiếm</span>
                    </div>

                    <div class="tools">
                        <a class="collapse"></a>
                    </div>
                </div>

                <div class="portlet-body">
                    <form id="timKiem" novalidate="novalidate">
                        <div class="row">
                            <div class="col-md-12">

                                <div class="form-group">
                                    <label class="col-md-3 control-label">Nhãn</label>

                                    <div class="col-md-6">
                                        <g:select name="nhans_search" id="nhans_search"
                                                  from="${com.qm.QmNhan.findAll()}"
                                                  class="form-control input-sm"
                                                  optionKey="maNhan"
                                                  optionValue="maNhan"
                                                  multiple="true"
                                                  noSelection="['': '']"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row"><div class="col-md-12"><div class="form-group"></div></div></div>
                    </form>

                    <div style="text-align: center">
                        <button class="btn blue search" id="btnTimKiem">
                            <i class="glyphicon glyphicon-search"></i> Tìm kiếm
                        </button>
                    </div>

                </div>
            </div>
        </div>
        <!-- END Div them moi chart -->

        <!-- BEGIN DATA TABLE -->
        <div id="portlet_danhMuc">
        </div>
        <!-- END DATA TABLE -->

    </div>

    <div class="modal fade in" id="modal_ViewOrInsertOrUpdate" role="dialog">
        <g:render template="/qm/cauHoiVaTraLoi/div_modal_ViewOrInsertOrUpdate"/>
    </div>

    <div class="modal fade in" id="modal_ImportExcel" role="dialog">
        <g:render template="/qm/cauHoiVaTraLoi/div_modal_ImportExcel"/>
    </div>

    <div class="modal fade in" id="modal_Update" role="dialog">
        <g:render template="/qm/cauHoiVaTraLoi/div_modalUpdate"/>
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
            url: "${createLink(controller:'cauHoiVaTraLoi',action:'layDivDMCauHoiVaTraLoi')}",
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
        set_active_tab('CH_TL');
        $.configureBoxes();
        melanin_validate.role_validate();

        $('#nhans_search').select2({
            placeholder: "-Chọn nhãn-",
            allowClear: true
        });

        //nút tạo mới
        $("button[name=button-create]").click(function () {
            $('form#thongTinNhan [name=editOrView]').val('create');
            $('form#thongTinNhan [name="nhans"]').val(null).trigger('change');
            window.dataDsCH_TL = []
            window.dataDsCH_TLXoa = []
            window.tableDmItem_1.clear().rows.add(dataDsCH_TL).draw();
            $('#modal_ViewOrInsertOrUpdate').modal('show');
        });

        // Nút import excel
        $("button[name=button-import-excel]").click(function () {
            $('form#thongTinNhan_ImportExcel [name=editOrView_ImportExcel]').val('create');
            // $('form#thongTinNhan_ImportExcel [name="nhans_ImportExcel"]').val([""]).trigger('change');
            window.dataDsCH_TL = []
            window.dataDsCH_TLXoa = []
            window.tableDmItem_ImportExcel.clear().rows.add(dataDsCH_TL).draw();
            $('#modal_ImportExcel').modal('show');
        });

        $('#btnTimKiem').click(function (e) {
            e.preventDefault();
            $.ajax({
                type: "POST",
                async: false,
                data: {nhans_search: $('#nhans_search').val() == null ? null : $('#nhans_search').val().join(',')},
                url: "${createLink(controller:'cauHoiVaTraLoi',action:'layDivDMCauHoiVaTraLoi')}",
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
    });
</script>

</body>
</html>
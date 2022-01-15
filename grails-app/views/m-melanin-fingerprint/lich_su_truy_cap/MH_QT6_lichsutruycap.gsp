<%@ page import="com.melanin.fingerprint.Module" %>
<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Lịch sử truy cập</title>
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN PAGE -->
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <ul class="page-sidebar-menu">
            <li>
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                <div
                        class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            </li>
        </ul>
        <!-- BEGIN SIDEBAR MENU -->
        <g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
        <!-- END SIDEBAR MENU -->
    </div>
    <!-- END SIDEBAR -->

    <div class="page-content">
        <!-- BEGIN PAGE CONTENT -->
        <!-- BEGIN PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                    <g:render template="/templates/m-melanin-breadcrum"
                              model="${[
                                      items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                              [href: createLink(controller: 'fingerprint', action: 'index'), title: "Fingerprint", label: "Fingerprint"],
                                              [href: createLink(controller: 'fingerprint2', action: 'logmng'), title: "Lịch sử truy cập", label: "Lịch sử truy cập"]]
                              ]}"/>
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
            <!-- END PAGE HEADER-->
        </div>
    <!-- BEGIN PAGE CONTENT-->
    <div class="row">
        <div class="col-md-12">
            <div id="m-melanin-main-content">
                <!-- CODE VÀO ĐÂY -->
                <div class="portlet box lpbblue">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-search"></i>
                            Điều kiện tra cứu
                        </div>

                        <div class="tools">
                            <a href="javascript:;" class="collapse"></a>
                        </div>
                    </div>

                    <div class="portlet-body form">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label"
                                           for="user">Người dùng
                                    </label>

                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="user" name="user"
                                               value="${params?.user}">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label"
                                           for="thoigiantruycap_from">Thời gian truy cập
                                    </label>


                                    <div class="col-md-2">
                                        <input id="thoigiantruycap_from"
                                               name="thoigiantruycap_from"
                                               type="text"
                                               class="form-control date-picker vnDatez"
                                               placeholder="dd/mm/yyyy"
                                               value="${params?.thoigiantruycap_from}"/>
                                    </div>

                                    <div class="col-md-2">
                                        <input id="thoigiantruycap_to"
                                               name="thoigiantruycap_to"
                                               type="text"
                                               class="form-control date-picker vnDatez"
                                               placeholder="dd/mm/yyyy"
                                               value="${params?.thoigiantruycap_to}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label"
                                           for="module">Module
                                    </label>

                                    <div class="col-md-4">
                                        <g:select id="module" name="module"
                                                  noSelection="${['': '']}"
                                                  from="${com.melanin.fingerprint.Module.list()}"
                                                  optionValue="name" optionKey="id"
                                                  class="form-control select2" value="${params?.module}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions fluid">
                            <div class="row col-md-offset-2 col-md-10">
                                <button type="button" class="btn btn-search blue"
                                        name="btnSearch" id="btnSearch">
                                    <i class="icon-search"></i> Tìm kiếm
                                </button>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- BEGIN DIV TIM KIEM -->
                <div class="portlet box lpbblue">
                    <div class="portlet-title">
                        <div class="caption">Lịch sử truy cập hệ thống</div>
                    </div>

                    <div class="portlet-body ">
                        <div id="divtbl" class="table-scrollable">
                            <table id="tbl" class="table table-striped table-bordered table-hover no-footer">
                                <thead>
                                <tr>
                                    <th style="width: 5% !important;">ID</th>
                                    <th style="width: 15% !important;">Module</th>
                                    <th style="width: 10% !important;">Người dùng</th>
                                    <th style="width: 15% !important;">Hành động</th>
                                    <th style="width: 10% !important;">Thời gian thực hiện</th>
                                    <th style="width: 15% !important;">Action Controller</th>
                                    <th style="width: 20% !important;">Chức năng</th>
                                </tr>
                                </thead>
                            </table>
                            <br><br>
                        </div>
                    </div>
                </div>
                <!-- END DIV TIM KIEM -->

                <!-- BEGIN DIV DANH SACH LOG -->
                <div id="div_danhsach"></div>
                <!-- BEGIN DIV DANH SACH LOG -->
            </div>
        </div>
    </div>
    <!-- END PAGE CONTENT -->
        <!-- END PAGE -->
    </div>
</div>
<!-- END CONTAINER -->

<script type="text/javascript">
    $(function () {
        set_active_tab('security');
        $("#m-melanin-vertical-log").parent().addClass('active');
//        validz.valid_form_timkiem();
        $('.date-picker').datepicker($.datepicker.regional["vi"]).mask("00/00/0000");
        $('.select2').select2({
            placeholder: "${message(code: 'select2.search.noselect')}",
            allowClear: true   // Shows an X to allow the user to clear the value.
        });

        var table = $('#tbl').DataTable({
            "scrollX": true,
            "processing": true,
            "serverSide": true,
            "pagingType": "full_numbers",
            // "bFilter": false,
            "language": {
                "sSearch": "${message(code: 'data.table.sSearch')}",
                "sZeroRecords": "${message(code: 'data.table.sZeroRecords')}",
                "sEmptyTable": "${message(code: 'data.table.sEmptyTable')}",
                "sInfo": "${message(code: 'data.table.sInfo')}",
                "lengthMenu": "${message(code: 'data.table.lengthMenu')}",
                "paginate": {
                    "first": "${message(code: 'data.table.paginate.first')}",
                    "last": "${message(code: 'data.table.paginate.last')}",
                    "next": "${message(code: 'data.table.paginate.next')}",
                    "previous": "${message(code: 'data.table.paginate.previous')}"
                },
                "sInfoFiltered": "",
                "sInfoEmpty": '${message(code: 'data.table.sInfoEmpty')}'
            },
            "ajax": {
                "url": "${createLink(controller:'fingerprint2',action:'dslogss')}",
                "type": "post",
                "data": function (d) {
                    d.user = $('#user').val();
                    d.module = $('#module').val();
                    d.thoigiantruycap_to = $('#thoigiantruycap_to').val();
                    d.thoigiantruycap_from = $('#thoigiantruycap_from').val();
                }
            },
            columnDefs: [
                {"targets": 0, "name": "id"},
                {"targets": 1, "name": "module_name"},
                {"targets": 2, "name": "username"},
                {"targets": 3, "name": "actionname"},
                {"targets": 4, "name": "actiontime"},
                {"targets": 5, "name": "action_controller"},
                {"targets": 6, "name": "chuc_nang"}
            ],
            "order": [[0, "desc"]],
            initComplete: function () {
                var input = $('.dataTables_filter input').unbind(),
                    self = this.api(),
                    $searchButton = $('<button class="btn search_datatable small icon-search" style=" height: 40px; font-size: 15px;">')
                        .text(' ')
                        .click(function () {
                            self.search(input.val()).draw();
                        })
                $('.dataTables_filter').append($searchButton);

                $('.dataTables_filter input').keyup(function (e) {
                    var key = e.which;
                    // debugger;
                    if (key == 13)  // the enter key code
                    {
                        $searchButton.click();
                    }
                    if (key == 8)  // the backspace key code
                    {
                        if ($('.dataTables_filter input')[0].value.length == 0) {
                            $searchButton.click();
                        }
                    }
                });
            }
        });

        $('#btnSearch').live('click', function () {
            table.draw();
        });
    });

    var sidebarSwitch = false;

    function toggle_sidebar(flag) {
        set_side_bar(flag);
    }

    $(document).ready(function () {

    });

</script>
</body>
</html>
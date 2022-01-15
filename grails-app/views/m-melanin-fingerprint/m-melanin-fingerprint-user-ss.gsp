<%@ page import="com.melanin.fingerprint.*" %>
<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Control Panel | User Management</title>

    <asset:stylesheet src="css/datatables.min.css"/>
    %{--    <asset:javascript src="datatables.min.js"/>--}%
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN PAGE TITLE & BREADCRUMB-->
            <h3 class="page-title">
                Users
                <small>thông tin users sử dụng hệ thống</small>
            </h3>
            <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                <g:render template="/templates/m-melanin-breadcrum"
                          model="${[
                                  items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                          [href: createLink(controller: 'fingerprint', action: 'index'), title: 'Fingerprint Control Panel', label: 'Fingerprint'],
                                          [href: createLink(controller: 'fingerprint', action: 'user'), title: 'User Management', label: 'User Management']]
                          ]}"/>

                <li class="btn-group">
                    <button value="Import NV" class="btn green default" name="button-import-danhmuc-nv"><i
                            class="icon-upload-alt"></i> Import NV</button>
                    <button value="Tạo mới" class="btn btn-create primary"
                            name="m-melanin-action-bar-button-create-user" data-toggle="modal"><i
                            class="icon-plus"></i> Tạo mới</button>

                </li>

                %{--                <g:render template="/templates/m-melanin-action-bar"--}%
                %{--                          model="${[--}%
                %{--                                  buttons: [[name: 'm-melanin-action-bar-button-create-user', class: 'primary', label: 'Create']]--}%
                %{--                          ]}"/>--}%
            </ul>
            <!-- END PAGE TITLE & BREADCRUMB-->
        </div>
    </div>
    <!-- END PAGE HEADER-->

    <!-- BEGIN PAGE -->
    <div class="row">
        <div class="col-md-12">
            <div id="m-melanin-main-content" class="m-melanin-high-density">
                <g:if test="${flash.error}">
                    <div class="error">${flash.error}</div>
                </g:if>
                <div id="m-melanin-form-section">
                    <g:form name="m-melanin-form-user-details" controller="fingerprint" action="addUser"
                            class="form-horizontal">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="portlet box lpbblue">
                                    <div class="portlet-title">
                                        <div class="caption" id="m-melanin-form-user-details-legend">
                                            <i class="icon-reorder">
                                            </i>
                                            Create new user
                                        </div>
                                    </div>

                                    <div class="portlet-body form">
                                        <form action="#" class="form-horizontal">
                                            <div class="form-body">
                                                <div class="alert alert-danger display-hide">
                                                    <button class="close" data-dismiss="alert"></button>
                                                    Phát sinh một số lỗi. Vui lòng kiểm tra bên dưới
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="col-md-2 control-label">Tên truy cập <span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:textField name="username" type="text"
                                                                             autocomplete="off"
                                                                             class="form-control" maxlength="255"
                                                                             placeholder="Enter outlook username."
                                                                             oninput="this.value = this.value.toLowerCase()"/>
                                                            </div>

                                                            <label class="col-md-2 control-label">Đơn vị <span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:select name="branchID" autocomplete="off"
                                                                          from="${listBranch}"
                                                                          class="form-control input-lg "
                                                                          optionKey="id"
                                                                          optionValue="${{ b -> "${b.code} - ${b.name}" }}"
                                                                          noSelection="['': '']"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="col-md-2 control-label">Mật khẩu <span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:passwordField name="password"
                                                                                 autocomplete="new-password"
                                                                                 placeholder="Enter password."
                                                                                 class="form-control"/>
                                                            </div>

                                                            <label class="col-md-2 control-label">Email <span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:textField name="email" type="text"
                                                                             class="form-control" maxlength="255"
                                                                             placeholder="Nhập địa chỉ email."/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-2">Mã nhân viên<span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:textField name="maNhanVien" type="text"
                                                                             class="form-control" maxlength="16"
                                                                             placeholder="Nhập mã nhân viên."
                                                                             oninput="this.value = this.value.toUpperCase()"/>
                                                            </div>

                                                            <label class="col-md-2 control-label">Họ và tên <span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:textField name="fullname" type="text"
                                                                             class="form-control" maxlength="255"
                                                                             placeholder="Nhập tên nhân viên."/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="control-label col-md-2">Chức vụ<span
                                                                    class="required">*</span></label>

                                                            <div class="col-md-4">
                                                                <g:textField name="chucVu" type="text"
                                                                             class="form-control" maxlength="255"/>
                                                            </div>

                                                            <label class="control-label col-md-2">Số điện thoại</label>

                                                            <div class="col-md-4">
                                                                <g:textField name="sodienthoai" type="text"
                                                                             class="form-control" maxlength="64"
                                                                             placeholder="Nhập số điện thoại."/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <label class="col-md-2 control-label">Roles</label>

                                                            <div class="col-md-4">
                                                                <g:each in="${Role.findAll()}"
                                                                        var="role">
                                                                    <g:checkBox name="roles"
                                                                                value="${role.authority}"
                                                                                checked="false"/><label>${role.authority}</label><br/>
                                                                </g:each>
                                                            </div>

                                                            <label class="col-md-2 control-label">Trạng thái</label>
                                                            <div class="col-md-4">
                                                                <g:select id="enabled" name="enabled"
                                                                          class="form-control clearText"
                                                                          from="['Active', 'Inactive']"
                                                                          keys="${['true', 'false']}"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <g:form name="m-melanin-form-user-details" controller="fingerprint"
                                                    action="addUser">
                                                <div class="form-actions fluid">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <g:hiddenField name="userId"/>
                                                        <button class="btn btn-save" name="m-melanin-form-button-save">
                                                            <i class="icon-ok"></i> Save
                                                        </button>
                                                        <button class="btn red" name="m-melanin-form-button-delete">
                                                            <i class="icon-trash"></i> Delete
                                                        </button>
                                                        <button name="m-melanin-form-button-cancel"
                                                                class="btn yellow"><i
                                                                class="icon-ban-circle"></i> Cancel</button>
                                                    </div>
                                                </div>
                                            </g:form>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:form>

                </div>

                <!-- BEGIN DIV TIM KIEM -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box lpbblue">
                            <div class="portlet-title">
                                <div class="caption" id="m-melanin-form-user-search-legend">
                                    <i class="icon-reorder"></i>Tìm kiếm
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="control-label col-md-2">Tên truy cập</label>

                                        <div class="col-md-4">
                                            <input
                                                    class="form-control clearText validate[required]"
                                                    type="text" id="username_search"
                                                    data-minlength="4" name="username_search"
                                                    value="${params.username_search}">
                                        </div>

                                        <label class="control-label col-md-2">Quyền</label>

                                        <div class="col-md-4">
                                            <g:select id="role_search" name="role_search"
                                                      noSelection="${['': '']}"
                                                      class="form-control"
                                                      from="${com.melanin.security.Role.list()}"
                                                      optionKey="id" optionValue="authority"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="portlet-body form">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group">
                                            <label class="control-label col-md-2">Đơn vị</label>

                                            <div class="col-md-4">
                                                <g:select id="branch_search" name="branch_search"
                                                          noSelection="${['': '']}"
                                                          class="form-control select2"
                                                          from="${listBranch}"
                                                          optionKey="id"
                                                          optionValue="${{ b -> "${b.code} - ${b.name}" }}"/>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-md-2 control-label">Trạng thái</label>

                                            <div class="col-md-4">
                                                <g:select id="trangthai_search" name="trangthai_search"
                                                          class="form-control clearText"
                                                          from="['Active', 'Inactive']"
                                                          noSelection="${['': '']}"
                                                          keys="${['true', 'false']}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-actions fluid">
                                    <div class="col-md-offset-2 col-md-9">
                                        <button type="button" class="btn btn-search blue"
                                                name="m-melanin-form-button-search" id="btnSearch">
                                            <i class="icon-search"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END DIV TIM KIEM -->

                <!-- BEGIN DATA TABLE -->
                <div class="portlet box lpbblue">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="icon-globe"></i>
                            Danh sách user
                        </div>
                    </div>

                    <div class="portlet-body" id="gridData">
                        <div id="m-melanin-fingerprint-user-table-section" class="table-scrollable">
                            <table id="m-melanin-fingerprint-user-table"
                                   class="table table-striped table-bordered table-hover dataTable no-footer">
                                <thead>
                                <tr>
                                    <th style="width: 2% !important;">STT</th>
                                    <th style="display: none">ID</th>
                                    <th style="width: 9% !important;">Tên đăng nhập</th>
                                    <th style="width: 10% !important;">Mã nhân viên</th>
                                    <th style="width: 10% !important;">Họ và tên</th>
                                    <th style="width: 13% !important;">Đơn vị</th>
                                    <th style="width: 14% !important;">Chức vụ</th>
                                    <th style="width: 13% !important;">Email</th>
                                    <th style="width: 7% !important;">Trạng thái</th>
                                    <th style="width: 7% !important;">Hành động</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <!-- END DATA TABLE -->
                </div>

                <!-- BEGIN DIV import -->
                <div id="div_import_dialog" class="modal fade in" aria-hidden="false"
                     aria-labelledby="div_import" role="dialog" tabindex="-1"
                     style="display: none;"></div>
                <!-- END DIV import -->
            </div>
        </div>
        <!-- END PAGE -->
    </div>
    <!-- END CONTAINER -->
</div>

<script type="text/javascript">
    $(function () {

        set_side_bar(true);
        add_tab('#', 'Security', 'security');
        set_active_tab('security');

        $('#branchID').select2({
            placeholder: "-Chọn đơn vị-",
            allowClear: true
        });

        $('#branch').select2({
            allowClear: true
        });

        $('#role_group').select2({
            allowClear: true
        });

        $('#branch_search').select2({
            placeholder: "${message(code: 'select2.search.noselect')}",
            allowClear: true
        });

        $('#role_search').select2({
            placeholder: "${message(code: 'select2.search.noselect')}",
            allowClear: true
        });

        $('#trangthai_search').select2({
            placeholder: "${message(code: 'select2.search.noselect')}",
            allowClear: true
        });

        melanin_validate.user();

        $("#m-melanin-vertical-navigation-user").closest('li').addClass('active');
        $("#m-melanin-vertical-navigation-user").append('<span class="selected"></span>');

        var table = $('#m-melanin-fingerprint-user-table').DataTable({
            "scrollX": true,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "${createLink(controller:'fingerprint',action:'dsuser_ss')}",
                "type": "post",
                "data": function (d) {
                    d.username_search = $('#username_search').val();
                    d.branch_search = $('#branch_search').val();
                    d.role_search = $('#role_search').val();
                    d.trangthai_search = $('#trangthai_search').val();
                    d.nhomKt_search = $('#nhomKt_search').val();
                }
            },
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
            columnDefs: [
                {"targets": 0, "name": "stt"},
                {"targets": 1, "name": "id", "visible": false, "searchable": false},
                {"targets": 2, "name": "username"},
                {"targets": 3, "name": "manhanvien"},
                {"targets": 4, "name": "fullname"},
                {"targets": 5, "name": "branchname"},
                {"targets": 6, "name": "role"},
                {"targets": 7, "name": "email"},
                {"targets": 8, "name": "active"},
                {"targets": 9, "name": "lnk", "orderable": false}
            ],
            order: [[0, 'asc']],
            initComplete: function () {
                var input = $('.dataTables_filter input').unbind(),
                    self = this.api(),
                    $searchButton = $('<button class="btn search_datatable small icon-search" style=" height: 40px; font-size: 15px;">')
                        .text(' ')
                        .click(function () {
                            self.search(input.val()).draw();
                        })
                $('.dataTables_filter').append($searchButton);

                $('.dataTables_filter input').keypress(function (e) {
                    var key = e.which;
                    if (key == 13)  // the enter key code
                    {
                        $searchButton.click();
                    }
                });
            }
        });

        $('#btnSearch').live('click', function (e) {
            table.columns.adjust().draw();
        });

        $("button[name=m-melanin-action-bar-button-create-user]").click(function () {
            debugger
            if ($("#m-melanin-form-section").css("display") == "none") {
                $("#m-melanin-form-section").show('blind');
            }
            $("input[name=username]").removeAttr("disabled");
            $("#branchID").select2("val", "");
            $("input[name=userId]").val("");
            $("input[name=username]").val("");
            /*$("input[name=enabled]").removeAttr("checked");
             $("input[name=enabled]").parent().removeClass('checked');*/
            $('#enabled').val('true');
            $("input[name=roles]").removeAttr("checked");
            $("input[name=roles]").parent().removeClass('checked');
            $("input[name=jobTitle]").val("");
            $("input[name=adOnly]").removeAttr("checked");
            $("input[name=adOnly]").parent().removeClass('checked');
            $("input[name=username]").val("");
            $("input[name=password]").val("");
            $("input[name=fullname]").val("");
            $("input[name=email]").val("");
            $("input[name=prop1]").val("");
            $("input[name=prop2]").val("");
            $("input[name=prop3]").val("");
            $("input[name=prop4]").val("");
            $("input[name=prop5]").val("");

            $("input[name=maNhanVien]").val("");
            $("input[name=sodienthoai]").val("");
            $("input[name=chucVu]").val("");

            $("#m-melanin-form-user-details-legend").html("Create new user");
            $("button[name=m-melanin-form-button-delete]").hide();
        });

        $("button[name=m-melanin-form-button-cancel]").click(function (e) {
            $("#m-melanin-form-section").hide('blind');
            e.preventDefault();
        });

        $('.editUrl').live('click', function (e) {
            var uid = $(this).attr('value');
            common.showSpinner();
            $.ajax({
                type: "GET",
                async: false,
                url: "${createLink(controller:'fingerprint',action:'getUserInfo')}",
                data: {uid: uid},
                success: function (data) {
                    common.hideSpinner();
                    if ($("#m-melanin-form-section").css("display") == "none") {
                        $("#m-melanin-form-section").show('blind');
                    }
                    $("input[name=roles]").removeAttr("checked");
                    $("input[name=roles]").parent().removeClass('checked');
                    $("input[name=adOnly]").removeAttr("checked");
                    $("input[name=adOnly]").parent().removeClass('checked');
                    $("input[name=username]").val(data.user.username);
                    $("input[name=username]").attr('disabled', 'disabled');
                    $("input[name=email]").val(data.user.email);
                    $("input[name=password]").val("");
                    $("input[name=fullname]").val(data.user.fullname);

                    $("input[name=maNhanVien]").val(data.user.maNhanVien);
                    $("input[name=sodienthoai]").val(data.user.sodienthoai);
                    $("input[name=chucVu]").val(data.user.chucVu);

                    $("#branchID").select2("val", data.branch_id);

                    $("#nhomKt").select2("val", data.user?.nhomKt?.id);
                    // if (data.user.adOnly) {
                    //     $("input[name=adOnly]").attr("checked", "checked");
                    //     $("input[name=adOnly]").parent().addClass('checked');
                    // }

                    if (data.user.enabled) {
                        $('#enabled').val('true');
                    } else {
                        $('#enabled').val('false');
                    }

                    var str_roles = data.rolename;
                    str_roles = str_roles.substring(1, str_roles.length - 1);
                    var arr_roles = str_roles.split(", ");
                    for (var i = 0; i < arr_roles.length; i++) {
                        $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").parent().addClass('checked');
                        $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").attr('checked', 'checked');
                    }

                    $("input[name=userId]").val(data.user.id);
                    $("button[name=m-melanin-form-button-delete]").val(data.user.id);
                    $("#m-melanin-form-user-details-legend").html("Edit user: " + data.user.id);
                    $("button[name=m-melanin-form-button-delete]").show();
                    $("button[name=m-melanin-form-button-delete]").attr("rel", data.user.id);

                    common.goTop();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        common.hideSpinner();
                        common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                    }
                }
            });
        });

        $('.editUrl_old').live('click', function (e) {
            e.preventDefault();
            if ($("#m-melanin-form-section").css("display") == "none") {
                $("#m-melanin-form-section").show('blind');
            }
            /*$("input[name=enabled]").removeAttr("checked");
             $("input[name=enabled]").parent().removeClass('checked');*/
            $("input[name=roles]").removeAttr("checked");
            $("input[name=roles]").parent().removeClass('checked');
            $("input[name=adOnly]").removeAttr("checked");
            $("input[name=adOnly]").parent().removeClass('checked');
            $("input[name=username]").val($("#m-melanin-fingerprint-td-username-" + $(this).attr("rel")).html());
            $("input[name=email]").val($("#m-melanin-fingerprint-td-email-" + $(this).attr("rel")).html());
            $("input[name=password]").val("");
            $("input[name=fullname]").val($("#m-melanin-fingerprint-td-fullname-" + $(this).attr("rel")).html());
            if ($("#m-melanin-fingerprint-td-branch-" + $(this).attr("rel")).html().length > 0) {
                //$("#branchID option:contains(" + $("#m-melanin-fingerprint-td-branch-"+$(this).attr("rel")).html() + ")").attr('selected', 'selected');
                var branchId = '#m-melanin-fingerprint-user-table #m-melanin-fingerprint-td-branch-id-' + $(this).attr("rel");
                var branchIdVal = $(branchId).text();
                $("#branchID").select2("val", branchIdVal);

            } else {
                $("#branchID").val('');
            }

            $("#jobTitle").val($("#m-melanin-fingerprint-td-jobTitle-" + $(this).attr("rel")).attr("jobTitleID"));

            $("input[name=prop1]").val($("#m-melanin-fingerprint-td-prop1-" + $(this).attr("rel")).html());
            $("input[name=prop2]").val($("#m-melanin-fingerprint-td-prop2-" + $(this).attr("rel")).html());
            $("input[name=prop3]").val($("#m-melanin-fingerprint-td-prop3-" + $(this).attr("rel")).html());
            $("input[name=prop4]").val($("#m-melanin-fingerprint-td-prop4-" + $(this).attr("rel")).html());
            $("input[name=prop5]").val($("#m-melanin-fingerprint-td-prop5-" + $(this).attr("rel")).html());

            var str_roles = $("#m-melanin-fingerprint-td-roles-" + $(this).attr("rel")).html();
            str_roles = str_roles.substring(1, str_roles.length - 1);
            var arr_roles = str_roles.split(", ");
            for (var i = 0; i < arr_roles.length; i++) {
                $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").parent().addClass('checked');
                $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").attr('checked', 'checked');
            }
            if ($("#m-melanin-fingerprint-td-enabled-" + $(this).attr("rel")).html()) {
                /*$("input[name=enabled]").attr("checked","checked");
                 $("input[name=enabled]").parent().addClass('checked');*/
                $('#enabled').val('true');
            } else {
                $('#enabled').val('false');
            }
            if ($("#m-melanin-fingerprint-td-adOnly-" + $(this).attr("rel")).html()) {
                $("input[name=adOnly]").attr("checked", "checked");
                $("input[name=adOnly]").parent().addClass('checked');
            }
            $("input[name=userId]").val($(this).attr("rel"));
            $("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
            $("#m-melanin-form-user-details-legend").html("Edit user: " + $(this).attr("rel"));
            $("button[name=m-melanin-form-button-delete]").show();
            $("button[name=m-melanin-form-button-delete]").attr("rel", $(this).attr("rel"));
            common.goTop();
        });

        $('button[name=m-melanin-form-button-save]').click(function (e) {
            e.preventDefault();
            if ($('form[name=m-melanin-form-user-details]').valid()) {
                $('form[name=m-melanin-form-user-details]').submit();
            }

        })

        $('.deleteUrl').live('click', function (e) {
            e.preventDefault();
            var uid = $(this).attr("rel");

            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa user này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteUser')}/" + uid;
                    common.hideSpinner();
                }
            });
        });

        $("button[name=m-melanin-form-button-delete]").click(function (e) {
            e.preventDefault();
            var uid = $(this).attr("rel");

            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa user này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteUser')}/" + uid;
                    common.hideSpinner();
                }
            });
        });

        $('#username_search').on('keyup', function (e) {
            if (e.keyCode === 13) {
                table.draw();
            }
        });

        // $("#branch_search").live('change', function () {
        //     table.draw();
        // });
        //
        // $("#role_search").live('change', function () {
        //     table.draw();
        // });

    });
    $(document).ready(function () {
//        $("select option").each(function(i){
//            this.text = $(this).html(this.text).text();
//        });
    });

    $("button[name=button-import-danhmuc-nv]").click(function () {
        $.ajax({
            type: "POST",
            async: false,
            url: "${createLink(controller:'fingerprint',action:'btn_importExcel')}",
            success: function (data) {
                $('#div_import_dialog').html(data.divCC);
                $('#div_import_dialog').modal();
            },
            error: function (jqXHR, textStatus, errorThrown) {
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

    function deleteUser(uid) {
        common.showSpinner();
        document.location = "${createLink(controller:'fingerprint',action:'deleteUser')}/" + uid;
        common.hideSpinner();
        $(commonConfig.modal.id).modal('hide');
    }
</script>

</body>
</html>

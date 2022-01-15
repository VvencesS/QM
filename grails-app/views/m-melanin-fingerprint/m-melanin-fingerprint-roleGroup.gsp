<%@ page import="com.melanin.fingerprint.*" %>
<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Control Panel | Role Group Management</title>

    <asset:stylesheet src="css/datatables.min.css"/>
    <asset:javascript src="datatables.min.js"/>
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN PAGE TITLE & BREADCRUMB-->
            <h3 class="page-title">
            Role Group <small>thông tin nhóm quyền người dùng</small>
            </h3>
            <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
%{--                <g:render template="/templates/m-melanin-action-bar"--}%
%{--                          model="${[--}%
%{--                                  buttons: [[name: 'm-melanin-action-bar-button-create-role-group', label: 'Tạo mới', class: 'default']]--}%
%{--                          ]}"/>--}%
                <g:render template="/templates/m-melanin-breadcrum"
                          model="${[
                                  items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                          [href: createLink(controller: 'fingerprint', action: 'index'), title: 'Fingerprint Control Panel', label: 'Fingerprint'],
                                          [href: createLink(controller: 'fingerprint', action: 'roleGroup'), title: 'Role Group Management', label: 'Role Group Management']]
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
                <div id="m-melanin-form-section">
                    <!-- BEGIN Div nhap tt kh -->
                    <div id="div_themmoi_capnhat_role_group">

                    </div>
                    <!-- END Div nhap tt kh -->
                </div>

                <!-- BEGIN DATA TABLE -->
                <div class="portlet box lpbblue">
                    <div class="portlet-title">
                        <div class="caption" id="m-melanin-form-user-details-legend">
                            <i class="icon-reorder"></i> Danh sách nhóm quyền người dùng
                        </div>
                    </div>

                    <div class="portlet-body">
                        <div id="m-melanin-fingerprint-role-table-section"
                             class="table-scrollable">
                            <table id="m-melanin-fingerprint-role-table"
                                   class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
                                <thead>
                                <tr>
                                    <th>Role Group ID</th>
                                    <th style="width: 200px !important;">Mã nhóm quyền</th>
                                    <th>Tên nhóm quyền</th>
%{--                                    <th>Hành động</th>--}%
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${RoleGroup.list()}" var="rolegroup">
                                    <tr>
                                        <td>
                                            ${rolegroup?.id}
                                        </td>
                                        <td style="width:150px !important; word-break: break-all !important;">${rolegroup?.authority}</td>
                                        <td>
                                            ${rolegroup?.name}
                                        </td>
%{--                                        <td>--}%
%{--                                            27112019 tam thoi rao ko cho sua--}%
%{--                                            <g:if test="${rolegroup?.name!='Admin'}">--}%
%{--                                                <a href='#' rel='${rolegroup?.id}' class='editRoleGroup icon-edit'></a>--}%
%{--                                                <a href='#' rel='${rolegroup?.id}'--}%
%{--                                                   class='deleteRoleGroup icon-trash'></a>--}%
%{--                                            </g:if>--}%
%{--                                        </td>--}%
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <!-- END DATA TABLE -->
            </div>
        </div>
    </div>
    <!-- END PAGE CONTENT-->
</div>
<!-- END CONTAINER -->



<script type="text/javascript">
    $(function () {
        set_side_bar(true);
        add_tab('#', 'Security', 'security');
        set_active_tab('security');
        $("#m-melanin-vertical-navigation-role-group").closest('li').addClass('active');
        $('#m-melanin-vertical-navigation-role-group').append('<span class="selected"></span>');
        $.configureBoxes();
        melanin_validate.role_validate();

//        nút thêm nhóm quyền mới
        $("button[name=m-melanin-action-bar-button-create-role-group]").click(function () {
            $.ajax({
                type: "POST",
                async: false,
                url: "${createLink(controller:'fingerprint',action:'add_role_requestmap')}",
                success: function (data) {
                    if (data.success) {
                        if ($("#m-melanin-form-section").css("display") == "none") {
                            $("#m-melanin-form-section").show('blind');
                        }
                        common.showSpinner();
                        $('.div_themmoi_capnhat_role_group').empty();
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "${createLink(controller:'fingerprint',action:'lay_div_addupdate_rolegroup')}",
                            success: function (data) {
                                common.hideSpinner();
                                $('#div_themmoi_capnhat_role_group').html(data.divCC);
                                $('#div_themmoi_capnhat_role_group').show('blind');
                            },
                            error: function (err) {
                                $('.div_themmoi_capnhat_role_group').empty();
                                common.hideSpinner();
                                common.showToastr('error', 'Lỗi', err, 'toast-bottom-right');
                            }
                        });

                        $('.clearText').val('');
                        $('.clearArea').empty();
                        $("#list_function_by_module").val("[[];[];[];[];[];[];[]]");
                        $("input[name=roleId]").val("");
                        $("#allTo1").click();
                        $("input[name=authority]").val("");
                        $("#m-melanin-form-role-details-legend").html("Create new role");
                        $("button[name=m-melanin-form-button-delete]").hide();
                    }
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

        $('.editRoleGroup').click(function (e) {
            e.preventDefault();
            if ($("#m-melanin-form-section").css("display") == "none") {
                $("#m-melanin-form-section").show('blind');
            }
            $('#div_themmoi_capnhat_role_group').empty();
            var role_id = $(this).attr("rel");
            $.ajax({
                type: "POST",
                async: false,
                data: {role_id: role_id},
                url: "${createLink(controller:'fingerprint',action:'lay_div_addupdate_rolegroup')}",
                success: function (data) {
                    common.hideSpinner();
                    $('#div_themmoi_capnhat_role_group').html(data.divCC);
                    $('#div_themmoi_capnhat_role_group').show('blind');
                },
                error: function (err) {
                    $('#div_themmoi_capnhat_role_group').empty();
                    common.hideSpinner();
                    common.showToastr('error', 'Lỗi', err, 'toast-bottom-right');
                }
            });

            $("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
            $("#m-melanin-form-id").val($(this).attr("rel"));
            $("#m-melanin-form-role-details-legend").html("Edit role: " + $(this).attr("rel"));
            $("button[name=m-melanin-form-button-delete]").show();
            $("button[name=m-melanin-form-button-delete]").attr("rel", $(this).attr("rel"));
            common.goTop();
        });

        %{--$(".m-melanin-authority-link").click(function (e) {--}%
        %{--e.preventDefault();--}%
        %{--if ($("#m-melanin-form-section").css("display") == "none") {--}%
        %{--$("#m-melanin-form-section").show('blind');--}%
        %{--}--}%
        %{--$("#allTo1").click();--}%
        %{--$("input[name=authority]").val($(this).html());--}%
        %{--var arr_users = [];--}%
        %{--$.get('${createLink(controller:'fingerprint',action:'findUsersByRole')}/' + $(this).attr('rel'),--}%
        %{--function (data) {--}%
        %{--for (var i = 0; i < data.length; i++) {--}%
        %{--$("select[name=sourceUsers] option[value=" + data[i].id + "]").attr("selected", "true");--}%
        %{--}--}%
        %{--$("#to2").click();--}%
        %{--});--}%
        %{--$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));--}%
        %{--$("#m-melanin-form-id").val($(this).attr("rel"));--}%
        %{--$("#m-melanin-form-role-details-legend").html("Edit role: " + $(this).attr("rel"));--}%
        %{--$("button[name=m-melanin-form-button-delete]").show();--}%
        %{--$("button[name=m-melanin-form-button-delete]").attr("rel", $(this).attr("rel"));--}%

        %{--common.goTop();--}%
        %{--});--}%

        $('.deleteRoleGroup').click(function (e) {
            e.preventDefault();
            var rid = $(this).attr("rel");
            var messageContent = common.messageContent('icon-ok-sign', 'M', null, 'Bạn chắc chắn muốn xóa nhóm quyền này?');
            var titleContent = common.titleContent(null, 'Xác nhận');

            common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa nhóm quyền này?', function (result) {
                if (result) {
                    common.showSpinner();
                    document.location = "${createLink(controller:'fingerprint',action:'deleteRoleGroup')}/" + rid;
                    common.hideSpinner();
                }
            });
        });
    });
</script>

</body>
</html>
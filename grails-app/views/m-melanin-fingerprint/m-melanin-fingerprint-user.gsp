<%@ page import="com.melanin.fingerprint.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Control Panel | User Management</title>
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

                    <g:render template="/templates/m-melanin-action-bar"
                              model="${[
                                      buttons: [[name: 'm-melanin-action-bar-button-create-user', class: 'primary', label: 'Create']]
                              ]}"/>
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
                                                        You have some form errors. Please check below.
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label">Tên truy cập <span
                                                                        class="required">*</span></label>

                                                                <div class="col-md-4">
                                                                    <g:textField name="username" type="text"
                                                                                 class="form-control"
                                                                                 placeholder="Enter outlook username."/>
                                                                </div>

                                                                <label class="col-md-2 control-label">Đơn vị <span
                                                                        class="required">*</span></label>

                                                                <div class="col-md-4">
                                                                    <g:select name="branchID"
                                                                              from="${Branch.findAllByActiveAndStatusIsNull(true)}"
                                                                              class="form-control input-lg "
                                                                              optionKey="id" optionValue="name"
                                                                              noSelection="['': '-Choose Branch-']"/>
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
                                                                                     placeholder="Enter password."
                                                                                     class="form-control"/>
                                                                </div>
                                                                <label class="col-md-2 control-label">Trạng thái</label>

                                                                <div class="col-md-4">
                                                                    %{--<label class="checkbox-inline">
                                                                        <g:checkBox name="enabled"/>--}%
                                                                    <g:select id="enabled" name="enabled"
                                                                              class="form-control clearText"
                                                                              from="['Active', 'Inactive']"
                                                                              keys="${['true', 'false']}"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label">Họ tên <span
                                                                        class="required">*</span></label>

                                                                <div class="col-md-4">
                                                                    <g:textField name="fullname" type="text"
                                                                                 class="form-control"
                                                                                 placeholder="Enter full name."/>
                                                                </div>
                                                                <label class="col-md-2 control-label">Email <span
                                                                        class="required">*</span></label>

                                                                <div class="col-md-4">
                                                                    <g:textField name="email" type="text"
                                                                                 class="form-control"
                                                                                 placeholder="Enter email."/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="display: none">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label">Số điện thoại</label>

                                                                <div class="col-md-4">
                                                                    <input type="text" id="prop1" name="prop1" type="text"
                                                                           class="form-control ${message(code: "com.melanin.fingerprint.user.prop1CssClass", default: "e-xxl")}"
                                                                           placeholder="Enter property 1"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="display: none">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label">Chức danh <span
                                                                        class="required">*</span></label>

                                                                <div class="col-md-4">
                                                                    <g:select name="jobTitle" id="jobTitle"
                                                                              class="form-control input-lg"
                                                                              from="${JobTitle.list()}" optionKey="id"
                                                                              optionValue="name"
                                                                              noSelection="['0': '----------']"/>
                                                                </div>
                                                                <label class="col-md-2 control-label"><g:message
                                                                        code="com.melanin.fingerprint.user.prop2"
                                                                        default="Property 2"/></label>

                                                                <div class="col-md-4">
                                                                    <input type="text" id="prop2" name="prop2" type="text"
                                                                           class="form-control ${message(code: "com.melanin.fingerprint.user.prop2CssClass")}"
                                                                           placeholder="Enter property 2"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="display: none">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label"><g:message
                                                                        code="com.melanin.fingerprint.user.prop3"
                                                                        default="Property 3"/></label>

                                                                <div class="col-md-4">
                                                                    <input type="text" id="prop3" name="prop3" type="text"
                                                                           class="form-control ${message(code: "com.melanin.fingerprint.user.prop3CssClass")}"
                                                                           placeholder="Enter property 3"/>
                                                                </div>
                                                                <label class="col-md-2 control-label"><g:message
                                                                        code="com.melanin.fingerprint.user.prop4"
                                                                        default="Property 4"/></label>

                                                                <div class="col-md-4">
                                                                    <input type="text" id="prop4" name="prop4" type="text"
                                                                           class="form-control ${message(code: "com.melanin.fingerprint.user.prop4CssClass")}"
                                                                           placeholder="Enter property 4"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="display: none">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label"><g:message
                                                                        code="msb.platto.fingerprint.user.prop5"
                                                                        default="Property 5"/></label>

                                                                <div class="col-md-4">
                                                                    <input type="text" id="prop5" name="prop5" type="text"
                                                                           class="form-control ${message(code: "msb.platto.fingerprint.user.prop5CssClass")}"
                                                                           placeholder="Enter property 5"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="form-group">
                                                                <label class="col-md-2 control-label">Roles</label>

                                                                <div class="col-md-4">
                                                                    <g:each in="${Role.list()}" var="role">
                                                                        <g:checkBox name="roles" value="${role.authority}"
                                                                                    checked="false"/><label>${role.authority}</label><br/>
                                                                    </g:each>
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

                                <div class="portlet-body form">
                                    <g:form controller="fingerprint" action="searchuser2" id="form-search">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">Đơn vị</label>

                                                    <div class="col-md-4">
                                                        <g:select id="branch" name="branch"
                                                                  noSelection="${['': '--Chọn--']}"
                                                                  class="form-control select2"
                                                                  from="${Branch.list()}" optionKey="id"
                                                                  optionValue="name"/>
                                                    </div>
                                                    <label class="control-label col-md-2">Nhóm quyền</label>

                                                    <div class="col-md-4">
                                                        <g:select id="role" name="role"
                                                                  noSelection="${['': '--Chọn--']}" class="form-control"
                                                                  from="${com.melanin.security.Role.list()}"
                                                                  optionKey="id" optionValue="authority"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label col-md-2">Tên truy cập</label>

                                                    <div class="col-md-4">
                                                        <input
                                                                class="form-control clearText validate[required]"
                                                                type="text" id="username"
                                                                data-minlength="4" name="username">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-actions fluid">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button class="btn btn-search" name="m-melanin-form-button-search">
                                                    <i class="icon-search"></i> Tìm kiếm
                                                </button>
                                            </div>
                                        </div>
                                    </g:form>
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
                                       class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
                                    <thead>
                                    <tr>
                                        <th>STT</th>
                                        %{--<th>ID</th>--}%
                                        <th>Tên đăng nhập</th>
                                        <th>Họ tên</th>
                                        <th>Đơn vị</th>
                                        <th>Quyền</th>
                                        <th>Email</th>
                                        <th>Chỉ dùng mật khẩu AD ?</th>
                                        <th>Trạng thái</th>
                                        <th style="display:none">branch-id</th>
                                        <th>Hành động</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${listuser}" var="user" status="i">
                                        <tr>
                                            <td>${i+1}</td>
                                            %{--<td id="userid">${user.id}</td>--}%
                                            <td id="m-melanin-fingerprint-td-username-${user.id}">${user.username}</td>
                                            <td id="m-melanin-fingerprint-td-fullname-${user.id}">${user.fullname}</td>
                                            <td id="m-melanin-fingerprint-td-branch-${user.id}">${user.branch?.name}</td>
                                            <td id="m-melanin-fingerprint-td-roles-${user.id}">${UserRole.findAllByUser(user).role.authority}</td>
                                            <td id="m-melanin-fingerprint-td-email-${user.id}">${user.email}</td>
                                            <td id="m-melanin-fingerprint-td-adOnly-${user.id}"><g:if
                                                    test="${user.adOnly}"><span
                                                        class="ss_sprite ss_tick">&nbsp;</span></g:if></td>
                                            <td id="m-melanin-fingerprint-td-enabled-${user.id}"><g:if
                                                    test="${user.enabled}"><span
                                                        class="ss_sprite ss_tick">&nbsp;</span></g:if></td>
                                            <td id="m-melanin-fingerprint-td-branch-id-${user.id}"
                                                style="display:none">${user.branch?.id}</td>
                                            <td>
                                                <a href="#" rel="${user.id}" class="editUrl icon-edit"></a>&nbsp;&nbsp;
                                                <a href="#" rel="${user.id}" class="deleteUrl icon-trash"></a>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                        <!-- END DATA TABLE -->
                    </div>
                </div>
            </div>
            <!-- END PAGE -->
        </div>
        <!-- END CONTAINER -->


        <script type="text/javascript">
            $(function () {

                set_side_bar(true);
                add_tab('#', 'Security', 'security');
                set_active_tab('security');

                $('#branchID').select2({
                    allowClear: true
                });

                $('#branch').select2({
                    allowClear: true
                });

                $('#role_group').select2({
                    allowClear: true
                });

                melanin_validate.user();

                $("#m-melanin-vertical-navigation-user").closest('li').addClass('active');
                $("#m-melanin-vertical-navigation-user").append('<span class="selected"></span>');

                $("button[name=m-melanin-action-bar-button-create-user]").click(function () {
                    if ($("#m-melanin-form-section").css("display") == "none") {
                        $("#m-melanin-form-section").show('blind');
                    }
                    $("#branchID").select2("val", "");
                    $("input[name=userId]").val("");
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
                    $("#m-melanin-form-user-details-legend").html("Create new user");
                    $("button[name=m-melanin-form-button-delete]").hide();
                });

                $("button[name=m-melanin-form-button-cancel]").click(function (e) {
                    $("#m-melanin-form-section").hide('blind');
                    e.preventDefault();
                });

                $('.editUrl').click(function (e) {
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

                $(".m-melanin-username-link").live('click', function (e) {
                    e.preventDefault();
                    if ($("#m-melanin-form-section").css("display") == "none") {
                        $("#m-melanin-form-section").show('blind');
                    }
                    $("input[name=enabled]").removeAttr("checked");
                    $("input[name=enabled]").parent().removeClass('checked');
                    $("input[name=roles]").removeAttr("checked");
                    $("input[name=roles]").parent().removeClass('checked');
                    $("input[name=adOnly]").removeAttr("checked");
                    $("input[name=adOnly]").parent().removeClass('checked');
                    $("input[name=username]").val($(this).html());
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
                        console.log('role: ' + $("#m-melanin-form-section input[value=" + arr_roles[i] + "]"));
                        $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").parent().addClass('checked');
                        $("#m-melanin-form-section input[value=" + arr_roles[i] + "]").attr('checked', 'checked');
                    }
                    if ($("#m-melanin-fingerprint-td-enabled-" + $(this).attr("rel")).html()) {
                        $("input[name=enabled]").attr("checked", "checked");
                        $("input[name=enabled]").parent().addClass('checked');
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

                $('.deleteUrl').click(function (e) {
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
            });

            function deleteUser(uid) {
                common.showSpinner();
                document.location = "${createLink(controller:'fingerprint',action:'deleteUser')}/" + uid;
                common.hideSpinner();
                $(commonConfig.modal.id).modal('hide');
            }
        </script>
    </div>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: nhatmq1
  Date: 12/23/2015
  Time: 5:23 PM
--%>

<%@ page import="com.melanin.commons.MenuItem" %>
<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout"/>
    <title>Control Panel | Menu Item Management</title>
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN PAGE -->
    <div class="page-content">
        <!-- BEGIN PAGE CONTENT -->
        <!-- BEGIN PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    Menu Item
                    <small>thông tin menu</small>
                </h3>
                <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                    <g:render template="/templates/m-melanin-breadcrum"
                              model="${[
                                      items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                              [href: createLink(controller: 'fingerprint', action: 'index'), title: 'Fingerprint Control Panel', label: 'Fingerprint'],
                                              [href: createLink(controller: 'fingerprint', action: 'menuItem'), title: 'Menu Management', label: 'Menu Management']]
                              ]}"/>
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <div id="m-melanin-main-content" class="m-melanin-high-density">
            <g:if test="${flash.error}">
                <div class="error">${flash.error}</div>
            </g:if>
            <div id="m-melanin-form-section">
                <g:form id="m-melanin-form-menuItem-details" name="m-melanin-form-menuItem-details"
                        controller="fingerprint" action="saveMenuItem" class="form-horizontal">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet box lpbblue">
                                <div class="portlet-title">
                                    <div class="caption" id="m-melanin-form-menuItem-details-legend">
                                        <i class="icon-reorder"></i>
                                        Thay đổi quyền sử dụng Menu Item
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
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">ID<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="idz" id="idz" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."
                                                                     readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Tên menu<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="labelz" id="labelz" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Tên viết tắt<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="namez" id="namez" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."
                                                                     readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Controller<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="controllerz" id="controllerz" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."
                                                                     readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Action<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="actionz" id="actionz" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."
                                                                     readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Diễn giải<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:textField name="titlez" id="titlez" type="text"
                                                                     class="form-control required"
                                                                     placeholder="Enter menu name."/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group">
                                                    <label class="col-md-3 control-label">Quyền<span
                                                            class="required">*</span></label>

                                                    <div class="col-md-6">
                                                        <g:select name="rolez" id="rolez"
                                                                  from="${com.melanin.security.Role.findAll()}"
                                                                  class="form-control input-sm"
                                                                  optionKey="authority"
                                                                  optionValue="authority"
                                                                  multiple="true"
                                                                  noSelection="['': '']"/>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="form-actions fluid">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <g:hiddenField name="menuItemId"/>
                                                    <button type="button" class=" btn btn-save"
                                                            name="m-melanin-form-button-save">
                                                        <i class="icon-ok"></i> Save</button>
                                                    <button type="button" class="btn btn-cancel"
                                                            name="m-melanin-form-button-cancel"><i
                                                            class="icon-ban-circle"></i> Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:form>
            </div>

            <div class="portlet box lpbblue">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-list"></i>
                        Danh sách menu
                    </div>

                    <div class="tools">
                        <a href="javascript:;" class="collapse"></a>
                    </div>
                </div>

                <div class="portlet-body">
                    <div id="m-melanin-fingerprint-menuItem-table-section" class="table-scrollable">
                        <table id="m-melanin-fingerprint-menuItem-table"
                        %{--                               class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">--}%
                               class="table table-striped table-bordered table-hover no-footer">
                            <thead>
                            <tr>
                                %{--                                <th>ID</th>--}%
                                <th>Tên menu</th>
                                <th>Tên viết tắt</th>
                                <th>Controller</th>
                                <th>Action</th>
                                <th>Diễn giải</th>
                                <th>Quyền</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${MenuItem.findAllByControllerNotEqual("melanin",[sort: "ordernumber"])}" var="menuItem">
                                <tr>
                                    %{--                                    <td id="menuItemid">--}%
                                    %{--                                        <a href="#" rel="${menuItem.id}" class="m-melanin-menuItem-link">${menuItem.id}</a>--}%
                                    %{--                                    </td>--}%
                                    <td id="labelz-${menuItem.id}">${menuItem.label}</td>
                                    <td id="namez-${menuItem.id}">${menuItem.name}</td>
                                    <td id="controllerz-${menuItem.id}">${menuItem.controller}</td>
                                    <td id="actionz-${menuItem.id}">${menuItem.action}</td>
                                    <td id="titlez-${menuItem.id}">${menuItem.title}</td>
                                    <td id="rolez-${menuItem.id}">${menuItem.roles}</td>
                                    <td id="edit">
                                        <g:if test="${menuItem.roles != "ROLE_ADMIN"}">
                                            <a href="#" rel="${menuItem.id}"
                                               class="m-melanin-menuItem-link icon-edit"></a>
                                        </g:if>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END PAGE -->
</div>
<!-- END CONTAINER -->

<script type="text/javascript">
    $('#rolez').select2({
        placeholder: "-Chọn quyền sử dụng-",
        allowClear: true
    });

    set_active_tab('security');
    common.activeMenuSidebar('#m-melanin-vertical-navigation-menuItem');
    $('#m-melanin-vertical-navigation-menuItem').append('<span class="selected"></span>');

    $("button[name=m-melanin-form-button-cancel]").click(function () {
        $("#m-melanin-form-section").hide('blind');
        e.preventDefault();
    });
    $("button[name=m-melanin-form-button-save]").click(function () {
        $("#m-melanin-form-menuItem-details").submit();
    });
    $(".m-melanin-menuItem-link").click(function () {
        if ($("#m-melanin-form-section").css("display") == "none") {
            $("#m-melanin-form-section").show('blind');
        }
        var menuid = $(this).attr('rel');
        $('#idz').val(menuid);
        $("button[name=m-melanin-form-button-delete]").val(menuid);
        $('#namez').val($('#namez-' + menuid).html());
        $('#controllerz').val($('#controllerz-' + menuid).html());
        $('#actionz').val($('#actionz-' + menuid).html());
        $('#labelz').val($('#labelz-' + menuid).html());
        $('#titlez').val($('#titlez-' + menuid).html());
        if($('#rolez-' + menuid).html().split(",")[0]){
            $('#rolez').val($('#rolez-' + menuid).html().split(",")).trigger('change');
        }
        else {
            $('#rolez').val("null").trigger('change');
        }
    });

    $(document).ready(function () {
        $('#m-melanin-fingerprint-menuItem-table').DataTable({
            "scrollX": true,
            "ordering": false
        });
    });

</script>
</body>
</html>
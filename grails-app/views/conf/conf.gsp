<%@ page import="com.melanin.commons.Conf" %>
<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Conf management</title>

    <asset:stylesheet src="css/datatables.min.css"/>
%{--    <asset:javascript src="datatables.min.js"/>--}%
</head>

<body>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN PAGE -->
    <!-- BEGIN SIDEBAR -->
    <div id="sidebar" class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <ul class="page-sidebar-menu">
            <li>
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                <div class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
                <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            </li>
        </ul>
        <g:render template="/conf/m-melanin-conf-sidebar"></g:render>
    </div>
    <!-- END SIDEBAR -->
    <div class="page-content">
        <!-- BEGIN PAGE CONTENT -->
        <!-- BEGIN PAGE HEADER-->
        <div class="row">
            <div class="col-md-12">
                <!-- BEGIN PAGE TITLE & BREADCRUMB-->
                <h3 class="page-title">
                    Conf management
                    <small>cấu hình thông tin</small>
                </h3>
                <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                    <g:render template="/templates/m-melanin-action-bar"
                              model="${[
                                      buttons: [[name: 'm-melanin-action-bar-button-create-conf', class: 'primary', label: 'Create']]
                              ]}"/>
                    <g:render template="/templates/m-melanin-breadcrum"
                              model="${[
                                      items: [[href: '#', title: 'home', label: 'Home'],
                                              [href: '#', title: 'Control Panel', label: 'Conf management']]
                              ]}"/>
                </ul>
                <!-- END PAGE TITLE & BREADCRUMB-->
            </div>
        </div>
        <!-- END PAGE HEADER-->

        <!-- BEGIN CONTENT -->
        <div id="m-melanin-main-content">
            <g:if test="${flash.message}">
                <div class="alert-message ${flash.messageClass}">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${confInstance}">
                <div class="alert-message error">
                    <g:eachError bean="${confInstance}"><p><g:message error="${it}"/></p></g:eachError>
                </div>
            </g:hasErrors>
            <div id="m-melanin-form-section">
                <g:form name="m-melanin-form-conf-details" controller="conf" action="save" class="form-horizontal">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <div class="caption" id="m-melanin-form-conf-details-legend">
                                <i class="icon-reorder">
                                </i>
                                Create new conf
                            </div>
                        </div>

                        <div class="portlet-body form">
                            <div class="form-body">
                                <div class="form-group">
                                    <label for="label" class="col-md-2 control-label">Label</label>

                                    <div class="col-md-9">
                                        <g:textField name="label" class="form-control" value="${confInstance?.label}"/>
                                        <p class="help-block">Enter label</p>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="Type" class="col-md-2 control-label">Type</label>

                                    <div class="col-md-9">
                                        <g:textField name="type" class="form-control validate[required]"
                                                     value="${confInstance?.type}"/>
                                        <p class="help-block">Enter type</p>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="Value" class="col-md-2 control-label">Value</label>

                                    <div class="col-md-9">
                                        <g:textField name="value" class="form-control"
                                                     value="${confInstance?.value}"/>
                                        <p class="help-block">Enter value</p>

                                        <div id="editor2_error"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-actions fluid">
                                <div class="col-md-offset-2 col-md-9">
                                    <g:hiddenField name="id" value="${confInstance?.id}"/>
                                    <g:hiddenField name="version" value="${confInstance?.version}"/>
                                    <input type="submit" class="btn btn-save" value="Save"/>
                                    <input type="button" class="btn btn-cancel" value="Cancel"
                                           name="m-melanin-form-conf-button-cancel"/>
%{--                                    <input type="button" class="btn btn-delete" name="m-melanin-form-conf-button-delete"--}%
%{--                                           value="Delete"/>--}%

                                    %{--<g:hiddenField name="roleId" id="m-melanin-form-id"/>
                                    <button  class="btn green" ><i class="icon-ok"></i> Save</button>
                                    <button  class="btn red" name="m-melanin-form-button-delete"><i class="icon-trash"></i> Delete</button>
                                    <button class="btn yellow"  name="m-melanin-form-button-cancel"><i class="icon-ban-circle"></i> Cancel</button>--}%
                                </div>
                            </div>
                        </div>
                    </div>
                </g:form>
            </div>
            <!-- BEGIN DATA TABLE -->
            <div class="portlet box red">
                %{--  <div class="portlet-title">
                      <div class="caption" id="m-melanin-form-user-details-legend">
                          <i class="icon-reorder">
                          </i>
                          Cấu hình
                      </div>
                  </div>--}%
                <div class="portlet-title">
                    <div class="caption">
                        <i class="icon-globe"></i>
                        Cấu hình
                    </div>
                </div>

                %{--                <div class="portlet-body" id="gridData">--}%
                %{--                    <div id="m-melanin-fingerprint-table-section" class="table-scrollable">--}%
                %{--                        <table id="conf-table" class="table table-striped table-bordered table-hover dataTable no-footer">--}%
                <div class="portlet-body" id="gridData">
                    <div id="m-melanin-fingerprint-user-table-section" class="table-scrollable">
                        <table id="conf-table"
                               class="table table-striped table-bordered no-footer">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>ID</th>
                                <th>Label</th>
                                <th>Type</th>
                                <th>Value</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                </div>
            </div>
            <!-- END DATA TABLE -->
        </div>
        <!-- END CONTENT -->

        <!-- END PAGE CONTENT -->
    </div>
    <!-- END PAGE -->
</div>
<!-- END CONTAINER -->

<script type="text/javascript">
    jQuery(function () {
        set_active_tab('control-panel');
        common.activeMenuSidebar('#sidebar-conf');
        $('#sidebar-conf a').append('<span class="selected"></span>');

        //jQuery('form#m-melanin-form-conf-details').validationEngine();
        var table = $('#conf-table').DataTable({
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "${createLink(controller:'conf',action:'loadConf')}",
                "type": "post",
                "data": function (d) {
                    // d.username_search = $('#username_search').val();
                    // d.branch_search = $('#branch_search').val();
                    // d.role_search = $('#role_search').val();
                }
            },
            columnDefs: [
                {"targets": 0, "name": "stt"},
                {"targets": 1, "name": "id", "visible": false, "searchable": false},
                {"targets": 2, "name": "label"},
                {"targets": 3, "name": "type"},
                {"targets": 4, "name": "value"},
                {"targets": 5, "name": "lnk", "orderable": false}
            ],
            order: [[0, '']]
        });

        jQuery('#conf_filter input')
            .unbind('keypress keyup')
            .bind('keypress keyup', function (e) {
                if (e.keyCode == 13) {
                    oTable.fnFilter(jQuery(this).val());
                }
                return;

            });
        jQuery("button[name=m-melanin-action-bar-button-create-conf]").click(function () {
            jQuery("#m-melanin-form-section").slideDown();
            jQuery(':input', jQuery('form#m-melanin-form-form-details')).not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
            jQuery("input[name=id]").val("");
            jQuery("input[name=m-melanin-form-conf-button-delete]").hide();
            jQuery("div.alert-message").html("").remove();

        });
        jQuery("input[name=m-melanin-form-conf-button-cancel]").click(function () {
            jQuery("input[name=id]").val("");
            jQuery("#m-melanin-form-section").slideUp();
            jQuery("input[name=m-melanin-form-conf-button-delete]").hide();
            jQuery(':input', jQuery('form#m-melanin-form-conf-details')).not(':button, :submit, :reset').val('').removeAttr('checked').removeAttr('selected');
            jQuery("div.error").html("").remove();
        });
        if (jQuery("div.error").html() != '' && jQuery("div.error").html() != null) {
            jQuery("input[name=m-melanin-form-conf-button-delete]").hide();
            jQuery("#m-melanin-form-section").slideDown();
        }
        if (jQuery("input[name=id]").val() != null && jQuery("input[name=id]").val() != '' && jQuery("input[name=id]").val() != undefined) {
            jQuery("input[name=m-melanin-form-conf-button-delete]").show();
            jQuery("#m-melanin-form-section").slideDown();
        }
        jQuery("input[name=m-melanin-form-conf-button-delete]").click(function () {
            jquery_confirm("Delete conf", "Are you sure you want to delete this conf record?",
                function () {
                    jquery_open_load_spinner();
                    document.location = "${createLink(controller:'conf',action:'delete')}/" + jQuery("input[name=id]").val();
                });
        });
    });

    function renderConfIdLink(obj) {
        var num = obj.aData[obj.iDataColumn]
        return '<a href="${createLink(controller:'conf',action:'edit')}/' + num + '">' + num + "</a>";
    }

</script>
</body>
</html>
<%--
  Created by IntelliJ IDEA.
  User: nhatmq1
  Date: 12/23/2015
  Time: 5:23 PM
--%>

<%@page import="com.melanin.fingerprint.Module"%>
<%@page import="com.melanin.security.*" %>
<html>
<head>
    <meta name="layout" content="m-melanin-admin-layout" />
    <title>Control Panel | Module Management</title>
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
                    Module
                    <small>thông tin module</small>
                </h3>
                <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
                    <g:render template="/templates/m-melanin-action-bar"
                              model="${[
                                      buttons:[[name:'m-melanin-action-bar-button-create-module',class:'primary',label:'Create']]
                              ]}"/>
<%--                    <g:render template="/templates/m-melanin-breadcrum"--%>
<%--                              model="${[--%>
<%--                                      items:[[href:createLink(uri:'/'),title:'home',label:'Home'],--%>
<%--                                             [href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],--%>
<%--                                             [href:createLink(controller:'fingerprint',action:'module'),title:'Module',label:'Menu Management']]--%>
<%--                              ]}"/>--%>
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
                <g:form id="m-melanin-form-module-details" name="m-melanin-form-module-details" controller="fingerprint" action="saveModule" class="form-horizontal">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet box lpbblue">
                                <div class="portlet-title">
                                    <div class="caption" id="m-melanin-form-module-details-legend" >
                                        <i class="icon-reorder"></i>
                                        Create new Module
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <form action="#" class="form-horizontal">
                                        <div class="form-body">
                                            <div class="alert alert-danger display-hide">
                                                <button class="close" data-dismiss="alert"></button>
                                                You have some form errors. Please check below.
                                            </div>
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Name<span class="required">*</span></label>
                                                <div class="col-md-6">
                                                    <g:textField name="name" type="text" class="form-control validate[required]"
                                                                 placeholder="Enter menu name." />
                                                </div>
                                            </div>

                                            <div class="form-actions fluid">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <g:hiddenField name="moduleId"/>
                                                    <button type="button" class=" btn btn-save" name="m-melanin-form-button-save">
                                                        <i class="icon-ok"></i> Save</button>
                                                    <button class=" btn red" name="m-melanin-form-button-delete" >
                                                        <i class="icon-trash"></i> Delete</button>
                                                    <button class="btn btn-cancel"  name="m-melanin-form-button-cancel"><i class="icon-ban-circle"></i> Cancel</button>
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
                    <div id="m-melanin-fingerprint-module-table-section" class="table-scrollable">
                        <table id="m-melanin-fingerprint-module-table" class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th class="border-right">Name</th>
                                <th class="border-right">Code</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${Module.list()}" var="module">
                                <tr>
                                    <td id="moduleid">${module.id}</td>
                                    <td><a href="#" rel="${module.id}" class="m-melanin-module-link">${module.name}</a></td>
                                    <td>${module.code}</td>
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

<script>
    set_active_tab('security');
    common.activeMenuSidebar('#m-melanin-vertical-navigation-module');
    $('#m-melanin-vertical-navigation-module').append('<span class="selected"></span>');

    $("button[name=m-melanin-action-bar-button-create-module]").click(function(){
		if ($("#m-melanin-form-section").css("display") == "none"){
			$("#m-melanin-form-section").show('blind');
		}
		$("input[name=moduleId]").val("");
		$("input[name=name]").val("");
		$("#m-melanin-form-module-details-legend").html("Create new Module");
		$("#m-melanin-form-module-details-legend").append('<i class="icon-reorder"></i>');
		$("button[name=m-melanin-form-button-delete]").hide();
	});

	$("button[name=m-melanin-form-button-cancel]").click(function(e){
		$("#m-melanin-form-section").hide('blind');
		e.preventDefault();
	});

	$(".m-melanin-module-link").live('click',function(e){
		e.preventDefault();
		if ($("#m-melanin-form-section").css("display") == "none"){
			$("#m-melanin-form-section").show('blind');
		}
		$("input[name=name]").val($(this).html());
		$("input[name=moduleId]").val($(this).attr("rel"));
		$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
		$("#m-melanin-form-module-details-legend").html("Edit module: " + $(this).attr("rel"));
		$("#m-melanin-form-module-details-legend").append('<i class="icon-reorder"></i>');
		$("button[name=m-melanin-form-button-delete]").show();
		$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));
	});

	$('button[name=m-melanin-form-button-save]').live('click',function(e){
		if ($("form[name=m-melanin-form-module-details]").validationEngine('validate')) {
			$('#m-melanin-form-module-details').submit();
		}
	});

	$("button[name=m-melanin-form-button-delete]").click(function(e){
		e.preventDefault();
		var uid = $(this).attr("rel");
		common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa chức danh này ?', function(result) {	
      		if(result){
      			common.showSpinner();
		    	document.location = "${createLink(controller:'fingerprint',action:'deleteModule')}/" + uid;
		    	common.hideSpinner();	
           }
		});
	});
	function deleteJobTitle(id){		
		debugger;		
		common.showSpinner();
		document.location = "${createLink(controller:'fingerprint',action:'deleteModule')}/" + id;				
		common.hideSpinner();
		$(systemConfig.modal.id).modal('hide');
	}

</script>
</body>
</html>
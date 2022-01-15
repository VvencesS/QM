<%@page import="com.melanin.fingerprint.*" %>
<%@page import="com.melanin.security.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-admin-layout" />
		<title>Control Panel | Requestmap Management</title>
	</head>
	<body>
		<!-- BEGIN CONTAINER -->
		<div class="page-content">
			<!-- BEGIN PAGE HEADER-->
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN PAGE TITLE & BREADCRUMB-->
					<h3 class="page-title">
						Request map
						<small>thông tin request map</small>
					</h3>
					<ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
					<g:render template="/templates/m-melanin-action-bar"
						model="${[
								buttons:[[name:'m-melanin-action-bar-button-create-requestmap',label:'Create',class:'primary']]
							]}"/>
					<g:render template="/templates/m-melanin-breadcrum" 
						model="${[
								items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
								[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
								[href:createLink(controller:'fingerprint',action:'requestmap'),title:'Requestmap Management',label:'Requestmap Management']]
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
						<!-- BEGIN FORM SECTION -->
						<div id="m-melanin-form-section">
							<g:form name="m-melanin-form-requestmap-details" controller="fingerprint" action="addRequestmap" class="form-horizontal">
								<div class="row">
									<div class="col-md-12">
										<div class="portlet box lpbblue">
											<div class="portlet-title">
												<div class="caption" id="m-melanin-form-requestmap-details-legend" >
													<i class="icon-reorder">
													</i>
													Create request map
												</div>
											</div>
											<div class="portlet-body form">
												<form action="#" class="form-horizontal">
													<div class="form-body">
														<div id="alert-danger" class="alert alert-danger display-hide">
															<button class="close" data-dismiss="alert"></button>
															You have some form errors. Please check below.
														</div>
														<div class="form-group">
															<label class="col-md-3 control-label">URL<span class="required">*</span></label>
															<div class="col-md-6">
																<g:textField name="url" type="text" class="form-control "
																	placeholder="Enter requestmap URL." required="true"/>
																<span class="help-block">Enter URL expression to be configured.</span>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-3 control-label">Config Attribute<span class="required">*</span></label>
															<div class="col-md-6">
																<g:textField name="configAttribute" type="text" class="form-control"
																	placeholder="Enter config attribute." required="true"/>
																<span class="help-block">Enter security configuration for above URL.</span>
															</div>
														</div>
													</div>
													<div class="form-actions fluid">
														<div class="col-md-offset-3 col-md-9">
															<g:hiddenField name="requestmapId"/>
															<button name="m-melanin-form-button-save"  class="btn btn-save" ><i class="icon-ok"></i> Save</button>
															<button  class="btn btn-delete" name="m-melanin-form-button-delete"><i class="icon-trash"></i> Delete</button>
															<button class="btn btn-cancel"  name="m-melanin-form-button-cancel"><i class="icon-ban-circle"></i> Cancel</button>
														</div>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>									
							</g:form>
						</div>
						<!-- END FORM SECTION -->
						
						<!-- BEGIN DATA TABLE -->
						<div class="portlet box lpbblue">
							<div class="portlet-title">
								<div class="caption" >
									<i class="icon-reorder">
									</i>
									Danh sách request map
								</div>
							</div>
							<div class="portlet-body">
								<div id="m-melanin-fingerprint-requestmap-table-section" class="table-scrollable">
									<table id="m-melanin-fingerprint-requestmap-table" class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
										<thead>
											<tr>
												<th>Requestmap ID</th>
												<th>URL</th>
												<th>Config Attribute</th>
											</tr>
										</thead>
										<tbody>
											<g:each in="${RequestMap.list()}" var="requestmap">
												<tr>
													<td>${requestmap.id}</td>
													<td><a href="#" rel="${requestmap.id}" class="m-melanin-url-link">${requestmap.url}</a></td>
													<td id="m-melanin-fingerprint-td-configAttribute-${requestmap.id}">${requestmap.configAttribute}</td>
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
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');				
				set_active_tab('security');

				$("#m-melanin-vertical-navigation-requestmap").closest('li').addClass('active');
				$('#m-melanin-vertical-navigation-requestmap').append('<span class="selected"></span>');

				melanin_validate.requestmap();

				$("button[name=m-melanin-action-bar-button-create-requestmap]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=requestmapId]").val("");
					$("input[name=url]").val("");
					$("input[name=configAttribute]").val("");
					$("#m-melanin-form-requestmap-details-legend").html("Create new requestmap");
					$("button[name=m-melanin-form-button-delete]").hide();
				});

				$("button[name=m-melanin-form-button-cancel]").click(function(e){
					e.preventDefault();
					$("#m-melanin-form-section").hide('blind');
				});

				$(".m-melanin-url-link").click(function(e){
					e.preventDefault();
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=url]").val($(this).html());
					$("input[name=configAttribute]").val($("#m-melanin-fingerprint-td-configAttribute-"+$(this).attr("rel")).html());
					$("input[name=requestmapId]").val($(this).attr("rel"));
					$("#m-melanin-form-requestmap-details-legend").html("Edit requestmap: " + $(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").show();
					$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));

					common.goTop();
				});

				$('button[name=m-melanin-form-button-save]').click(function(e){
					e.preventDefault();
					if($('form[name=m-melanin-form-requestmap-details]').valid()){
						$('form[name=m-melanin-form-requestmap-details]').submit();
					}
				});


				$("button[name=m-melanin-form-button-delete]").click(function(e){
					e.preventDefault();
					var rmid = $(this).attr("rel");

					common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa request map này ?', function(result) {	
                  		if(result){
                  			common.showSpinner();
                  			document.location = "${createLink(controller:'fingerprint',action:'deleteRequestmap')}/" + rmid;
					    	common.hideSpinner();	
                       }
					});
				});
			});

			function deleteRequestMap(id){				
				jquery_open_load_spinner();
				document.location = "${createLink(controller:'fingerprint',action:'deleteRequestmap')}/" + id;
				jquery_close_load_spinner();
				$(systemConfig.modal.id).modal('hide');
			}
		</script>

	</body>
</html>
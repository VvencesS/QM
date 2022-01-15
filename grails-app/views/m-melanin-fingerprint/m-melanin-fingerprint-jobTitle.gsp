<%@page import="com.melanin.fingerprint.*" %>

<html>
	<head>
		<meta name="layout" content="m-melanin-admin-layout" />
		<title>Control Panel | Job Title Management</title>
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
							Job Title
							<small>thông tin Job Title</small>
						</h3>
						<ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
						<g:render template="/templates/m-melanin-action-bar"
						model="${[
								buttons:[[name:'m-melanin-action-bar-button-create-jobTitle',class:'primary',label:'Create']]
							]}"/>
						<g:render template="/templates/m-melanin-breadcrum" 
						model="${[
								items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
								[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
								[href:createLink(controller:'fingerprint',action:'jobTitle'),title:'User Management',label:'Job Title Management']]
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
						<g:form id="m-melanin-form-jobTitle-details" name="m-melanin-form-jobTitle-details" controller="fingerprint" action="savejobTitle" class="form-horizontal">
						<div class="row">
							<div class="col-md-12">
								<div class="portlet box lpbblue">
									<div class="portlet-title">
										<div class="caption" id="m-melanin-form-jobTitle-details-legend" >
											<i class="icon-reorder"></i>
											Create new Job Title
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
														<label class="col-md-3 control-label">Chức danh<span class="required">*</span></label>
														<div class="col-md-6">
															<g:textField name="name" type="text" class="form-control validate[required]"
																placeholder="Enter job title." required="true" />
														</div>
													</div>
											</div>
											<div class="form-actions fluid">
												<div class="col-md-offset-3 col-md-9">
													<g:hiddenField name="jobTitleId"/>
													<button type="button" class=" btn btn-save" name="m-melanin-form-button-save">
														<i class="icon-ok"></i> Save</button>
													<button class=" btn btn-delete" name="m-melanin-form-button-delete" >
														<i class="icon-trash"></i> Delete</button>
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
					
					<div class="portlet box lpbblue">
						<div class="portlet-title">
							<div class="caption">
								<i class="icon-list"></i>
								Danh sách chức danh
							</div>
							<div class="tools">
				               <a href="javascript:;" class="collapse"></a>               
				            </div>
						</div>
						<div class="portlet-body">
							<div id="m-melanin-fingerprint-jobTitle-table-section" class="table-scrollable">
								<table id="m-melanin-fingerprint-jobTitle-table" class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
									<thead>
										<tr>
											<th>ID</th>
											<th class="border-right">Job Title</th>
										</tr>
									</thead>
									<tbody>
										<g:each in="${JobTitle.list()}" var="jobTitle">
											<tr>
												<td id="jobTitleid">${jobTitle.id}</td> 
												<td><a href="#" rel="${jobTitle.id}" class="m-melanin-jobTitle-link">${jobTitle.name}</a></td>
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
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');				
				set_active_tab('security');

				$("#m-melanin-vertical-navigation-jobTitle").closest('li').addClass('active');
				$('#m-melanin-vertical-navigation-jobTitle').append('<span class="selected"></span>');

				melanin_validate.jobtitle();
				
				$("button[name=m-melanin-action-bar-button-create-jobTitle]").click(function(){
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=jobTitleId]").val("");
					$("input[name=name]").val("");
					$("#m-melanin-form-jobTitle-details-legend").html("Create new Job Title");
					$("#m-melanin-form-jobTitle-details-legend").append('<i class="icon-reorder"></i>');
					$("button[name=m-melanin-form-button-delete]").hide();
				});

				$("button[name=m-melanin-form-button-cancel]").click(function(e){
					$("#m-melanin-form-section").hide('blind');
					e.preventDefault();
				});

				$(".m-melanin-jobTitle-link").live('click',function(e){
					e.preventDefault();
					if ($("#m-melanin-form-section").css("display") == "none"){
						$("#m-melanin-form-section").show('blind');
					}
					$("input[name=name]").val($(this).html());
					$("input[name=jobTitleId]").val($(this).attr("rel"));
					$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
					$("#m-melanin-form-jobTitle-details-legend").html("Edit jobTitle: " + $(this).attr("rel"));
					$("#m-melanin-form-jobTitle-details-legend").append('<i class="icon-reorder"></i>');
					$("button[name=m-melanin-form-button-delete]").show();
					$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));
				});

				$('button[name=m-melanin-form-button-save]').live('click',function(e){
					//e.preventDefault();
					debugger;
					$('#m-melanin-form-jobTitle-details').submit();
					/*if($('#m-melanin-form-jobTitle-details').valid()){
						$('#m-melanin-form-jobTitle-details').submit();
					}*/
				});

				$("button[name=m-melanin-form-button-delete]").click(function(e){
					e.preventDefault();
					var uid = $(this).attr("rel");
					
					common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa chức danh này ?', function(result) {	
                  		if(result){
                  			common.showSpinner();
					    	document.location = "${createLink(controller:'fingerprint',action:'deletejobTitle')}/" + uid;
					    	common.hideSpinner();	
                       }
					});
				});
			});

			function deleteJobTitle(id){		
				debugger;		
				common.showSpinner();
				document.location = "${createLink(controller:'fingerprint',action:'deletejobTitle')}/" + id;				
				common.hideSpinner();
				$(systemConfig.modal.id).modal('hide');
			}
			
		</script>

	</body>
</html>
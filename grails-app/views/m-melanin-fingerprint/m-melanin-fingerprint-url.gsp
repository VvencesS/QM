<%@page import="com.melanin.fingerprint.*"%>
<%@page import="com.melanin.security.*"%>

<html>
<head>
<meta name="layout" content="m-melanin-admin-layout" />
<title>Control Panel | URL Management</title>
</head>
<body>
	<!-- BEGIN CONTAINER -->
	<div class="page-content">
		<!-- BEGIN PAGE HEADER-->
		<div class="row">
			<div class="col-md-12">
				<!-- BEGIN PAGE TITLE & BREADCRUMB-->
				<h3 class="page-title">
					URL Management <small>Nhóm link phân quyền ứng dụng</small>
				</h3>
				<ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
					<g:render template="/templates/m-melanin-action-bar"
						model="${[
								buttons:[[name:'m-melanin-action-bar-button-create-url',label:'Create',class:'default']]
							]}" />
					<g:render template="/templates/m-melanin-breadcrum"
						model="${[
								items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
								[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint'],
								[href:createLink(controller:'fingerprint',action:'url'),title:'Url Management',label:'Url Management']]
							]}" />
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
						<g:form name="m-melanin-form-url-details" controller="fingerprint"
							action="addUrl" class="form-horizontal">
							<div class="row">
								<div class="col-md-12">
									<!-- BEGIN Div nhap tt kh -->
									<div class="portlet box lpbblue">
										<div class="portlet-title">
											<div class="caption">
												<i class="icon-reorder"></i> Thêm mới/ Cập nhật URL
											</div>
										</div>
										<div class="portlet-body form">
											<g:form class="form-horizontal" name="formTimKiem"
												data-toggle="validator" id="formTimKiem">
												<div class="form-body">
													<div class="row">
														<div class="col-md-12">
															<div class="form-group">
																<label class="control-label col-md-2">Chọn
																	module*</label>
																<div class="col-md-4">
																	<g:select id="module" name="module"
																		noSelection="${['':'--Chọn--']}" class="form-control"
																		from="${Module.list()}" optionKey="id"
																		optionValue="name" />
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-12">
															<div class="form-group">
																<label class="control-label col-md-2">URL Group</label>
																<div class="col-md-4">
																	<div id="div_select_urlgroup">
																		<g:select id="urlgroup" name="urlgroup"
																			noSelection="${['':'--Chọn--']}" class="form-control"
																			from="${null}" optionKey="id" optionValue="name" />
																	</div>
																</div>
															</div>
														</div>
													</div>
													<div class="row">
														<div class="col-md-12">
															<div class="form-group">
																<label class="control-label col-md-2">URL</label>
																<div class="col-md-10">
																	<input
																		class="form-control clearText validate[required]"
																		type="text" id="url" value="${params.url}"
																		data-minlength="4" name="url">
																</div>
															</div>
														</div>
													</div>
													<div class="form-actions fluid">
														<div class="col-md-offset-3 col-md-9">
															<g:hiddenField name="urlId" />
															<button class="btn btn-save"
																name="m-melanin-form-button-save">
																<i class="icon-ok"></i> Save
															</button>
															<button class="btn red"
																name="m-melanin-form-button-delete">
																<i class="icon-trash"></i> Delete
															</button>
															<button name="m-melanin-form-button-cancel"
																class="btn yellow">
																<i class="icon-ban-circle"></i> Cancel
															</button>
														</div>
													</div>
												</div>
											</g:form>
										</div>
									</div>
									<!-- END Div nhap tt kh -->
								</div>
							</div>
						</g:form>
					</div>
					<!-- BEGIN DATA TABLE -->
					<div class="portlet box lpbblue">
						<div class="portlet-title">
							<div class="caption" id="m-melanin-form-user-details-legend">
								<i class="icon-reorder"> </i> Danh sách URL
							</div>
						</div>
						<div class="portlet-body">
							<div id="m-melanin-fingerprinturle-table-section"
								class="table-scrollable">
								<table id="m-melanin-fingerprint-url-table"
									class="m-melanin-datatable table table-striped table-bordered table-hover dataTable no-footer">
									<thead>
										<tr>
											<th>ID</th>
											<th>Module</th>
											<th style="display: none;">Module_id</th>
											<th>Usecase name</th>
											<th>URL Group</th>
											<th style="display: none;">URL Group id</th>
											<th>URL</th>
											<th>Hành động</th>
										</tr>
									</thead>
									<tbody>
									<g:each in="${Url.list(sort: "id", order: "desc")}" var="url" status="i">
											<tr>
												<td>${url?.id}</td>
												<td id="m-melanin-fingerprint-td-modulename-${url.id}">${url?.urlGroup?.module?.name}</td>
												<td style="display: none;" id="m-melanin-fingerprint-td-moduleid-${url.id}">${url?.urlGroup?.module?.id}</td>
												<td id="m-melanin-fingerprint-td-usecasename-${url.id}">${url?.urlGroup?.usecasename}</td>
												<td id="m-melanin-fingerprint-td-urlgroupname-${url.id}">${url?.urlGroup?.name}</td>
												<td style="display: none;" id="m-melanin-fingerprint-td-urlgroupid-${url.id}">${url?.urlGroup?.id}</td>
												<td id="m-melanin-fingerprint-td-url-${url.id}">${url?.url}</td>
												<td>
           											<a href="#" rel="${url.id}" class="editUrl icon-edit"></a>&nbsp;&nbsp;
          											<a href="#" rel="${url.id}" class="deleteUrl icon-trash"></a>
          										</td>
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
		$("#m-melanin-vertical-navigation-url").closest('li').addClass('active');
		$('#m-melanin-vertical-navigation-url').append('<span class="selected"></span>');
		$.configureBoxes();

		$('.select2').select2();

		$("button[name=m-melanin-action-bar-button-create-url]").click(function(){
			if ($("#m-melanin-form-section").css("display") == "none"){
				$("#m-melanin-form-section").show('blind');
			}
			$('#module').removeAttr('disabled');
			$('#urlgroup').removeAttr('disabled');
			$("input[name=urlId]").val("");
			$("#allTo1").click();
			$("input[name=authority]").val("");
			$("#m-melanin-form-url-details-legend").html("Create new url");
			$("button[name=m-melanin-form-button-delete]").hide();
		});

		$("button[name=m-melanin-form-button-cancel]").click(function(e){
			$("#m-melanin-form-section").hide('blind');
			e.preventDefault();
		});

		$('.editUrl').click(function(e){
			e.preventDefault();
			if ($("#m-melanin-form-section").css("display") == "none"){
				$("#m-melanin-form-section").show('blind');
			}
			$("#module").val($("#m-melanin-fingerprint-td-moduleid-"+$(this).attr("rel")).html());
			var module = $('#module').val();
			$('#module').attr('disabled', 'disabled');
			common.showSpinner();
			$.ajax({
				type: "POST",
				async:false,
				data:{module:module},
				url: "${createLink(controller:'fingerprint',action:'layurlgrouptheomodule')}",
				success : function(data) {
					common.hideSpinner();
					$('#div_select_urlgroup').html(data.divCC);
				},
				error : function(err) {
					$('#div_select_urlgroup').empty();
					common.hideSpinner();
					common.showToastr('error', 'Lỗi',err, 'toast-bottom-right');
				}
			});
			$("input[name=urlId]").val($(this).attr("rel"));
			$("#urlgroup").val($("#m-melanin-fingerprint-td-urlgroupid-"+$(this).attr("rel")).html());
			$('#urlgroup').attr('disabled', 'disabled');
			$("#url").val($("#m-melanin-fingerprint-td-url-"+$(this).attr("rel")).html()); 
			$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
			$("#m-melanin-form-id").val($(this).attr("rel"));
			$("#m-melanin-form-url-details-legend").html("Edit url: " + $(this).attr("rel"));
			$("button[name=m-melanin-form-button-delete]").show();
			$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));

			common.goTop();
		});

		$(".m-melanin-authority-link").click(function(e){
			e.preventDefault();
			if ($("#m-melanin-form-section").css("display") == "none"){
				$("#m-melanin-form-section").show('blind');
			}
			$("#module").val($("#m-melanin-fingerprint-td-moduleid-"+$(this).attr("rel")).html());
			$('#module').attr('disabled', 'disabled');
			var module = $('#module').val()
			common.showSpinner();
			$.ajax({
				type: "POST",
				async:false,
				data:{module:module},
				url: "${createLink(controller:'fingerprint',action:'layurlgrouptheomodule')}",
				success : function(data) {
					common.hideSpinner();
					$('#div_select_urlgroup').html(data.divCC);
				},
				error : function(err) {
					$('#div_select_urlgroup').empty();
					common.hideSpinner();
					common.showToastr('error', 'Lỗi',err, 'toast-bottom-right');
				}
			});
			$("input[name=urlId]").val($(this).attr("rel"));
			$("#urlgroup").val($("#m-melanin-fingerprint-td-urlgroupid-"+$(this).attr("rel")).html());
			$('#urlgroup').attr('disabled', 'disabled');
			$("#url").val($("#m-melanin-fingerprint-td-url-"+$(this).attr("rel")).html()); 
			$("button[name=m-melanin-form-button-delete]").val($(this).attr("rel"));
			$("#m-melanin-form-id").val($(this).attr("rel"));
			$("#m-melanin-form-url-details-legend").html("Edit url: " + $(this).attr("rel"));
			$("button[name=m-melanin-form-button-delete]").show();
			$("button[name=m-melanin-form-button-delete]").attr("rel",$(this).attr("rel"));

			common.goTop();
		});

		$('form[name=m-melanin-form-button-save]').click(function(e){
			e.preventDefault();
			if($('form[name=m-melanin-form-url-details]').valid()){
				$('form[name=m-melanin-form-url-details]').submit();
			}
		});

		$('.deleteUrl').click(function(e){
			e.preventDefault();
			var rid = $(this).attr("rel");
			var messageContent = common.messageContent('icon-ok-sign', 'M', null, 'Bạn chắc chắn muốn xóa url này?');
			var titleContent = common.titleContent(null, 'Xác nhận');

			common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa url này?', function(result) {	
          		if(result){
          			common.showSpinner();
          			document.location = "${createLink(controller:'fingerprint',action:'deleteUrl')}/" + rid;
			    	common.hideSpinner();	
               }
			});
		});

		$("button[name=m-melanin-form-button-delete]").click(function(e){
			e.preventDefault();
			var rid = $(this).attr("rel");
			var messageContent = common.messageContent('icon-ok-sign', 'M', null, 'Bạn chắc chắn muốn xóa url này?');
			var titleContent = common.titleContent(null, 'Xác nhận');

			common.confirm(null, null, 'M', 'Xác nhận', 'Bạn chắc chắn muốn xóa url này?', function(result) {	
          		if(result){
          			common.showSpinner();
          			document.location = "${createLink(controller:'fingerprint',action:'deleteUrl')}/" + rid;
			    	common.hideSpinner();	
               }
			});
		});

		$('#module').change(function() {
			if(!$('#module').val()||$('#module').val()==''){
				$('#div_select_urlgroup').empty();
			}else{
				var module = $('#module').val()
				common.showSpinner();
				$.ajax({
					type: "POST",
					async:false,
					data:{module:module},
					url: "${createLink(controller:'fingerprint',action:'layurlgrouptheomodule')}",
					success : function(data) {
						common.hideSpinner();
						$('#div_select_urlgroup').html(data.divCC);
					},
					error : function(err) {
						$('#div_select_urlgroup').empty();
						common.hideSpinner();
						common.showToastr('error', 'Lỗi',err, 'toast-bottom-right');
					}
				});
			}
		});
	});
	</script>


</body>
</html>
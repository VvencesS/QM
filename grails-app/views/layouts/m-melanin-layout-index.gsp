<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>
	<g:render   template="/templates/m-melanin-html-head" model="[theme:'ui-lightness']"/>
	<g:layoutHead />
</head>
<body class="page-header-fixed page-sidebar-closed">
<!-- BEGIN HEADER -->
<div class="header navbar navbar-inverse navbar-fixed-top">
	<g:render  template="/templates/m-melanin-header"
			   model="${[	logoURL:resource(dir:'images',file:'logomsb.png'),
							 avatarURL:resource(dir:'images',file:'avatar.jpg'),
							 menuTogglerURL:resource(dir:'images',file:'menu-toggler.png'),
							 appDescriptions:grailsApplication.config.msb.platto.melanin.appDescription]}"/>
</div>
<!-- END HEADER -->

<div class="top-menu">
	<!-- BEGIN MENU -->
	<div class="">
		<div id="m-melanin-navigation" class="hor-menu hidden-sm hidden-xs">
			<g:render  template="/templates/m-melanin-menu"
					   model="${[tabs:com.melanin.commons.MenuItem.findAll("from MenuItem where ordernumber >=0 order by ordernumber, id")]}"/>
		</div>
	</div>
	<!-- END MENU -->
</div>

<div class="clearfix"></div>
<!-- BEGIN BODY -->
<div class="page-container">
	<!-- BEGIN SIDEBAR -->
	<div class="page-sidebar navbar-collapse collapse">
		<!-- BEGIN SIDEBAR MENU -->
		<!-- begin template menu for mobile device -->
		<g:render template="/templates/m-melanin-mobile-menu"
				  model="${[tabs:com.melanin.commons.MenuItem.findAll("from MenuItem where ordernumber >=0 order by ordernumber, id")]}"/>
		<!-- end template menu for mobile device -->
		<!-- END SIDEBAR MENU -->
	</div>
	<!-- END SIDEBAR -->

</div>

<g:layoutBody />

<!-- END BODY -->

<!-- BEGIN FOOTER -->
<div class="footer footer-fixed-bottom">
	<div class="footer-inner">
		&copy; ${com.melanin.commons.Conf.findByLabel('copyright').value}
	</div>
	<div class="footer-tools">
		<span class="go-top">
			<i class="icon-angle-up"></i>
		</span>
	</div>

</div>

<input type="hidden" id = "toastrMessage" value= '${flash.message}'/>

<!-- Form modal -->
<div id="formModal" class="modal fade in" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="width:35%">
		<div class="modal-content" style="width:100%"></div>
	</div>
</div>

%{--<div class="modal fade" id="spinner" tabindex="-1" data-backdrop="static" data-keyboard="false" role="basic" aria-hidden="true">
	<img src="${resource(dir:'assets/img',file:'ajax-modal-loading.gif')}" alt="" class="loading">
</div>--}%
<div class="modal fade in" id="spinner" tabindex="-1" data-backdrop="static" data-keyboard="false" role="basic" aria-hidden="true">
	<img src="${resource(dir:'images',file:'ajax-modal-loading.gif')}" alt="" class="loading">
</div>

<!-- END CORE PLUGINS -->
<asset:javascript src="assets/scripts/app.js"/>
<asset:javascript src="melanin.validation.js"/>
<script>
	jQuery(document).ready(function() {
		App.init();
		common.setAutoHight();
	});
</script>

<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		$("select option").each(function(i){
			this.text = $(this).html(this.text).text();
		});
		common.commonInit();
		// common.showSpinner();
		$(".m-melanin-datatable").dataTable({
			'iDisplayLength':20,
			"sDom": 'frtip<"clearfix">T',
			"oLanguage": {
				"sSearch": "Tìm nhanh:",
				"sZeroRecords": "Không có dữ liệu",
				"sEmptyTable": "Không có dữ liệu",
				"sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ dòng.",
				"sInfoFiltered": "",
				"sInfoEmpty": 'Không tìm thấy dữ liệu.'
			},
			"oTableTools": {
				"sSwfPath": "${resource(dir:'images',file:'copy_cvs_xls.swf')}",
				"aButtons": [
					{
						"sExtends":    "xls",
						"sButtonText": "Xuất ra Excel"
					}
				]
			}
		});

		$(".tam-datatable").DataTable({
			"scrollX": true,
			"processing": true,
			// them trang dau trang cuoi "sPaginationType": "full_numbers",
			//neu muon su dung ajax thi them thang serverside vao
			// "serverSide": true,
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
			}
		});

		// common.hideSpinner();
	});
</script>
</body>
</html>
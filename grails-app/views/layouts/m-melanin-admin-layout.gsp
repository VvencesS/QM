<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
	"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title><g:layoutTitle default="${grailsApplication.config.msb.platto.melanin.appDescription}" /></title>
		<g:render  template="/templates/m-melanin-html-head" model="[theme:'ui-lightness']"/>
		<g:layoutHead />
    </head>
    <body class="page-header-fixed">
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
				<!-- begin template menu for mobile device -->
				<g:render  template="/templates/m-melanin-mobile-menu"
					model="${[tabs:com.melanin.commons.MenuItem.findAll("from MenuItem where ordernumber >=0 order by ordernumber, id")]}"/>
				<!-- end template menu for mobile device -->
			</div>
			<!-- END SIDEBAR -->

    	</div>

    	<div class="page-container">
    		<!-- BEGIN SIDEBAR -->
    		<div class="page-sidebar navbar-collapse collapse">
    			<!-- BEGIN SIDEBAR MENU -->
    			<ul class="page-sidebar-menu" id="sidebar-toggle-button">
    				<li>
					   <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					   <div class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
					   <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
					</li>
    			</ul>
				<g:render template="/m-melanin-fingerprint/m-melanin-fingerprint-sidebar"/>
				<!-- END SIDEBAR MENU -->
			</div>
			<!-- END SIDEBAR -->

    	</div>
    	<div>
    		<g:layoutBody />
    	</div>
    	<!-- END BODY -->

    	<!-- BEGIN FOOTER -->
    	<div class="footer footer-fixed-bottom">
                <div class="footer-inner">
					%{--2016 &copy; LPB - Power by M1TECH--}%
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

%{--        <div class="modal fade in hide" id="spinner" tabindex="-1" data-backdrop="static" data-keyboard="false" role="basic" aria-hidden="true">--}%
%{--           <img src="${resource(dir:'assets/img',file:'ajax-modal-loading.gif')}" alt="" class="loading">--}%
%{--        </div>--}%
		<div class="modal fade in" id="spinner" tabindex="-1" data-backdrop="static" data-keyboard="false" role="basic" aria-hidden="true">
			<img src="${resource(dir:'images',file:'ajax-modal-loading.gif')}" alt="" class="loading">
		</div>


        <!-- /Form modal -->

        <!-- END CORE PLUGINS -->


		<asset:javascript src="assets/scripts/app.js"/>
		<asset:javascript src="melanin.validation.js"/>
        <script>
                jQuery(document).ready(function() {
					//common.showSpinner();
                   App.init();
                   common.commonInit();
                   common.hideSpinner();
                });
        </script>

	<script type="text/javascript" charset="utf-8">
		$(document).ready(function(){
			common.showSpinner();
			var delayInMilliseconds = 300; //0.3 second
			setTimeout(function () {
				common.hideSpinner();
			}, delayInMilliseconds);

			//debugger;
			//common.showSpinner();
            $("select option").each(function(i){
                this.text = $(this).html(this.text).text();
            });
			$(".m-melanin-datatable").dataTable({
				/*"fnRowCallback": function( nRow, aData, iDisplayIndex ) {
				 $('td', nRow).attr('nowrap','nowrap');
				 return nRow;
				 },*/
				"fnRowCallback": function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
					/* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
					$('td:eq(2)', nRow).attr('nowrap',true);
					$('td:eq(3)', nRow).attr('nowrap',true);
					common.hideSpinner();
					return nRow;
				},
				//'iDisplayLength':20,
				"bProcessing": true,
				"bInfo" : true,
				"bPaginate":true,
				"sPaginationType": "full_numbers",
				//"sDom": 'frtip<"clearfix">T',
				sDom: 'lfrtip<"clearfix">T',
				"oLanguage": {
					"oPaginate":
					{
						"sNext": '&gt',
						"sLast": '&raquo',
						"sFirst": '&laquo',
						"sPrevious": '&lt'
					},
					"sSearch": "Tìm nhanh:",
					"sZeroRecords": "Không có dữ liệu",
					"sEmptyTable": "Không có dữ liệu",
					"sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ dòng.",
					"sInfoFiltered": "",
					"sInfoEmpty": 'Không tìm thấy dữ liệu.',
					"sProcessing": common.showSpinner()
				},
				"oTableTools": {
					"sSwfPath": "${resource(dir:'images',file:'copy_cvs_xls.swf')}",
					"aButtons": [
						{
							"sExtends":    "xls",
							"sButtonText": "Xuất ra Excel",
							"sButtonClass": "btn red",
							"sButtonClassHover" : "btn btn-danger"
						}
					]
				}
			});

			common.hideSpinner();
		});
	</script>
	</body>
</html>
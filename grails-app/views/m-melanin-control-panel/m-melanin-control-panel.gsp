<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
		<title>Control Panel</title>
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
				<ul class="page-sidebar-menu">
					<li id="sidebar-customer-dashboard">
						<a href="${createLink(controller:'conf',action:'index')}" class="">
							<i class="icon-cog"></i>
							<span class="title">Conf</span>
						</a>
					</li>
				</ul>
			</div>
			<!-- END SIDEBAR -->
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
								items:[[href:'#',title:'home',label:'Home'],
								[href:'#',title:'Melanin',label:'Melanin'],
								[href:'#',title:'Control Panel',label:'Control Panel']]
							]}"/>
						</ul>
						<!-- END PAGE TITLE & BREADCRUMB-->
					</div>
				</div>
				<!-- END PAGE HEADER-->
				
				<div id="m-melanin-main-content">
					<div class="clear"></div>
		
				</div>
			</div>
			<!-- END PAGE --> 
		</div>
		<!-- END CONTAINER -->
		
		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				set_active_tab('control-panel');
			});
		
			var sidebarSwitch = false;
			function toggle_sidebar(flag){
				set_side_bar(flag);
			}		    
		</script>

	</body>
</html>
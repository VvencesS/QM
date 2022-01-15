<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-test-button-1',label:'Action 1'],
						[name:'m-test-button-2',label:'Action 1'],
						[name:'m-test-button-3',label:'Toggle sidebar',class:'yellow']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'Sample page',label:'Sample page']]
					]}"/>
			<div class="clear"></div>
		</div>
		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li><span class=" ss_sprite ss_email">&nbsp;</span>Inbox <div class="right"><span class=" ss_sprite ss_arrow_refresh">&nbsp;</span></div></li>
				<li class="active"><span class=" ss_sprite ss_email_go">&nbsp;</span>Sent </li>
				<li><span class=" ss_sprite ss_bin">&nbsp;</span>Trash <div class="right"><span class=" ss_sprite ss_tab_delete">&nbsp;</span></div></li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
					
			<h2>Why is this layout "perfect"?</h2>
			<ul>
				<li>Works in all major browsers</li>
				<li><strong>Shrinks</strong> to 780px<br />This accomodates users with 800x600 resolution, with no horizontal scroll!</li>
				<li><strong>Grows</strong> to 1260px<br />This accomodates users with 1280x768 resolution and everything in between.</li>
				<li>This accomodates 90%+ of all internet users. You could easily make this layout grow larger, but be mindful of how line-length affects readability. Nobody wants to read a line of text 1980px long.</li>
				<li>The left sidebar is of "equal height" to the main content</li>
			</ul>
			<div style="width: 800px">
			<div class="alert-message info">This layout is based on Twitter's Bootstrap CSS framework. Click here to <a href="http://twitter.github.com/bootstrap/">view available CSS styles</a>.</div>
			</div>
			<div class="clear"></div>

		</div>


		<script type="text/javascript">
					$(function(){
						set_side_bar(true);
						set_active_tab('sample');
						$("input[name=m-test-button-3]").click(function(){
							toggle_sidebar(sidebarSwitch);
							sidebarSwitch=!sidebarSwitch;
						});
					});
				
					var sidebarSwitch = false;
					function toggle_sidebar(flag){
						set_side_bar(flag);
					}
			    </script>
	
	</body>
</html>
<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		<div class="clear"></div>
		<div id="m-melanin-main-content">
		For source code, check out SVN: <a href="#">
			source code</a>
		<p/>
		<h3>Javascript API:</h3>
		<p>By default, Melanin includes a <a href="#">m-melanin.js</a> file with these available API to help you manage your app:
		</p>
		User interface methods:
		<ul>
			<li><strong>set_side_bar(boolean)</strong>: show or hide the sidebar according to the parameter (true/false)</li>
			<li><strong>clear_tabs()</strong>: clear the navigation menu in case you want to create your own.</li>
			<li><strong>add_tab(href,title,id,order)</strong>: add a new tab with (unique) id into the navigation menu, order is optional. If the 'id' exists, 
				the tab won't be added.</li>
			<li><strong>set_active_tab(id)</strong>: hilight the tab with the specified id.</li>
		</ul>
		<br/>
		Data handling:
		<ul>
			<li><strong>parse_money(amount,locale='vn')</strong>: parse a string of money into a number in specific a locale, default to VN, e.g.: '5.000.000' -> 5000000.</li>
			<li><strong>format_money(amount,locale='vn')</strong>: format a number into money formatted string in a specific locale, default to VN, e.g.: 45000000 -> 45.000.000.</li>
		</ul>
		
		
		
		
		
		</div>
		
		<script type="text/javascript">
		$(function(){
			set_active_tab('source');
		});
	    </script>
	
	</body>
</html>
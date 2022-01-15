<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<div id="m-melanin-tab-header-inner">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-open-dialog',label:'Open dialog',class:'info'],
						[name:'m-open-input-dialog',label:'Open input dialog',class:'info'],
						[name:'m-test-button-3',label:'Toggle sidebar',class:'primary m-melanin-toggle-side-bar']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'Documentation page',label:'Documentation']]
					]}"/>
			</div>
			<div class="clear"></div>
		</div>
		<div id="m-melanin-left-sidebar">
			<ul class="m-melanin-vertical-navigation">
				<li><span class=" ss_sprite ss_email">&nbsp;</span><a>Test Inbox</a><div class="right"><span class=" ss_sprite ss_arrow_refresh">&nbsp;</span></div></li>
				<li class="active"><span class=" ss_sprite ss_email_go">&nbsp;</span><a>Documentation</a> </li>
				<li><span class=" ss_sprite ss_bin">&nbsp;</span><a>Trash</a> <div class="right"><span class=" ss_sprite ss_tab_delete">&nbsp;</span></div></li>
			</ul>
		</div>
		<div id="m-melanin-main-content">
			
			<div class="m-melanin-widget m-melanin-small-panel" id="m-melanin-small-panel-1">
				<h3>1. Website anatomy</h3>
				<div>
					<ul>
						<li><a href="#" id="m-melanin-spotlight-logo">Logo</a></li>
						<li><a href="#" id="m-melanin-spotlight-control-panel">Control panel</a></li>
						<li><a href="#" id="m-melanin-spotlight-navigation">Navigation tab</a></li>
						<li><a href="#" id="m-melanin-spotlight-tab-header">Tab header</a></li>
						<li><a href="#" id="m-melanin-spotlight-breadcrum">Breadcrum</a></li>
						<li><a href="#" id="m-melanin-spotlight-left-sidebar">Left sidebar</a></li>
						<li><a href="#" id="m-melanin-spotlight-widget-panel">Widget panel</a></li>

					</ul>
				</div>
			</div>
			<div class="m-melanin-widget m-melanin-medium-panel" id="m-melanin-medium-panel-1">
				<h3>2. How to </h3>
				<div>
					<ul>
						<li><a href="#2.1">Install PLATTO plugin</a></li>
						<li><a href="#2.2">Configure database connection - MySQL</a></li>
						<li><a href="#2.3">Configure security - Active Directory</a></li>
						<li><a href="#2.4">Configure global settings</a></li>
						<li><a href="#2.5">How can use generate all from domain for our app with melanin plugin </a></li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-1">
				<h3><a name="2.1">2.1 Install PLATTO (Melanin Wrapper) plugin</a></h3>
				<div>
					<ol>
						<li>Create a new Grails project - called FacebookClone.
							<p class="blockquote">c:\my_projects> grails create-app FacebookClone</p>	
						</li>
						<li>
							<p class="blockquote"></p>
							<p class="notice">Notice: File version may differ from time to time</p>
						</li>
						<li>Install Melanin plugin
							<p class="blockquote"></p>
							<p class="error"><strong><u></u></strong><p>
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-5">
				<h3><a name="2.2">2.2 Configure database connection - MySQL</a></h3>
				<div>
					<ol>
						<li>The default configuration when you install Melanin plugin is used for MySQL, you don't need to change any driver configuration.</li>
						<li>Open grails-app/conf/DataSource.groovy. Change the database connection URL according to your database name.
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-2">
				<h3><a name="2.3">2.3 Configure security - Active Directory</a></h3>
				<div>
					<ol>
						<li>When install Melanin plugin, your application is configured to use <a href="http://grails-plugins.github.com/grails-spring-security-core/docs/manual/">Spring Security plugin</a> for Grails and authenticates against Maritime Bank Active Directory. For more information on how to use Spring Security, please visit <a href="http://grails-plugins.github.com/grails-spring-security-core/docs/manual/">http://grails-plugins.github.com/grails-spring-security-core/docs/manual</a>
						<li>Open grails-app/conf/Config.groovy. Make sure this file contains the following Active Directory configuration:
							<p class="blockquote">
<br>								grails.plugins.springsecurity.ldap.context.managerDn = 'cn=,OU=,DC=,DC=,DC='

<br>								grails.plugins.springsecurity.ldap.context.managerPassword = ''
<br>								grails.plugins.springsecurity.ldap.context.server = ''
<br>								grails.plugins.springsecurity.ldap.authorities.groupSearchBase = 'cn=,OU=,DC=,DC=,DC='
<br>								grails.plugins.springsecurity.ldap.search.base = 'DC=,DC=,DC='

<br>								grails.plugins.springsecurity.ldap.search.filter="" // for Active Directory you need this
<br>								grails.plugins.springsecurity.ldap.search.searchSubtree = true
<br>								grails.plugins.springsecurity.ldap.auth.hideUserNotFoundExceptions = false
<br>								grails.plugins.springsecurity.ldap.authorities.retrieveDatabaseRoles = true

<br>								grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.melanin.security.User'
<br>								grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.melanin.security.UserRole'
<br>								grails.plugins.springsecurity.authority.className = 'com.melanin.security.Role'
<br>								grails.plugins.springsecurity.requestMap.className = 'com.melanin.security.RequestMap'
<br>								grails.plugins.springsecurity.securityConfigType = 'Requestmap'
							</p>
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-3">
				<h3><a name="2.4">2.4 Configure global settings before you code...</a></h3>
				<div>
					<ol>
						<li>Configure your grails-app/conf/Config.groovy to your needs
							<div class="blockquote">
							// Application settings<br/>
							msb.platto.melanin.searchController='lucket' // the search handler for the global search<br/>
							msb.platto.melanin.searchAction='search' // the search handler for the global search<br/>
							msb.platto.melanin.appDescription='Quản lý phiếu dự thưởng' // this will appear next to your logo<br/>
							msb.platto.melanin.appTimeOut=1000<br/>
							msb.platto.melanin.helpDocument='http://intranet/' // link to intranet documentation for your app<br/>
							msb.platto.fingerprint.defaultUrlMappings = [ROLE_ADMIN:'/fingerprint'] // default page for each roles<br/>
							//--@melanin--
							</div>
						</li>
						<li>Open grails-app/conf/DataSource.groovy. Change the database connection URL according to your database name.
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>
			<p/>
			<div class="m-melanin-widget m-melanin-large-panel" id="m-melanin-howto-4">
				<h3><a name="2.5">2.5 How can use generate all from domain for our app with melanin plugin </a></h3>
				<div>
					<ol>
						<li>Run this command (make sure , you have installed melanin plugin in your app, or you can run it in melanin) 
							<div class="blockquote">
									<br/>grails generate-melanin-all domainClass
									<br/>Example : generate-melanin-all msb.platto.commons.Car2
							</div>
						</li>
						<li>If correct, we will have 2 files in your app, that's view and controller
							<div class="blockquote">
									<br/>Example : in controller we have : msb.platto.commons.Car2Controller
									<br/>Example : in view we have : car2/car2.gsp
							</div>
						</li>
						<li>
							<br>You can run-app and look around on that,
							<br/>Next step we want to customs some columns on view's table
							<br/>Open controller and change it, example your domain we have 5 fields , but we only want to show 3 columns show
								<div class="blockquote">
									<br/>Change this: public static final def propertiesToShow = [] //if you want to get data from table
									<br/>Example : public static final def propertiesToShow = ['id','ord','type'] //make sure id, ord, type the same name in your domain
									<br/>Change this: public static final def headerTableToShow = [] //if you want to change header's name of table on view
									<br/>Example : public static final def headerTableToShow = ['title id','title ord','title type']
								</div>
							<br/> Search
								<div class="blockquote">
									<br/>Because in some case the field isn't basic type like int,long,string etc, it's domain object so we need custom our own search
									<br/>Find function closFilter in controller and change it in if(propertiesToShow){change in here}
									<br/>Example: if(propertiesToShow){
									<br/>eq "id" , NumberUtils.toLong(val,0)
									<br/>eq "ord" ,NumberUtils.toInt(val,0)
					   				<br/>like "user.name" ,  "%"+val+"%"
									<br/>}
									<br/>We will search with 3 fields , id, ord search equal,type search like 
								</div>
							<br/> 
							<br/> Render data
								<div class="blockquote">
									<br/>Again in some case the field isn't basic type like int,long,string etc, it's domain object so we need custom our render data to table
									<br/>Find function closRenderCustom in controller and change it
									<br/>After generate all for domain, we will have function
									<br/>def closRenderCustom = {dataObject, returnObject->
									<br/>	//returnObject << dataObject.id << dataObject.user.name
									<br/>	propertiesToShow.each {
									<br/>		returnObject << dataObject[it]
									<br/>		}
									<br/>}
									<br/> Example we will change it
									<br/>def closRenderCustom = {dataObject, returnObject->
									<br/>	returnObject << dataObject.id 
									<br/>	returnObject << dataObject.user.name
									<br/>}
								</div>
							<br/>Everything else please don't change it.
							<br/>Please look around on Car2Controller and car2.gsp view to detail what we will change. 
						</li>
					</ol>
				</div>
			</div>
			<div class="clear"></div>

		</div>

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				set_active_tab('documentation');
				$("button[name=m-open-dialog]").click(function(){
					jquery_confirm('Example Dialog',"There are 3 types of dialog: alert, confirm and input dialogs, just like javascript.<br/>"+
							"Look up the API in the API tab."
							);
				});
				$("button[name=m-open-input-dialog]").click(function(){
					jquery_input('Example Input Dialog',"Please enter anything:<br/>",function(data){
						jquery_alert('Example input','You have entered: ' + data);	
					});
				});
				
				$("#m-melanin-spotlight-logo").click(function(){
					$("#m-melanin-logo").spotlight(); return false;
				});
				$("#m-melanin-spotlight-navigation").click(function(){
					$("#m-melanin-navigation").spotlight(); return false;
				});
				$("#m-melanin-spotlight-control-panel").click(function(){
					$("#m-melanin-control-panel").spotlight(); return false;
				});
				$("#m-melanin-spotlight-tab-header").click(function(){
					$("#m-melanin-tab-header").spotlight(); return false;
				});				
				$("#m-melanin-spotlight-breadcrum").click(function(){
					$("#m-melanin-breadcrum").spotlight(); return false;
				});				
				
				$("#m-melanin-spotlight-left-sidebar").click(function(){
					$("#m-melanin-left-sidebar").spotlight(); return false;
				});				
				$("#m-melanin-spotlight-widget-panel").click(function(){
					$(".m-melanin-widget").spotlight(); return false;
				});				
				$("input[name=m-test-button-3]").click(function(){
					toggle_sidebar(sidebarSwitch);
					sidebarSwitch=!sidebarSwitch;
				});
				$(".m-melanin-small-panel").panel({
					width:200,
					cookies:true
				});
				$(".m-melanin-medium-panel").panel({
					width:400,
					cookie:true
				});
				$(".m-melanin-large-panel").panel({
					width:620,
					cookie:true
				});
			});
			    
		</script>

	</body>
</html>
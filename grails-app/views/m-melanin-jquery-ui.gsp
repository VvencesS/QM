<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-tab-header">
			<div id="m-melanin-tab-header-inner">
			<g:render template="/templates/m-melanin-action-bar"
				model="${[
						buttons:[[name:'m-test-button-1',label:'Action 1'],
						[name:'m-test-button-2',label:'Action 1'],
						[name:'m-test-button-3',label:'Action 1',class:'yellow']]
					]}"/>
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:'#',title:'home',label:'Home'],
						[href:'#',title:'Melanin',label:'Melanin'],
						[href:'#',title:'jQuery UI',label:'jQuery UI']]
					]}"/>
			</div>
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
			
			<h3>jQuery UI</h3>
			<h3>Dialog</h3>
			<a href="#" onclick="javascript:jquery_alert('A test dialog','Hello world.');return false;">Open dialog</a>
			<h3 class="demoHeaders">Accordion</h3>

			<div role="tablist" class="ui-accordion ui-widget ui-helper-reset ui-accordion-icons" id="accordion">
				<h3 tabindex="0" aria-selected="true" aria-expanded="true" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-state-active ui-corner-top"><span class="ui-icon ui-icon-triangle-1-s"></span><a tabindex="-1" href="#">Section 1</a></h3>
				<div role="tabpanel" style="height: 125px;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active">
					<p>Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.</p>
				</div>
				<h3 tabindex="-1" aria-selected="false" aria-expanded="false" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all"><span class="ui-icon ui-icon-triangle-1-e"></span><a tabindex="-1" href="#">Section 2</a></h3>
				<div role="tabpanel" style="height: 125px; display: none;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom">

					<p>Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna. </p>
				</div>
				<h3 tabindex="-1" aria-selected="false" aria-expanded="false" role="tab" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all"><span class="ui-icon ui-icon-triangle-1-e"></span><a tabindex="-1" href="#">Section 3</a></h3>
				<div role="tabpanel" style="height: 125px; display: none;" class="ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom">
					<p>Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui. </p>
					<ul>
						<li>List item one</li>

						<li>List item two</li>
						<li>List item three</li>
					</ul>
				</div>
			</div>

			<!-- Tabs -->
			<h3 class="demoHeaders">Tabs</h3>

			<div class="ui-tabs ui-widget ui-widget-content ui-corner-all" id="tabs">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
					<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-1">First</a></li>
					<li class="ui-state-default ui-corner-top"><a href="#tabs-2">Second</a></li>
					<li class="ui-state-default ui-corner-top"><a href="#tabs-3">Third</a></li>
				</ul>
				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom" id="tabs-1">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</div>

				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="tabs-2">Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.</div>
				<div class="ui-tabs-panel ui-widget-content ui-corner-bottom ui-tabs-hide" id="tabs-3">Nam dui erat, auctor a, dignissim quis, sollicitudin eu, felis. Pellentesque nisi urna, interdum eget, sagittis et, consequat vestibulum, lacus. Mauris porttitor ullamcorper augue.</div>
			</div>

		

	
	
			<!-- Button -->
			<h3 class="demoHeaders">Button</h3>

			<button aria-disabled="false" role="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="button"><span class="ui-button-text">A button element</span></button>
			<form style="margin-top: 1em;">
				<div class="ui-buttonset" id="radioset">
					<input class="ui-helper-hidden-accessible" id="radio1" name="radio" type="radio"><label aria-disabled="false" role="button" class="ui-button ui-widget ui-state-default ui-button-text-only ui-corner-left" aria-pressed="false" for="radio1"><span class="ui-button-text">Choice 1</span></label>
					<input class="ui-helper-hidden-accessible" id="radio2" name="radio" checked="checked" type="radio"><label aria-disabled="false" role="button" aria-pressed="true" class="ui-state-active ui-button ui-widget ui-state-default ui-button-text-only" for="radio2"><span class="ui-button-text">Choice 2</span></label>
					<input class="ui-helper-hidden-accessible" id="radio3" name="radio" type="radio"><label aria-disabled="false" role="button" class="ui-button ui-widget ui-state-default ui-button-text-only ui-corner-right" aria-pressed="false" for="radio3"><span class="ui-button-text">Choice 3</span></label>
				</div>

			</form>
		
			<!-- Autocomplete -->
			<h3 class="demoHeaders">Autocomplete</h3>
			<div>
				<input aria-haspopup="true" aria-autocomplete="list" role="textbox" autocomplete="off" class="ui-autocomplete-input" id="autocomplete" style="z-index: 100; position: relative;" title="type &quot;a&quot;">
			</div>
			
			<!-- Slider -->
			<h3 class="demoHeaders">Slider</h3>

			<div class="ui-slider ui-slider-horizontal ui-widget ui-widget-content ui-corner-all" id="slider"><div style="left: 17%; width: 50%;" class="ui-slider-range ui-widget-header"></div><a style="left: 17%;" class="ui-slider-handle ui-state-default ui-corner-all" href="#"></a><a style="left: 67%;" class="ui-slider-handle ui-state-default ui-corner-all" href="#"></a></div>

			<!-- Datepicker -->
			<h3 class="demoHeaders">Datepicker</h3>
			<div class="hasDatepicker" id="datepicker"><div style="display: block;" class="ui-datepicker-inline ui-datepicker ui-widget ui-widget-content ui-helper-clearfix ui-corner-all"><div class="ui-datepicker-header ui-widget-header ui-helper-clearfix ui-corner-all"><a class="ui-datepicker-prev ui-corner-all" onclick="DP_jQuery_1313049491259.datepicker._adjustDate('#datepicker', -1, 'M');" title="Prev"><span class="ui-icon ui-icon-circle-triangle-w">Prev</span></a><a class="ui-datepicker-next ui-corner-all" onclick="DP_jQuery_1313049491259.datepicker._adjustDate('#datepicker', +1, 'M');" title="Next"><span class="ui-icon ui-icon-circle-triangle-e">Next</span></a><div class="ui-datepicker-title"><span class="ui-datepicker-month">August</span>&nbsp;<span class="ui-datepicker-year">2011</span></div></div><table class="ui-datepicker-calendar"><thead><tr><th class="ui-datepicker-week-end"><span title="Sunday">Su</span></th><th><span title="Monday">Mo</span></th><th><span title="Tuesday">Tu</span></th><th><span title="Wednesday">We</span></th><th><span title="Thursday">Th</span></th><th><span title="Friday">Fr</span></th><th class="ui-datepicker-week-end"><span title="Saturday">Sa</span></th></tr></thead><tbody><tr><td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">1</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">2</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">3</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">4</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">5</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">6</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">7</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">8</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">9</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">10</a></td><td class=" ui-datepicker-days-cell-over  ui-datepicker-current-day ui-datepicker-today" onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default ui-state-highlight ui-state-active" href="#">11</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">12</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">13</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">14</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">15</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">16</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">17</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">18</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">19</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">20</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">21</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">22</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">23</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">24</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">25</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">26</a></td><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">27</a></td></tr><tr><td class=" ui-datepicker-week-end " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">28</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">29</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">30</a></td><td class=" " onclick="DP_jQuery_1313049491259.datepicker._selectDay('#datepicker',7,2011, this);return false;"><a class="ui-state-default" href="#">31</a></td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td><td class=" ui-datepicker-week-end ui-datepicker-other-month ui-datepicker-unselectable ui-state-disabled">&nbsp;</td></tr></tbody></table></div></div>

		
			<!-- Progressbar -->
			<h3 class="demoHeaders">Progressbar</h3>	
			<div aria-valuenow="20" aria-valuemax="100" aria-valuemin="0" role="progressbar" class="ui-progressbar ui-widget ui-widget-content ui-corner-all" id="progressbar">
			
			</div>
			<div class="clear"></div>
			<h3>Sprites</h3>
			<span class="ss_sprite ss_control_end"> &nbsp; </span>
			ss_control_end <br>
			<span class="ss_sprite ss_control_end_blue"> &nbsp; </span>
			ss_control_end_blue <br>
			<span class="ss_sprite ss_control_equalizer"> &nbsp; </span>
			ss_control_equalizer <br>

			<span class="ss_sprite ss_control_equalizer_blue">
			&nbsp; </span> ss_control_equalizer_blue <br>
			<span class="ss_sprite ss_control_fastforward"> &nbsp;
			</span> ss_control_fastforward <br>
			<span class="ss_sprite ss_control_fastforward_blue">
			&nbsp; </span> ss_control_fastforward_blue <br>
			<span class="ss_sprite ss_control_pause"> &nbsp; </span>

			ss_control_pause <br>
			<span class="ss_sprite ss_control_pause_blue"> &nbsp; </span>
			ss_control_pause_blue <br>
			<span class="ss_sprite ss_control_play"> &nbsp; </span>
			ss_control_play <br>
			<span class="ss_sprite ss_control_play_blue"> &nbsp; </span>
			ss_control_play_blue <br>

			<span class="ss_sprite ss_control_repeat"> &nbsp; </span>
			ss_control_repeat <br>

	
		</div>


		<script type="text/javascript">
					$(function(){
						set_active_tab('jquery-ui');
						
						
						
						// Accordion
						$("#accordion").accordion({ header: "h3" });
						// Autocomplete
						$("#autocomplete").autocomplete({
							source: ["c++", "java", "php", "coldfusion", "javascript", "asp", "ruby", "python", "c", "scala", "groovy", "haskell", "perl"]
						});
						// Button
						$("#button").button();
						$("#radioset").buttonset();
						// Tabs
						$('#tabs').tabs();
						// Dialog			
						$('#dialog').dialog({
							autoOpen: false,
							width: 600,
							buttons: {
								"Ok": function() { 
									$(this).dialog("close"); 
								}, 
								"Cancel": function() { 
									$(this).dialog("close"); 
								} 
							}
						});
						// Dialog Link
						$('#dialog_link').click(function(){
							$('#dialog').dialog('open');
							return false;
						});
						// Datepicker
						$('#datepicker').datepicker({
							inline: true
						});
						// Slider
						$('#slider').slider({
							range: true,
							values: [17, 67]
						});
						// Progressbar
						$("#progressbar").progressbar({
							value: 20 
						});
						//hover states on the static widgets
						$('#dialog_link, ul#icons li').hover(
							function() { $(this).addClass('ui-state-hover'); }, 
							function() { $(this).removeClass('ui-state-hover'); }
						);
					});
			    </script>
	
	</body>
</html>
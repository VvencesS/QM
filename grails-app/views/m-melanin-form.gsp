<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		<div class="clear"></div>
		<div id="m-melanin-main-content">
			<div style="width: 500px">
				<h3>Forms</h3>
				<form id="m-melanin-test-form">
					<fieldset >
						<legend>Example form with validation</legend>
						<ol class="form form-clear">
							<li><label for="firstName">First Name:</label>
								<g:textField name="firstName" type="text" class="validate[required]"
									placeholder="Enter your first name."/>
								<span class="ss_sprite ss_help m-melanin-tooltip" title="A nice tooltip: <br/>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.">&nbsp;</span>
							</li>
							<li><label for="address">Email address:</label>
								<g:textField name="address" type="text" 
									class="validate[required,custom[email]] e-xxl"
									placeholder="Enter your email address."/>
								<span class="m-melanin-tooltip" title="A nice tooltip: <br/>Lorem ipsum dolor sit amet.">?</span>
							</li>
							<li><label for="gender">Gender:</label>
								<g:select from="${['---','Male','Female']}" name="gender"/>
							</li>
							<li><label>Marital status:</label>
								<label>Married </label><g:radio name="myGroup" value="1"/> 
								<label>Single</label><g:radio name="myGroup" value="2" checked="true"/> 
							</li>
							<li><label>Terms &amp; Conditions:</label>
								<g:textArea cols="20" rows="5" name="textarea"/>
								
							</li>
							<li><label>&nbsp;</label>
								<g:checkBox name="agree" value="1"/> <label>Agree to T&amp;C? </label>
								
							</li>
							<li class="buttons">
								<button name="submit" class="btn primary">Validate &amp; Save</button>
								<button type="button" class="btn" >Cancel</button>
							</li>
						</ol>
						
					</fieldset>
				</form>
			</div>
		</div>


		<script type="text/javascript">
		$(function(){
			set_active_tab('form');
			$("#m-melanin-test-form").validationEngine();
		});
	    </script>
	
	</body>
</html>
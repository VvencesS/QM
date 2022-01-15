

<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		<div class="clear"></div>
		<div id="m-melanin-main-content">
			<div id="m-melanin-fingerprint-table-section">
					<div style="width: 500px">
					<table class="table table-striped">
	                    <thead>
	                        <tr>
	                         	 <th>#</th>
			                     <th>Controller</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<g:each var="c" status="index" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
							  	 <tr class="controller"><td>${ index + 1 }</td><td><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></td></tr>
							</g:each>
	                    	
	                    </tbody>
	                </table>
	                </div>
				</div>
		</div>


		<script type="text/javascript">
		$(function(){
			set_active_tab('all-controller');
		});
	    </script>
	
	</body>
</html>
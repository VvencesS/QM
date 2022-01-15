<head>
<meta name='layout' content='m-melanin-error-layout' />
<title>Lỗi 500</title>
<style type="text/css">
  		.message {
  			border: 1px solid black;
  			padding: 5px;
  			background-color:#E9E9E9;
  		}
  		.stack {
  			border: 1px solid black;
  			padding: 5px;
  			overflow:auto;
  			height: 300px;
  		}
  		.snippet {
  			padding: 5px;
  			background-color:white;
  			border:1px solid black;
  			margin:3px;
  			font-family:courier;
  		}
  </style>

</head>

<body>

<div id='m-melanin-main-content' >
	<div class="page-content" style="margin-top:50px; margin-left: 0px;">
		<h1>Lỗi 500</h1>
			<h3>Lỗi hệ thống. Xin vui lòng chụp lại màn hình này và gửi IT Service Desk để được hỗ trợ.</h3>
			<p/>
			<h3>Chi tiết lỗi:</h3>
			<div class="message">
				<strong>Error ${request.'javax.servlet.error.status_code'}:</strong> ${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
				<strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
				<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
				<g:if test="${exception}">
			  		<strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br />
			  		<strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br />
			  		<strong>Class:</strong> ${exception.className} <br />
			  		<strong>At Line:</strong> [${exception.lineNumber}] <br />
			  		<strong>Code Snippet:</strong><br />
			  		<div class="snippet">
			  			<g:each var="cs" in="${exception.codeSnippet}">
			  				${cs?.encodeAsHTML()}<br />
			  			</g:each>
			  		</div>
				</g:if>
		  	</div>
			<g:if test="${exception}">
			    <h2>Stack Trace</h2>
			    <div class="stack">
			      <pre><g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each></pre>
			    </div>
			</g:if>
		</div>
		
	</div>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		common.showToastr('error', 'Thông báo', 'Lỗi hệ thống! Xin vui lòng liên hệ với Admin để được trợ giúp.', 'toast-top-right');
		
		clear_tabs();
		add_tab('#','Lỗi 500','error');
		set_active_tab('error');
	});
</script>
</body>

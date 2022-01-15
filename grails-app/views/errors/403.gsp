<head>
<meta name='layout' content='m-melanin-error-layout' />
<title>Lỗi bảo mật</title>
</head>

<body>
<div id='m-melanin-main-content'>
	<div class="page-content" style="margin-top:50px; margin-left: 0px;">
		<h1>Lỗi 403</h1>
		<h3>Lỗi bảo mật. Bạn không được phép truy cập trang này.</h3><br/>
		<g:link controller="melanin" action="switchDashboard">Nhấn vào đây</g:link> để quay về trang chủ hoặc 
		<g:link controller="melanin" action="logout">login</g:link> lại.
	</div>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		common.showToastr('warning', 'Thông báo', 'Lỗi bảo mật. Bạn không được phép truy cập trang này.', 'toast-top-right');
		
		clear_tabs();
		add_tab('#','Lỗi 403','error');
		set_active_tab('error');
	});
</script>
</body>

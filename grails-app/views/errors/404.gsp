<head>
<meta name='layout' content='m-melanin-error-layout' />
<title>Lỗi 404</title>
</head>

<body>
<div id='m-melanin-main-content'>
	<div class="page-content" style="margin-top:50px; margin-left: 0px;">
		<h1>Lỗi 404</h1>
		<h3>Đường link bạn cần tìm không tồn tại. </h3>
		<br/>Xin vui lòng 
		<g:link controller="melanin" action="switchDashboard">nhấn vào đây</g:link> để quay về trang chủ hoặc 
		bạn có thể <a href="javascript:history.back(1);">quay về</a> trang trước.
	</div>
</div>
<script type="text/javascript" charset="utf-8">
	$(document).ready(function(){
		common.showToastr('warning', 'Thông báo', 'Đường link bạn cần tìm không tồn tại.', 'toast-top-right');
		
		clear_tabs();
		add_tab('#','Lỗi 404','error');
		set_active_tab('error');
	});
</script>
</body>

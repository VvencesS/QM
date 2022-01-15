<html>
	<head>
		<meta name="layout" content="m-melanin-admin-layout" />
		<title>Control Panel</title>
	</head>
	<body>
		
		<%--<div id="m-melanin-tab-header">
			<g:render template="/templates/m-melanin-breadcrum" 
				model="${[
						items:[[href:createLink(uri:'/'),title:'home',label:'Home'],
						[href:createLink(controller:'fingerprint',action:'index'),title:'Fingerprint Control Panel',label:'Fingerprint']]
					]}"/>
			
			<div class="clear"></div>
		</div>
		--%>
		
		
		<div class="page-content">
			<div id="m-melanin-main-content">
				<h3>Trang quản trị user</h3>
				<p>Với trang này, bạn có thể quản trị user, role và phân quyền bảo mật vào các tính năng của phần mềm.</p>
				<p>Căn bản, hệ thống bảo mật của phần mềm này gồm 4 khái niệm chính:</p>
				<ol>
					<li><strong>Người dùng (user)</strong>: là đối tượng người dùng của phần mềm, có thể login qua Active Directory của TNG
						hoặc bằng password trong database (Password sử dụng SHA-256 encode).
						</li>
					<li><strong>Đơn vị/phòng ban (Branch)</strong>: là đơn vị/phòng ban mà người dùng trực thuộc.
						</li>
					<li><strong>Vai trò (role)</strong>: là vai trò của người dùng trong phần mềm này. Một người dùng có thể có
						một hoặc nhiều vai trò cùng một lúc. Ví dụ: ROLE_ADMIN, ROLE_GDV, ROLE_KSV...
						</li>
					<li><strong>Phân quyền bảo mật (request map)</strong>: là yếu tố quan trong nhất của bảo mật. Khi phân quyền trong 
						hệ thống, phần mềm sẽ xem xét URL của phần mềm và ROLE. Request map là bảng map giữa URL và ROLE. Ví dụ:<br/>
						<ul>
							<li><strong>/SoTietKiem/create</strong>: ROLE_GDV (1)</li>
							<li><strong>/SoTietKiem/approve</strong>: ROLE_KSV (2)</li>
						</ul>
						Như vậy, với (1) thì chỉ có user có role là ROLE_GDV mới vào được đường link <strong>/SoTietKiem/create</strong> mà không vào 
						được <strong>/SoTietKiem/approve</strong>.
					</li>
						
				</ol>
				<br/>
				<p>Để bắt đầu, xin vui lòng nhấn vào các menu bên trái.</p>
			</div>
		</div>
		

		<script type="text/javascript">
			$(function(){
				set_side_bar(true);
				add_tab('#','Security','security');
				set_active_tab('security');
			});
		
			var sidebarSwitch = false;
			function toggle_sidebar(flag){
				set_side_bar(flag);
			}		    
		</script>

	</body>
</html>
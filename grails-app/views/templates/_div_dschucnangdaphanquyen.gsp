<h4>Danh sách chức năng đã phân quyền</h4>
<div class="table-responsive">
	<table id="tbl_dschucnang_daphanquyen" class="table table-bordered">
		<thead>
			<tr>
				<th style="width: 5%;">STT</th>
				<th style="width: 30%;">Tên chức năng</th>
				<th style="width: 30%;">Tên hành động</th>
				<th>Module</th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${dschucnang_daphanquyen}" status="i" var="rs">
				<tr>
					<td>${i+1}</td>
					<td>${rs?.usecasename}</td>
					<td>${rs?.name}</td>
					<td>
						${rs?.module?.name}
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	$(function() {
	});
	$(document).ready(function() {
		var oTable = $("#tbl_dschucnang_daphanquyen").dataTable({
			"sPaginationType": "full_numbers"
		});
	});
</script>
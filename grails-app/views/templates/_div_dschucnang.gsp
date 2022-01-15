<h4>Danh sách chức năng</h4>
<div class="table-responsive">
	<g:hiddenField name="module_id" id="module_id" value="${module.id}"/>
	<table id="tbl_dschucnang" class="table table-bordered">
		<thead>
			<tr>
				<th style="width: 5%;">STT</th>
				<th style="width: 40%;">Tên chức năng</th>
				<th style="width: 40%;">Tên hành động</th>
				<th>Phân quyền</th>
			</tr>
		</thead>
		<tbody>
			<g:each in="${dschucnang}" status="i" var="rs">
				<tr>
					<td>${i+1}</td>
					<td>${rs?.usecasename}</td>
					<td>${rs?.name}</td>
					<td>
						<input type="checkbox" id="checkboxchucnang_${rs.id}" name="checkboxchucnang" class="checkboxchucnang" module_id="${module.id}" url_group_id="${rs.id}">
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
</div>
<script type="text/javascript">
	$(function() {
		$('.checkboxchucnang').change(function() {
			debugger;
			var list_function_by_module = $('#list_function_by_module').val();
			console.log("list_function_by_module: "+list_function_by_module);
			var list_function_by_module_2 = list_function_by_module.substring(1,list_function_by_module.length-1);
			console.log("list_function_by_module_2: "+list_function_by_module_2);
			if(this.checked) {
				var module_id = $(this).attr("module_id");
				var url_group_id = $(this).attr("url_group_id");

				var arr = list_function_by_module_2.split(";"); // cat chuoi
				console.log("arr :"+arr);
				var arr_count = arr.length; // so luong phan tu cua choi chuc nang ( phai = 7 = so module)
				console.log("arr.length :"+arr_count);

				var gfunction = arr[module_id-1]; // module 1 thi lay phan tu 0 cua mang ; 2 thi lay 1....
				console.log("gfunction :"+gfunction);
				var gfunction2 = gfunction.substring(1,gfunction.length-1);
				console.log("gfunction2 :"+gfunction2);

				if(gfunction2.length>0){
					gfunction2= gfunction2+","+url_group_id;
				}else{
					gfunction2= url_group_id;
				}

				console.log("gfunction2 :"+gfunction2);
				arr[module_id-1] = "["+gfunction2+"]";
				console.log("arr :"+arr);

				var re ="[";
				for(i=0;i<arr_count;i++){
					re+=arr[i]+";";
				}
				re=re.substring(re,re.length-1);
				re+="]"
				console.log("re: "+re);
				$('#list_function_by_module').val(re);
			}else{
				var module_id = $(this).attr("module_id");
				var url_group_id = $(this).attr("url_group_id");

				var arr = list_function_by_module_2.split(";"); // cat chuoi
				console.log("arr :"+arr);
				var arr_count = arr.length; // so luong phan tu cua choi chuc nang ( phai = 7 = so module)

				console.log("arr.length :"+arr_count);
				var gfunction = arr[module_id-1]; // module 1 thi lay phan tu 0 cua mang ; 2 thi lay 1....
				console.log("gfunction :"+gfunction);
				var gfunction2 = gfunction.substring(1,gfunction.length-1);
				console.log("gfunction2 :"+gfunction2);

				var gfunction3 = gfunction2.split(",");
				console.log("gfunction3 :"+gfunction3);
				for(i=0;i<gfunction3.length;i++){
					if(gfunction3[i]==url_group_id){
						gfunction3.splice(i,1);
					}
				}
				console.log("gfunction3 :"+gfunction3);
				arr[module_id-1] = "["+gfunction3+"]";

				var re ="[";
				for(i=0;i<arr_count;i++){
					re+=arr[i]+";";
				}
				re=re.substring(re,re.length-1);
				re+="]"
				console.log("re: "+re);
				$('#list_function_by_module').val(re);
			}
		});
	});
	$(document).ready(function() {
		var oTable = $("#tbl_dschucnang").DataTable({
			"sPaginationType": "full_numbers"
		});
		debugger;
		var list_function_by_module = $('#list_function_by_module').val();
		console.log("list_function_by_module: "+list_function_by_module);
		var list_function_by_module_2 = list_function_by_module.substring(1,list_function_by_module.length-1);
		console.log("list_function_by_module_2: "+list_function_by_module_2);
		var arr = list_function_by_module_2.split(";"); // cat chuoi
		console.log("arr :"+arr);
		var arr_count = arr.length; // so luong phan tu cua choi chuc nang ( phai = 7 = so module)

		var module_id = $('#module_id').val();
		var arr_moduleid = arr[module_id-1];
		console.log("arr_moduleid :"+arr_moduleid);
		var arr_moduleid2 = arr_moduleid.substring(1,arr_moduleid.length-1);
		console.log("arr_moduleid2 :"+arr_moduleid2);
		var arr2 = arr_moduleid2.split(",");
		console.log("arr2 :"+arr2);
		for(i=0;i<arr2.length;i++){
			console.log(arr2[i]);
			if($("#checkboxchucnang_"+arr2[i])){
				$("#checkboxchucnang_"+arr2[i]).prop('checked', true);
			}
		}

		oTable.on('draw', function(){
			for(i=0;i<arr2.length;i++){
				console.log(arr2[i]);
				if ($("#checkboxchucnang_" + arr2[i])) {
					$("#checkboxchucnang_" + arr2[i]).attr('checked', 'checked');
				}
			}
		});

//		$('#tbl_dschucnang').on( 'page.dt', function () {
//			for(i=0;i<arr2.length;i++){
//				console.log(arr2[i]);
//				if($("#checkboxchucnang_"+arr2[i])){
//					alert(arr2[i]);
//					$("#checkboxchucnang_"+arr2[i]).attr('checked','checked');
//					alert('checked');
//				}
//			}
//		} );
	});
</script>
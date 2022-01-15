<html>
	<head>
		<meta name="layout" content="m-melanin-layout" />
	</head>
	<body>
		
		<div id="m-melanin-main-content">
		Fore more details, go to <a href="http://www.jeasyui.com/demo/index.php">http://www.jeasyui.com/demo/index.php</a>			
		<h3>Demo<h3>
		<h4>Datebox</h4>
		<input id="datebox-test" class="easyui-datebox" required="true"></input>
	
		</div>

		<h4>Datagrid</h4>
			<a href="#" onclick="getSelected()">GetSelected</a>
			<a href="#" onclick="getSelections()">GetSelections</a>
			<a href="#" onclick="selectRow()">SelectRow</a>
			<a href="#" onclick="selectRecord()">SelectRecord</a>
			<a href="#" onclick="unselectRow()">UnselectRow</a>
			<a href="#" onclick="clearSelections()">ClearSelections</a>
			<a href="#" onclick="resize()">Resize</a>
			<a href="#" onclick="mergeCells()">MergeCells</a>
	
		<table id="data-grid-test" width="800" style="width: 800px;"></table>
			
		

		<script type="text/javascript">
			$(function(){
				set_side_bar(false);
				set_active_tab('easy-ui');
			
			
				$('#datebox-test').datebox('enable');
		
			});
			// data grid
		$(function(){
			$('#data-grid-test').datagrid({
				title:'My DataGrid',
				iconCls:'icon-save',
				width:700,
				height:350,
				nowrap: false,
				striped: true,
				collapsible:true,
				url:'${createLink(controller:'melanin',action:'datagrid')}/1',
				sortName: 'code',
				sortOrder: 'desc',
				remoteSort: false,
				idField:'code',
				frozenColumns:[[
	                {field:'ck',checkbox:true},
	                {title:'code',field:'code',width:80,sortable:true}
				]],
				columns:[[
			        {title:'Base Information',colspan:3},
					{field:'opt',title:'Operation',width:100,align:'center', rowspan:2,
						formatter:function(value,rec){
							return '<span style="color:red">Edit Delete</span>';
						}
					}
				],[
					{field:'name',title:'Name',width:120},
					{field:'addr',title:'Address',width:220,rowspan:2,sortable:true,
						sorter:function(a,b){
							return (a>b?1:-1);
						}
					},
					{field:'col4',title:'Col41',width:150,rowspan:2}
				]],
				pagination:true,
				rownumbers:true,
				toolbar:[{
					id:'btnadd',
					text:'Add',
					iconCls:'icon-add',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						alert('add')
					}
				},{
					id:'btncut',
					text:'Cut',
					iconCls:'icon-cut',
					handler:function(){
						$('#btnsave').linkbutton('enable');
						alert('cut')
					}
				},'-',{
					id:'btnsave',
					text:'Save',
					disabled:true,
					iconCls:'icon-save',
					handler:function(){
						$('#btnsave').linkbutton('disable');
						alert('save')
					}
				}]
			});
			var p = $('#data-grid-test').datagrid('getPager');
			$(p).pagination({
				onBeforeRefresh:function(){
					alert('before refresh');
				}
			});
		});
		function resize(){
			$('#data-grid-test').datagrid('resize', {
				width:700,
				height:400
			});
		}
		function getSelected(){
			var selected = $('#data-grid-test').datagrid('getSelected');
			if (selected){
				alert(selected.code+":"+selected.name+":"+selected.addr+":"+selected.col4);
			}
		}
		function getSelections(){
			var ids = [];
			var rows = $('#data-grid-test').datagrid('getSelections');
			for(var i=0;i<rows.length;i++){
				ids.push(rows[i].code);
			}
			alert(ids.join(':'));
		}
		function clearSelections(){
			$('#data-grid-test').datagrid('clearSelections');
		}
		function selectRow(){
			$('#data-grid-test').datagrid('selectRow',2);
		}
		function selectRecord(){
			$('#data-grid-test').datagrid('selectRecord','002');
		}
		function unselectRow(){
			$('#data-grid-test').datagrid('unselectRow',2);
		}
		function mergeCells(){
			$('#data-grid-test').datagrid('mergeCells',{
				index:2,
				field:'addr',
				rowspan:2,
				colspan:2
			});
		}
		</script>
	
	</body>
</html>
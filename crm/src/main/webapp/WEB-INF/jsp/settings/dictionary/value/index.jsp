<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript">

		list();
		//select All 查询所有
		function list() {
			$.ajax({
				url: "/value",
				type: "get",
				success: function (data) {
					var arr = [];
					$(data).each(function (index) {
						arr.push(`<tr class="active">
						<td><input  name="id" type="checkbox" value="` + this.id + `" /></td>
						<td> ` + (index + 1) + `</td>
						<td> ` + this.value + `</td>
						<td> ` + this.text + `</td>
						<td> ` + this.orderNo + `</td>
						<td> ` + this.typeCode + `</td>
						</tr>`
						)
					});
					$("#fromValue").html(arr.join(""));
				}
			});
		}
	//回显，修改
	jQuery(function ($) {
		$("#deit").click(function () {
			var id = $(":checkbox[name=id]:checked");
			if (id.size()!=1){
				alert("必须且只能选择一项！");
				return;
			}
			location="/valueOne.do?id="+id.val();
		});


		//全选 或者全不选
		$("#selectAll").click(function () {
			$(":checkbox[name=id]").prop("checked",this.checked)
		});

		//当有一个不为选中时候，及不全选
		$("#dataTable").on("click", ":checkbox[name=id]", function () {
			var checked = $(":checkbox[name=id]:not(:checked)").size() == 0;
			$("#selectAll").prop("checked", checked);
		});





		// 删除
		$("#delete").click(function () {
			var $checkbox = $(":checkbox[name=id]:checked");
			if ($checkbox.size()<=0){
				alert("请选中再删除");
				return;
			}
			if (!confirm("确定删除吗？")) return ;
			var codes = [];
			$checkbox.each(function () {
				codes.push(this.value);
			});
			codes = codes.join(",");
			$.ajax({
				url:"/value/"+codes,
				type:"delete",
				traditional:true,
				success:function (data) {
					alert(data.msg);
					list();
				}
			});

		});






	});

</script>

</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典值列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='save.html'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button id="deit" type="button" class="btn btn-default"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button id="delete" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table id="dataTable" class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="selectAll" type="checkbox" /></td>
					<td>序号</td>
					<td>字典值</td>
					<td>文本</td>
					<td>排序号</td>
					<td>字典类型编码</td>
				</tr>
			</thead>
			<tbody id="fromValue">

			</tbody>
		</table>
	</div>
	
</body>
</html>
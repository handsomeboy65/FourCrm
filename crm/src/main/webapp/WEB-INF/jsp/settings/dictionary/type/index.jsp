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
function list (){
	$.ajax({
		url: "/type",
		type: "get",
		success: function (data) {
			var arr=[];
			$(data).each(function (index) {
				arr.push(`<tr class="active">
						<td><input  name="code" type="checkbox" value="` + this.code + `" /></td>
						<td> ` + (index + 1) + `</td>
						<td> ` + this.code + `</td>
						<td> ` + this.name + `</td>
						<td> ` + this.description + `</td>
						</tr>`
				)
			});
			$("#fromProduct").html( arr.join("") );
		}
	});
}
		//数据回显
		jQuery(function ($) {

			//全选 或者全不选
			$("#selectAll").click(function () {
				$(":checkbox[name=code]").prop("checked",this.checked)
			});

			//当有一个不为选中时候，及不全选
			$("#dataTable").on("click", ":checkbox[name=code]", function () {
				var checked = $(":checkbox[name=code]:not(:checked)").size() == 0;
				$("#selectAll").prop("checked", checked);
			});


			$("#editBtn").click(function () {
				var code = $(":checkbox[name=code]:checked");
				//onclick="window.location.href='edit.html'"
				if (code.size()!=1){
					alert("必须且只能选择一项！");
				}else {
					alert(code.val());
						location="/typeOne.do?code="+code.val();
				}
			});

			//	删除
			$("#deleteBtn").click(function () {
				var checodes = $(":checkbox[name=code]:checked");
				if (checodes.size()==0) {
					alert("至少选择一项！");
					return
				}
					var codes = [];
					checodes.each(function () {
						codes.push(this.value);
					});
					codes = codes.join(",");
					$.ajax({
						url:"/getTypeCode.do?code="+codes,
						success:function (data) {
							//
							if (data[0]!=null){
								alert("选择的类型中[" + data.join("、") +"]正在使用中，不能删除！")
							}else {
								$.ajax({
									url: "/type/"+codes,
									type:"delete",
									success:function (data) {
										alert(data.msg);
										list();
									}
							})
							}
						}
					})
			})
		})



	</script>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典类型列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='save.html'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button id="editBtn" type="button" class="btn btn-default" ><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button id="deleteBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table id="dataTable" class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="selectAll" type="checkbox" /></td>
					<td>序号</td>
					<td>编码</td>
					<td>名称</td>
					<td>描述</td>
				</tr>
			</thead>
			<tbody id="fromProduct">

			</tbody>
		</table>
	</div>
	
</body>
</html>
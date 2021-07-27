<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">


	jQuery(function ($) {
        //全选 或者全不选
        $("#selectAll").click(function () {
            $(":checkbox[name=id]").prop("checked",this.checked)
        });

        //当有一个不为选中时候，及不全选
        $("#dataTable").on("click", ":checkbox[name=id]", function () {
            var checked = $(":checkbox[name=id]:not(:checked)").size() == 0;
            $("#selectAll").prop("checked", checked);
        });


		//显示数据
		list();
		function list() {
			$.ajax({
				url: "/dept",
				type: "get",
				success: function (data) {
					var arr = [];
					$(data).each(function (index) {
						arr.push(`<tr class="active">
						<td><input  name="id" type="checkbox" value="` + this.id + `" /></td>
						<td> ` + this.no + `</td>
						<td> ` + this.name + `</td>
						<td> ` + this.manager + `</td>
						<td> ` + this.phone + `</td>
						<td> ` + this.description + `</td>
						</tr>`
						)
					});
					$("#fromDept").html(arr.join(""));
				}
			});
		}
		//添加
		$("#save").click(function () {
			$.ajax({
				url:"/dept",
				type:"post",
				data:{
					no:$("input[name=no]").val(),
					name:$("input[name=name]").val(),
					manager:$("input[name=manager]").val(),
					phone:$("input[name=phone]").val(),
					description:$("#description").val()
				},
				success:function (data) {
					alert(data.msg);
				list();
				}
			});
		});
		//数据回显
		$("#editDept").click(function () {
			// data-target="#editDeptModal"
			var $checkbox = $(":checkbox[name=id]:checked");
			if ($checkbox.size()!=1){
				alert("必须且只能选择一项！");
				$("#editDept").attr("data-target","");
				return;
			}else {
				$("#editDept").attr("data-target","#editDeptModal")
			}
			$.ajax({
				url:"/dept/"+$checkbox.val(),
				success:function (data) {
					$("#updateId").val(data.id),
					$("#updateNo").val(data.no),
					$("#updateName").val(data.name),
					$("#updateManager").val(data.manager),
					$("#updatePhone").val(data.phone),
					$("#updateDescription").val(data.description)
				}
			});
		});

		//修改
		$("#updateGO").click(function () {
			$.ajax({
				url:"/dept",
				type:"put",
				data:{
					id:$("input[name=updateId]").val(),
					no:$("input[name=updateNo]").val(),
					name:$("input[name=updateName]").val(),
					manager:$("input[name=updateManager]").val(),
					phone:$("input[name=updatePhone]").val(),
					description:$("#updateDescription").val()
				},
				success:function (data) {
					alert(data.msg);
					list();
				}
			})
		});
		// 删除
		$("#deleteDept").click(function () {
			var $checkbox = $(":checkbox[name=id]:checked");
			if ($checkbox.size()<=0){
				alert("请选中再删除");
				return;
			}
			if (!confirm("确定删除吗？")) return ;
			var ids = [];
			$checkbox.each(function () {
				ids.push(this.value);
			});
			ids = ids.join(",");
			$.ajax({
				url:"/dept/"+ids,
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

	<!-- 我的资料 -->
	<div class="modal fade" id="myInformation" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">我的资料</h4>
				</div>
				<div class="modal-body">
					<div style="position: relative; left: 40px;">
						姓名：<b>张三</b><br><br>
						登录帐号：<b>zhangsan</b><br><br>
						组织机构：<b>1005，市场部，二级部门</b><br><br>
						邮箱：<b>zhangsan@bjpowernode.com</b><br><br>
						失效时间：<b>2017-02-14 10:10:10</b><br><br>
						允许访问IP：<b>127.0.0.1,192.168.100.2</b>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='../../login.html';">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> zhangsan <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="../../workbench/index.html"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
						<li><a href="../index.html"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 创建部门的模态窗口 -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="new"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="no" type="text" class="form-control" id="no" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="name" type="text" class="form-control" id="name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="manager" type="text" class="form-control" id="manager" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="phone" type="text" class="form-control" id="phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea name="description" class="form-control" rows="3" id="description"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button  type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="save" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						<%--ID--%>
						<input type="hidden" id="updateId" name="updateId" value="">
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="updateNo" id="updateNo" type="text" class="form-control"  style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="updateName" type="text" class="form-control" id="updateName" style="width: 200%;" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-manager" class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="updateManager" type="text" class="form-control" id="updateManager" style="width: 200%;" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="updatePhone" type="text" class="form-control" id="updatePhone" style="width: 200%;" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea id="updateDescription" class="form-control" rows="3" ></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateGO" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>部门列表</h3>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button id="editDept" type="button" class="btn btn-default" data-toggle="modal" data-target="#editDeptModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			  <button id="deleteDept" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table id="dataTable"  class="table table-hover">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input id="selectAll" type="checkbox" /></td>
						<td>编号</td>
						<td>名称</td>
						<td>负责人</td>
						<td>电话</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="fromDept">

				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px; left:30px;">
			<div>
				<button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
			</div>
			<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
				<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
				<div class="btn-group">
					<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						10
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">20</a></li>
						<li><a href="#">30</a></li>
					</ul>
				</div>
				<button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
			</div>
			<div style="position: relative;top: -88px; left: 285px;">
				<nav>
					<ul class="pagination">
						<li class="disabled"><a href="#">首页</a></li>
						<li class="disabled"><a href="#">上一页</a></li>
						<li><a href="#">下一页</a></li>
						<li class="disabled"><a href="#">末页</a></li>
					</ul>
				</nav>
			</div>
		</div>
			
	</div>
	
</body>
</html>
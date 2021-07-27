<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<%@include file="/WEB-INF/jsp/inc/head.jsp" %>
<script type="text/javascript">

	jQuery(function($){

	list();
	function list() {
		$("#getScreen").ajaxForm(function (data) {
			var html = "";
			$(data).each(function () {
				html += `<tr class="active">
							<td><input name="id" type="checkbox" value="` + this.id + `"  /></td>
<td><a href="/workbench/activity/detail.html?id=`+this.id+`" style="text-decoration: none; cursor: pointer;">`+this.name+`</a></td>
                            <td>`+this.owner+`</td>
							<td>`+this.startDate+`</td>
							<td>`+this.endDate+`</td>
						</tr>`;
			});
			$("#actFrom").html(html);
		}).submit();// 提交表单
	}

		//删除
		$("#delete").click(function () {
			var $checkbox = $(":checkbox[name=id]:checked");
			if ($checkbox.size()==0){
				alert("请选择再删除");
				return;
			}
			if (!confirm("确定删除吗？")) return ;
			var ids = [];
			$checkbox.each(function () {
				ids.push(this.value);
			});
			ids = ids.join(",");
			$.ajax({
				url:"/act/"+ids,
				type:"delete",
				// traditional:true,
				success:function (data) {
					alert(data.msg);
					list();
				}
			})
		});

		//添加
		$("#save").click(function () {
			$.ajax({
				url: "/act",
				type: "post",
				data:{
					owner:$("#create-Owner option:selected").val(),
					name:$("input[name=create-actName]").val(),
					startDate:$("input[name=startTime]").val(),
					endDate:$("input[name=create-endTime]").val(),
					cost:$("input[name=create-cost]").val(),
					description:$("#description").val()
				},
				success:function (data) {
					alert(data.msg);
					list();
				}
			})
		});

		//修改回显
		$("#update").click(function () {
			var $checkbox = $(":checkbox[name=id]:checked");
			if ($checkbox.size()!=1){
				alert("只能选择一个，进行修改");
				$("#update").attr("data-target","");
				return;
			}else {
				$("#update").attr("data-target","#editActivityModal")
			}
			$.ajax({
				url:"/act/"+$checkbox.val(),
				type:"get",
				success:function (data) {
							$("#edit-id").val(data.id),
							$("#edit-actOwner option[value='"+data.owner+"']").attr("selected","selected");
							$("#edit-actName").val(data.name),
							$("#edit-startTime").val(data.startDate),
							$("#edit-endTime").val(data.endDate),
							$("#edit-cost").val(data.cost),
							$("#edit-describe").val(data.description)
				}
			})
		});
		//	修改数据
		$("#updateData").click(function () {
			$.ajax({
				url: "/act",
				type: "put",
				data: {
					id:$("#edit-id").val(),
					owner:$("#edit-actOwner option:selected").val(),
					// owner:$("#edit-actOwner").find("option:selected").val(),
					name:$("input[name=edit-actName]").val(),
					startDate:$("input[name=edit-startTime]").val(),
					endDate:$("input[name=edit-endTime]").val(),
					cost:$("input[name=edit-cost]").val(),
					description:$("#edit-describe").val()
				},
				success:function (data) {
					alert(data.msg);
					list();
				}
			});
		});

		$("#exportBtn").click(function () {
			// 本质是文件下载，文件上传支持ajax，但是下载只支持传统请求方式
			location = "/act/export.do?name="+$("#getScreen :input[name=name]").val();
		});

		$("#importBtn").click(function () {
			var formData = new FormData();
			var files = $("#upFile").prop("files");
			alert(files);
			if (files.length == 0) {
				alert("请选择Excel文件！");
				return ;
			}
			formData.append("file",files[0])
			$.ajax({
				url:"/act/import.do",
				type:"post",
				data: formData,
				contentType: false, // 禁止jQuery对数据进行任何修改
				processData: false, // 禁止jQuery对数据进行任何修改
				success:function (data) {
					alert(data.msg)
					$("#getScreen").submit();
				}

			})
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
	});


</script>
</head>
<body>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select name="owner" owner class="form-control" id="create-Owner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="create-actName" type="text" class="form-control" id="create-actName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="startTime" type="text" class="form-control" id="startTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="create-endTime" type="text" class="form-control" id="create-endTime">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="create-cost" type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="save" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
						<%--id--%>
						<input name="id" type="hidden" id="edit-id" value="">

						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select name="owner" owner  class="form-control"  id="edit-actOwner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input name="edit-actName" type="text" class="form-control" id="edit-actName" value="">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="edit-startTime" type="text" class="form-control" id="edit-startTime" value="">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input date name="edit-endTime" type="text" class="form-control" id="edit-endTime" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input name="edit-cost" type="text" class="form-control" id="edit-cost" value="">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"> </textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="updateData" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 导入市场活动的模态窗口 -->
	<div class="modal fade" id="importActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
				</div>
				<div class="modal-body" style="height: 350px;">
					<div style="position: relative;top: 20px; left: 50px;">
						请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
					</div>
					<div style="position: relative;top: 40px; left: 50px;">
						<input id="upFile" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" type="file">
					</div>
					<div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
						<h3>重要提示</h3>
						<ul>
							<li>给定文件的第一行将视为字段名。</li>
							<li>请确认您的文件大小不超过5MB。</li>
							<li>从XLS/XLSX文件中导入全部重复记录之前都会被忽略。</li>
							<li>复选框值应该是1或者0。</li>
							<li>日期值必须为MM/dd/yyyy格式。任何其它格式的日期都将被忽略。</li>
							<li>日期时间必须符合MM/dd/yyyy hh:mm:ss的格式，其它格式的日期时间将被忽略。</li>
							<li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
							<li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button id="importBtn" type="button" class="btn btn-primary" data-dismiss="modal">导入</button>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form id="getScreen" action="/act" method="get"  class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input name="name" class="form-control" type="text" id="name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input name="owner" class="form-control" type="text" id="owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input name="startDate" date class="form-control" type="text" id="startDate" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input name="endDate" date class="form-control" type="text" id="endDate">
				    </div>
				  </div>
				  
				  <button type="submit" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button id="createAct" type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button id="update" type="button" class="btn btn-default" data-toggle="modal" ><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button id="delete" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal"><span class="glyphicon glyphicon-import"></span> 导入</button>
				  <button id="exportBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 导出</button>
				</div>
			</div>
			<div style="position: relative;top: 10px;">
				<table id="dataTable" class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input id="selectAll"  type="checkbox" /></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="actFrom">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
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
							<li class="active"><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">4</a></li>
							<li><a href="#">5</a></li>
							<li><a href="#">下一页</a></li>
							<li class="disabled"><a href="#">末页</a></li>
						</ul>
					</nav>
				</div>
			</div>
			
		</div>
		
	</div>
</body>
</html>
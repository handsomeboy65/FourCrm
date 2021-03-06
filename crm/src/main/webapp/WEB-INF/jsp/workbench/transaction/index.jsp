<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<%@include file="/WEB-INF/jsp/inc/head.jsp" %>
<script type="text/javascript">

	$(function(){
		list();
		function list(currentPage, rowsPerPage) {
			$.ajax({
				url:"/tran/getFilterAll.json",
				data:{
					currentPage: currentPage,
					rowsPerPage: rowsPerPage,
					owner:$("input[name=owner]").val(),
					name:$("input[name=name]").val(),
					CustomerName:$("input[name=CustomerName]").val(),
					stage:$("#stage option:selected").val(),
					type:$("#type option:selected").val(),
					source:$("#source option:selected").val(),
					ContactsName:$("input[name=ContactsName]").val(),
				},
				success:function (page) {
					$("#tranForm").html("");
					$(page.data).each(function () {
						$("#tranForm").append(
								`<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.html';">`+this.name+`</a></td>
							<td>`+this.customer.name+`</td>
							<td>`+this.stage+`</td>
							<td>`+this.type+`</td>
							<td>`+this.owner+`</td>
							<td>`+this.source+`</td>
							<td>`+this.contacts.fullName+`</td>
						</tr>`
						)
					});
					// 初始化分页控件
					$("#page").bs_pagination({
						currentPage: page.currentPage,        	// 页码
						rowsPerPage: page.rowsPerPage,      	// 每页显示的记录条数
						maxRowsPerPage: page.maxRowsPerPage,    // 每页最多显示的记录条数
						totalRows: page.totalRows,      		// 总记录数
						totalPages: page.totalPages,     		// 总页数
						visiblePageLinks: page.visiblePageLinks,// 显示几个卡片
						// 翻页时触发的函数
						onChangePage: function (event, data) {
							list(data.currentPage, data.rowsPerPage);
						}
					});
					// $("#clueForm").html(html);
				}
			})
		}
//查询
		$("#selectGo").click(function () {
			list()
		});


		
	});
	
</script>
</head>
<body>

	<!-- 导入交易的模态窗口 -->
	<div class="modal fade" id="importClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">导入交易</h4>
				</div>
				<div class="modal-body" style="height: 350px;">
					<div style="position: relative;top: 20px; left: 50px;">
						请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
					</div>
					<div style="position: relative;top: 40px; left: 50px;">
						<input type="file">
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
					<button type="button" class="btn btn-primary" data-dismiss="modal">导入</button>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input id="owner" name="owner" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input id="name" name="name" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input name="CustomerName" id="CustomerName" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select id="stage" class="form-control">
						  <option></option>
						  <c:forEach items="${valueList.stage}" var="v">
							  <option value="${v.value}">${v.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select id="type" class="form-control">
						  <option></option>
						  <c:forEach items="${valueList.transactionType}" var="v">
							  <option value="${v.value}">${v.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="source">
						  <option></option>
						  <c:forEach items="${valueList.source}" var="v">
							  <option value="${v.value}">${v.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input name="ContactsName" id="ContactsName" class="form-control" type="text">
				    </div>
				  </div>
				  
				  <button id="selectGo" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='save.html';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importClueModal"><span class="glyphicon glyphicon-import"></span> 导入</button>
				  <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 导出</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="tranForm">

					</tbody>
				</table>
			</div>
			
			<div id="page" style="height: 50px; position: relative;top: 20px;">

			</div>
			
		</div>
		
	</div>
</body>
</html>
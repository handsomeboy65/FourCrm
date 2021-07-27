<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	jQuery(function ($) {
		$("#deitGo").click(function () {
			$.ajax({
				url:"/value",
				type:"put",
				data:{
					id:$("input[name=id]").val(),
					value:$("input[name=value]").val(),
					text:$("input[name=text]").val(),
					orderNo:$("input[name=orderNo]").val(),
					typeCode:$("input[name=typeCode]").val()
				},
				success:function (data) {
					alert(data.msg);
					location="settings/dictionary/value/index.html";
				}
			})
		});

	})
</script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>修改字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="deitGo" type="button" class="btn btn-primary">更新</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form">

		<input name="id" type="hidden" value="${value.id}" readonly>

		<div class="form-group">
			<label for="edit-dicTypeCode" class="col-sm-2 control-label">字典类型编码</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="typeCode" type="text" class="form-control" id="edit-dicTypeCode" style="width: 200%;" value="${value.typeCode}" readonly>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="value" type="text" class="form-control" id="edit-dicValue" style="width: 200%;" value="${value.value}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="text" type="text" class="form-control" id="edit-text" style="width: 200%;" value="${value.text}">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="orderNo" type="text" class="form-control" id="edit-orderNo" style="width: 200%;" value="${value.orderNo}">
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>
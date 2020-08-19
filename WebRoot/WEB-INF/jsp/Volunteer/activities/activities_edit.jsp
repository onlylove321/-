<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	//保存
	function save(){
			if($("#TEAMNAME").val()==""){
			$("#TEAMNAME").tips({
				side:3,
	            msg:'请输入志愿者队伍',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TEAMNAME").focus();
			return false;
		}
		if($("#ACTIVITIESNAME").val()==""){
			$("#ACTIVITIESNAME").tips({
				side:3,
	            msg:'请输入活动名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ACTIVITIESNAME").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="activities/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="ACTIVITIES_ID" id="ACTIVITIES_ID" value="${pd.ACTIVITIES_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">志愿者队伍:</td>
				<td>
				<select class="chzn-select" name="TEAMNAME" id="TEAMNAME" data-placeholder="请选择志愿者队伍" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${teamList}" var="obj1">
				<option value="${obj1.TEAMNAME }" <c:if test="${obj1.TEAMNAME == pd.TEAMNAME }">selected</c:if>>${obj1.TEAMNAME }</option>
				</c:forEach>
				</select>
				</td>
				</tr>
			    <tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">活动名称:</td>
				<td>
				<select class="chzn-select" name="ACTIVITIESNAME" id="ACTIVITIESNAME" data-placeholder="请选择活动名称" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${activitiesList}" var="obj">
				<option value="${obj.ACTIVITIESNAME }" <c:if test="${obj.ACTIVITIESNAME == pd.ACTIVITIESNAME }">selected</c:if>>${obj.ACTIVITIESNAME }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>
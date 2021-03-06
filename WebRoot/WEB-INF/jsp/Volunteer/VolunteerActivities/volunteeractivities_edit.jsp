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
	    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
		

	</head>
<body>
	<form action="volunteeractivities/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="VOLUNTEERACTIVITIES_ID" id="VOLUNTEERACTIVITIES_ID" value="${pd.VOLUNTEERACTIVITIES_ID}"/>
		<input type="hidden" name="ACTIVITIESCONTENT" id="ACTIVITIESCONTENT"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">活动名称:</td>
				<td><input type="text" name="ACTIVITIESNAME" id="ACTIVITIESNAME" value="${pd.ACTIVITIESNAME}" maxlength="32" placeholder="这里输入活动名称" title="活动名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">活动时间:</td>
				<td><input class="date-picker" name="ACTIVITIESTIME" id="ACTIVITIESTIME" value="${pd.ACTIVITIESTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="活动时间" title="活动时间"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">活动策划人:</td>
				<td><input type="text" name="ACTIVITYPLANNER" id="ACTIVITYPLANNER" value="${pd.ACTIVITYPLANNER}" maxlength="32" placeholder="这里输入活动策划人" title="活动策划人"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">活动内容:</td>
				<td><textarea name="ACTIVITIESCONTENT1" id="ACTIVITIESCONTENT1"  placeholder="这里输入活动内容" title="活动内容">
				${pd.ACTIVITIESCONTENT}
                </textarea></td>
			</tr>
				<input type="hidden" name="CURRENTLYUSERS" id="CURRENTLYUSERS" value="${sessionScope.loginUser}" maxlength="32"/>
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
		
		<script type="text/javascript">
		var editor = CKEDITOR.replace( 'ACTIVITIESCONTENT1' );
	
	//保存
	function save(){
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
		if($("#ACTIVITIESTIME").val()==""){
			$("#ACTIVITIESTIME").tips({
				side:3,
	            msg:'请输入活动时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ACTIVITIESTIME").focus();
			return false;
		}
		if($("#ACTIVITYPLANNER").val()==""){
			$("#ACTIVITYPLANNER").tips({
				side:3,
	            msg:'请输入活动策划人',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ACTIVITYPLANNER").focus();
			return false;
		}
		var thecontent=CKEDITOR.instances.ACTIVITIESCONTENT1.getData(); 
        document.getElementById("ACTIVITIESCONTENT").value=thecontent;
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>
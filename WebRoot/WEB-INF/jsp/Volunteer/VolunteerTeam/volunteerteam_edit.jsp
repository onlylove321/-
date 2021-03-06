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
	<form action="volunteerteam/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="VOLUNTEERTEAM_ID" id="VOLUNTEERTEAM_ID" value="${pd.VOLUNTEERTEAM_ID}"/>
		<input type="hidden" name="MEMBERCOMPOSITION" id="MEMBERCOMPOSITION"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">名称:</td>
				<td><input type="text" name="TEAMNAME" id="TEAMNAME" value="${pd.TEAMNAME}" maxlength="32" placeholder="这里输入名称" title="名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">负责人:</td>
				<td><input type="text" name="TEAMCHARGER" id="TEAMCHARGER" value="${pd.TEAMCHARGER}" maxlength="32" placeholder="这里输入负责人" title="负责人"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">组建时间:</td>
				<td><input class="date-picker" name="FOUNDINGTIME" id="FOUNDINGTIME" value="${pd.FOUNDINGTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="组建时间" title="组建时间"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">人员数量:</td>
				<td><input type="number" name="HEADCOUNT" id="HEADCOUNT" value="${pd.HEADCOUNT}" maxlength="32" placeholder="这里输入人员数量" title="人员数量"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">成员构成:</td>
				<td><textarea name="MEMBERCOMPOSITION1" id="MEMBERCOMPOSITION1"  placeholder="这里输入成员构成信息" title="成员构成信息">
				${pd.MEMBERCOMPOSITION}
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
		var editor = CKEDITOR.replace( 'MEMBERCOMPOSITION1' );
	
	//保存
	function save(){
			if($("#TEAMNAME").val()==""){
			$("#TEAMNAME").tips({
				side:3,
	            msg:'请输入名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TEAMNAME").focus();
			return false;
		}
		if($("#TEAMCHARGER").val()==""){
			$("#TEAMCHARGER").tips({
				side:3,
	            msg:'请输入负责人',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TEAMCHARGER").focus();
			return false;
		}
		if($("#FOUNDINGTIME").val()==""){
			$("#FOUNDINGTIME").tips({
				side:3,
	            msg:'请输入组建时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FOUNDINGTIME").focus();
			return false;
		}
		if($("#HEADCOUNT").val()==""){
			$("#HEADCOUNT").tips({
				side:3,
	            msg:'请输入人员数量',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HEADCOUNT").focus();
			return false;
		}
		 var thecontent=CKEDITOR.instances.MEMBERCOMPOSITION1.getData(); 
         document.getElementById("MEMBERCOMPOSITION").value=thecontent;
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>
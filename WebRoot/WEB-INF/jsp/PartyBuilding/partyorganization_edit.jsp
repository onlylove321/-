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
	<form action="partyorganization/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="PARTYORGANIZATION_ID" id="PARTYORGANIZATION_ID" value="${pd.PARTYORGANIZATION_ID}"/>
		<input type="hidden" name="BRIEFINTRODUCTION" id="BRIEFINTRODUCTION"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: left;padding-top: 4px;">党组织名称:</td>
				<td><input type="text" name="ORGANIZATIONNAME" id="ORGANIZATIONNAME" value="${pd.ORGANIZATIONNAME}" maxlength="32" placeholder="这里输入党组织名称" title="党组织名称"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: left;padding-top: 13px;">党组织机构:</td>
				<td><input type="text" name="ORGANIZATION" id="ORGANIZATION" value="${pd.ORGANIZATION}" maxlength="32" placeholder="这里输入党组织机构" title="党组织机构"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: left;padding-top: 13px;">成立时间:</td>
				<td><input class="date-picker" name="FOUNDINGTIME" id="FOUNDINGTIME" value="${pd.FOUNDINGTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="成立时间" title="成立时间"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: left;padding-top: 13px;">换届时间:</td>
				<td><input class="date-picker" name="CHANGETIME" id="CHANGETIME" value="${pd.CHANGETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="换届时间" title="换届时间"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: left;padding-top: 13px;">党组织简介:</td>
				<td><textarea name="BRIEFINTRODUCTION1" id="BRIEFINTRODUCTION1"  placeholder="这里输入党组织简介" title="党组织简介">
				${pd.BRIEFINTRODUCTION}
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
var editor = CKEDITOR.replace( 'BRIEFINTRODUCTION1' );
	//保存
	function save(){
			if($("#ORGANIZATIONNAME").val()==""){
			$("#ORGANIZATIONNAME").tips({
				side:3,
	            msg:'请输入党组织名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ORGANIZATIONNAME").focus();
			return false;
		}
		if($("#ORGANIZATION").val()==""){
			$("#ORGANIZATION").tips({
				side:3,
	            msg:'请输入党组织机构',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ORGANIZATION").focus();
			return false;
		}
		if($("#FOUNDINGTIME").val()==""){
			$("#FOUNDINGTIME").tips({
				side:3,
	            msg:'请输入成立时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FOUNDINGTIME").focus();
			return false;
		}
		if($("#CHANGETIME").val()==""){
			$("#CHANGETIME").tips({
				side:3,
	            msg:'请输入换届时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CHANGETIME").focus();
			return false;
		}
		 var thecontent=CKEDITOR.instances.BRIEFINTRODUCTION1.getData(); 
         document.getElementById("BRIEFINTRODUCTION").value=thecontent;
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>
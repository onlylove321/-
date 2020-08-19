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
	<form action="partyaffairs/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="PARTYAFFAIRS_ID" id="PARTYAFFAIRS_ID" value="${pd.PARTYAFFAIRS_ID}"/>
		<input type="hidden" name="AFFAIRSINFORMATION" id="AFFAIRSINFORMATION"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">党务名称:</td>
				<td><input type="text" name="AFFAIRSNAME" id="AFFAIRSNAME" value="${pd.AFFAIRSNAME}" maxlength="32" placeholder="这里输入党务名称" title="党务名称"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">发布时间:</td>
				<td><input class="date-picker" name="AFFAIRSTIME" id="AFFAIRSTIME" value="${pd.AFFAIRSTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="发布时间" title="发布时间"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">发布人:</td>
				<td><input type="text" name="ISSUSER" id="ISSUSER" value="${pd.ISSUSER}" maxlength="32" placeholder="这里输入发布人" title="发布人"/></td>
			</tr>
			<tr>
				<td style="width:30px;text-align: right;padding-top: 13px;">党务公开信息:</td>
				<td><textarea name="AFFAIRSINFORMATION1" id="AFFAIRSINFORMATION1"  placeholder="这里输入党务公开信息" title="党务公开信息">
				${pd.AFFAIRSINFORMATION}
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
	
var editor = CKEDITOR.replace( 'AFFAIRSINFORMATION1' );
	//保存
	function save(){
			if($("#AFFAIRSNAME").val()==""){
			$("#AFFAIRSNAME").tips({
				side:3,
	            msg:'请输入党务名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#AFFAIRSNAME").focus();
			return false;
		}
		if($("#AFFAIRSTIME").val()==""){
			$("#AFFAIRSTIME").tips({
				side:3,
	            msg:'请输入发布时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#AFFAIRSTIME").focus();
			return false;
		}
		if($("#ISSUSER").val()==""){
			$("#ISSUSER").tips({
				side:3,
	            msg:'请输入发布人',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ISSUSER").focus();
			return false;
		}
		if($("#CURRENTLYUSERS").val()==""){
			$("#CURRENTLYUSERS").tips({
				side:3,
	            msg:'请输入当前登录用户',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CURRENTLYUSERS").focus();
			return false;
		}
		 var thecontent=CKEDITOR.instances.AFFAIRSINFORMATION1.getData(); 
         document.getElementById("AFFAIRSINFORMATION").value=thecontent;
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>
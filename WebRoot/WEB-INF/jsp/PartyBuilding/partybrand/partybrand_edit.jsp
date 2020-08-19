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
		

	</head>
<body>
	<form action="partybrand/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="PARTYBRAND_ID" id="PARTYBRAND_ID" value="${pd.PARTYBRAND_ID}"/>
		<input type="hidden" name="BRANDREMARKS" id="BRANDREMARKS"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">品牌名称:</td>
				<td><input type="text" name="BRANDNAME" id="BRANDNAME" value="${pd.BRANDNAME}" maxlength="32" placeholder="这里输入品牌名称" title="品牌名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">负责人:</td>
				<td><input type="text" name="BRANDPERSON" id="BRANDPERSON" value="${pd.BRANDPERSON}" maxlength="32" placeholder="这里输入负责人" title="负责人"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">创建时间:</td>
				<td><input class="date-picker" name="BRANDTIME" id="BRANDTIME" value="${pd.BRANDTIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="创建时间" title="创建时间"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">品牌备注:</td>
			<td>	<textarea name="BRANDREMARKS1" id="BRANDREMARKS1" style="width:226px;height:226px;"placeholder="这里输入品牌备注" title="品牌备注">
				${pd.ACTIVITIESCONTENT}
                </textarea> </td>
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

	//将文本框的值赋给隐藏框BRANDREMARKS
	//将文件名截取出来赋给隐藏框BRANDINTRODUCE
	//保存
	function save(){
			if($("#BRANDNAME").val()==""){
			$("#BRANDNAME").tips({
				side:3,
	            msg:'请输入品牌名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRANDNAME").focus();
			return false;
		}
		if($("#BRANDPERSON").val()==""){
			$("#BRANDPERSON").tips({
				side:3,
	            msg:'请输入负责人',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRANDPERSON").focus();
			return false;
		}
		if($("#BRANDTIME").val()==""){
			$("#BRANDTIME").tips({
				side:3,
	            msg:'请输入创建时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRANDTIME").focus();
			return false;
		}
		var marks =document.getElementById("BRANDREMARKS1").value; 
		document.getElementById("BRANDREMARKS").value=marks;
		if($("#BRANDREMARKS").val()==""){
			$("#BRANDREMARKS").tips({
				side:3,
	            msg:'请输入品牌备注',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BRANDREMARKS").focus();
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
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
</body>
</html>
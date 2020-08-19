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
			if($("#GRIDID").val()==""){
			$("#GRIDID").tips({
				side:3,
	            msg:'请输入网格ID',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#GRIDID").focus();
			return false;
		}
		if($("#GRIDNAME").val()==""){
			$("#GRIDNAME").tips({
				side:3,
	            msg:'请输入网格名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#GRIDNAME").focus();
			return false;
		}
		if($("#FLOORID").val()==""){
			$("#FLOORID").tips({
				side:3,
	            msg:'请输入楼号id',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FLOORID").focus();
			return false;
		}
		if($("#FLOORNAME").val()==""){
			$("#FLOORNAME").tips({
				side:3,
	            msg:'请输入楼号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FLOORNAME").focus();
			return false;
		}
		if($("#HOUSENAME").val()==""){
			$("#HOUSENAME").tips({
				side:3,
	            msg:'请输入房号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSENAME").focus();
			return false;
		}
		if($("#HOUSEHOLDER").val()==""){
			$("#HOUSEHOLDER").tips({
				side:3,
	            msg:'请输入户主',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSEHOLDER").focus();
			return false;
		}
		if($("#HOUSETYPE").val()==""){
			$("#HOUSETYPE").tips({
				side:3,
	            msg:'请输入房屋属性',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSETYPE").focus();
			return false;
		}
		if($("#HOUSESTATUS").val()==""){
			$("#HOUSESTATUS").tips({
				side:3,
	            msg:'请输入房屋状态',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSESTATUS").focus();
			return false;
		}
		if($("#PROPERTYRIGHT").val()==""){
			$("#PROPERTYRIGHT").tips({
				side:3,
	            msg:'请输入产权类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PROPERTYRIGHT").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	function getFloorList(obj){
		var gridId = obj.value;
		$.ajax({
			type: "POST",
			url: '<%=basePath%>floor/byGridId.do',
	    	data: {GRIDID:gridId,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 var varList=data.varList;
				 var FLOORID = document.getElementById("FLOORID");
				 FLOORID.length=1;
					for(var j=0;j<varList.length;j++){
						FLOORID.options.add(new Option(varList[j].FLOORNAME,varList[j].FLOOR_ID));
					   }
					 $(".chzn-select").trigger("liszt:updated");
			}
		});
	}
</script>
	</head>
<body>
	<form action="house/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="HOUSE_ID" id="HOUSE_ID" value="${pd.HOUSE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">网格:</td>
				<td>
				<select class="chzn-select" name="GRIDID" id="GRIDID" data-placeholder="请选择网格" onchange="getFloorList(this)" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${gridList}" var="obj">
					<option value="${obj.SQMANAGER_ID }" <c:if test="${obj.SQMANAGER_ID == pd.GRIDID }">selected</c:if>>${obj.GRIDNAME }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">楼号:</td>
				<td>
				<select class="chzn-select" name="FLOORID" id="FLOORID" data-placeholder="请选择楼号" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${floorList}" var="obj">
					<option value="${obj.FLOOR_ID }" <c:if test="${obj.FLOOR_ID == pd.FLOORID }">selected</c:if>>${obj.FLOORNAME }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">房号:</td>
				<td>
				<input type="text" name="HOUSENAME" id="HOUSENAME" value="${pd.HOUSENAME}" maxlength="32" placeholder="这里输入房号" title="房号"/>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">户主:</td>
				<td><input type="text" name="HOUSEHOLDER" id="HOUSEHOLDER" value="${pd.HOUSEHOLDER}" maxlength="32" placeholder="这里输入户主" title="户主"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">房屋属性:</td>
				<td>
				<select class="chzn-select" name="HOUSETYPE" id="HOUSETYPE" data-placeholder="请选择房屋属性" style="vertical-align:top;">
				<option  <c:if test="${'自有' == pd.HOUSETYPE }">selected</c:if>>自有</option>
				<option  <c:if test="${'出租' == pd.HOUSETYPE }">selected</c:if>>出租</option>
				<option  <c:if test="${'其他' == pd.HOUSETYPE }">selected</c:if>>其他</option>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">房屋状态:</td>
				<td>
				<select class="chzn-select" name="HOUSESTATUS" id="HOUSESTATUS" data-placeholder="请选择房屋状态" style="vertical-align:top;">
				<option  <c:if test="${'居住' == pd.HOUSESTATUS }">selected</c:if>>居住</option>
				<option  <c:if test="${'闲置' == pd.HOUSESTATUS }">selected</c:if>>闲置</option>
				<option  <c:if test="${'破损' == pd.HOUSESTATUS }">selected</c:if>>破损</option>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">产权类型:</td>
				<td><input type="text" name="PROPERTYRIGHT" id="PROPERTYRIGHT" value="${pd.PROPERTYRIGHT}" maxlength="32" placeholder="这里输入产权类型" title="产权类型"/></td>
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
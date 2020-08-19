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
	            msg:'请输入网格id',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#GRIDID").focus();
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
		if($("#UNITNAME").val()==""){
			$("#UNITNAME").tips({
				side:3,
	            msg:'请输入单位名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#UNITNAME").focus();
			return false;
		}
		/* if($("#UNITTYPE").val()==""){
			$("#UNITTYPE").tips({
				side:3,
	            msg:'请输入单位类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#UNITTYPE").focus();
			return false;
		}
		if($("#LEADER").val()==""){
			$("#LEADER").tips({
				side:3,
	            msg:'请输入负责人姓名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LEADER").focus();
			return false;
		}
		if($("#TEL").val()==""){
			$("#TEL").tips({
				side:3,
	            msg:'请输入联系电话',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#TEL").focus();
			return false;
		}
		if($("#REMARK").val()==""){
			$("#REMARK").tips({
				side:3,
	            msg:'请输入备注',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#REMARK").focus();
			return false;
		}
		if($("#CREATEDATE").val()==""){
			$("#CREATEDATE").tips({
				side:3,
	            msg:'请输入创建时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CREATEDATE").focus();
			return false;
		} */
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	function getFloorList(obj){
		var gridId = obj.value;
		//$("#GRIDNAME").val(obj.options[obj.options.selectedIndex].innerHTML);	
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
	<form action="unitmessage/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="UNITMESSAGE_ID" id="UNITMESSAGE_ID" value="${pd.UNITMESSAGE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:110px;text-align: right;padding-top: 13px;">网格:
				<input type="hidden" name="GRIDNAME" id="GRIDNAME" value="${pd.GRIDNAME}" />
				</td>
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
				<td style="width:110px;text-align: right;padding-top: 13px;">楼号:
				<input type="hidden" name="FLOORNAME" id="FLOORNAME" value="${pd.FLOORNAME}" />
				</td>
				<td>
				<select class="chzn-select" name="FLOORID" id="FLOORID" data-placeholder="请选择楼号" onchange="getHouseList(this)" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${floorList}" var="obj">
					<option value="${obj.FLOOR_ID }" <c:if test="${obj.FLOOR_ID == pd.FLOORID }">selected</c:if>>${obj.FLOORNAME }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">单位名称:</td>
				<td><input type="text" name="UNITNAME" id="UNITNAME" value="${pd.UNITNAME}" maxlength="32" placeholder="这里输入单位名称" title="单位名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">单位类型:</td>
				<td>
				<select class="chzn-select" name="UNITTYPE" id="UNITTYPE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'机关事业' == pd.UNITTYPE }">selected</c:if>>机关事业</option>
							<option <c:if test="${'医院' == pd.UNITTYPE }">selected</c:if>>医院</option>
							<option <c:if test="${'企业' == pd.UNITTYPE }">selected</c:if>>企业</option>
							<option <c:if test="${'学校' == pd.UNITTYPE }">selected</c:if>>学校</option>
							<option <c:if test="${'其他' == pd.UNITTYPE }">selected</c:if>>其他</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">负责人姓名:</td>
				<td><input type="text" name="LEADER" id="LEADER" value="${pd.LEADER}" maxlength="32" placeholder="这里输入负责人姓名" title="负责人姓名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">联系电话:</td>
				<td><input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="32" placeholder="这里输入联系电话" title="联系电话"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
				<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="32" placeholder="这里输入备注" title="备注"/></td>
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
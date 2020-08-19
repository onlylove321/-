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
			if($("#NAME").val()==""){
			$("#NAME").tips({
				side:3,
	            msg:'请输入姓名',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NAME").focus();
			return false;
		}
		if($("#SEX").val()==""){
			$("#SEX").tips({
				side:3,
	            msg:'请输入性别',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SEX").focus();
			return false;
		}
		if($("#POLITICAL").val()==""){
			$("#POLITICAL").tips({
				side:3,
	            msg:'请输入政治面貌',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#POLITICAL").focus();
			return false;
		}
		if($("#BIRTHDAY").val()==""){
			$("#BIRTHDAY").tips({
				side:3,
	            msg:'请输入出生日期',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BIRTHDAY").focus();
			return false;
		}
		if($("#EDUDEGREE").val()==""){
			$("#EDUDEGREE").tips({
				side:3,
	            msg:'请输入文化程度',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#EDUDEGREE").focus();
			return false;
		}
		var str = '';
		for(var i=0;i < document.getElementsByName('checkSPECIALCROWD').length;i++)
		{
			  if(document.getElementsByName('checkSPECIALCROWD')[i].checked){
			  	if(str=='') str += document.getElementsByName('checkSPECIALCROWD')[i].value;
			  	else str += ',' + document.getElementsByName('checkSPECIALCROWD')[i].value;
			  }
		}
		
		 $("#SPECIALCROWD").val(str);
		/* if($("#NATION").val()==""){
			$("#NATION").tips({
				side:3,
	            msg:'请输入民族',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NATION").focus();
			return false;
		}
		if($("#CARDID").val()==""){
			$("#CARDID").tips({
				side:3,
	            msg:'请输入身份证号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CARDID").focus();
			return false;
		}



		if($("#JOINPARTYDATE").val()==""){
			$("#JOINPARTYDATE").tips({
				side:3,
	            msg:'请输入入党时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#JOINPARTYDATE").focus();
			return false;
		}
		if($("#HEALTH").val()==""){
			$("#HEALTH").tips({
				side:3,
	            msg:'请输入健康状况',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HEALTH").focus();
			return false;
		}
		if($("#ISREPRESENTATIVE").val()==""){
			$("#ISREPRESENTATIVE").tips({
				side:3,
	            msg:'请输入两代表一委员',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ISREPRESENTATIVE").focus();
			return false;
		}
		if($("#RELATIONSHIP").val()==""){
			$("#RELATIONSHIP").tips({
				side:3,
	            msg:'请输入与户主关系',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#RELATIONSHIP").focus();
			return false;
		}
		if($("#MERRIAGESTATUS").val()==""){
			$("#MERRIAGESTATUS").tips({
				side:3,
	            msg:'请输入婚姻状况',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MERRIAGESTATUS").focus();
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
		if($("#WORKUNIT").val()==""){
			$("#WORKUNIT").tips({
				side:3,
	            msg:'请输入工作单位',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#WORKUNIT").focus();
			return false;
		}
		if($("#SALARY").val()==""){
			$("#SALARY").tips({
				side:3,
	            msg:'请输入工资',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SALARY").focus();
			return false;
		}
		if($("#HOUSEHOLDTYPE").val()==""){
			$("#HOUSEHOLDTYPE").tips({
				side:3,
	            msg:'请输入户口类别',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSEHOLDTYPE").focus();
			return false;
		}
		if($("#NATIVEHABITAT").val()==""){
			$("#NATIVEHABITAT").tips({
				side:3,
	            msg:'请输入原居住地',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#NATIVEHABITAT").focus();
			return false;
		}
		if($("#HOUSEHOLDREGISTER").val()==""){
			$("#HOUSEHOLDREGISTER").tips({
				side:3,
	            msg:'请输入户籍所在地',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSEHOLDREGISTER").focus();
			return false;
		}
		if($("#ISVOLUNTEER").val()==""){
			$("#ISVOLUNTEER").tips({
				side:3,
	            msg:'请输入志愿者',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ISVOLUNTEER").focus();
			return false;
		}
		if($("#MILITARYSERVICE").val()==""){
			$("#MILITARYSERVICE").tips({
				side:3,
	            msg:'请输入兵役状况',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MILITARYSERVICE").focus();
			return false;
		}
		if($("#UNITEDFRONT").val()==""){
			$("#UNITEDFRONT").tips({
				side:3,
	            msg:'请输入统战对象',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#UNITEDFRONT").focus();
			return false;
		}
		if($("#SOCIALSECURITYCODE").val()==""){
			$("#SOCIALSECURITYCODE").tips({
				side:3,
	            msg:'请输入社保编号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SOCIALSECURITYCODE").focus();
			return false;
		}
		if($("#RETIREDATE").val()==""){
			$("#RETIREDATE").tips({
				side:3,
	            msg:'请输入退休时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#RETIREDATE").focus();
			return false;
		}
		if($("#PENSION").val()==""){
			$("#PENSION").tips({
				side:3,
	            msg:'请输入领取退休金金额',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PENSION").focus();
			return false;
		}
		if($("#PARTICIPATION").val()==""){
			$("#PARTICIPATION").tips({
				side:3,
	            msg:'请输入养老保险参保情况',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PARTICIPATION").focus();
			return false;
		}
		if($("#INSUREDDATE").val()==""){
			$("#INSUREDDATE").tips({
				side:3,
	            msg:'请输入参保时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#INSUREDDATE").focus();
			return false;
		}
		if($("#INSUREDAMOUNT").val()==""){
			$("#INSUREDAMOUNT").tips({
				side:3,
	            msg:'请输入参保金额',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#INSUREDAMOUNT").focus();
			return false;
		}
		if($("#RECEIVEDATE").val()==""){
			$("#RECEIVEDATE").tips({
				side:3,
	            msg:'请输入领取养老金时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#RECEIVEDATE").focus();
			return false;
		}
		if($("#RECEIVEAMOUNT").val()==""){
			$("#RECEIVEAMOUNT").tips({
				side:3,
	            msg:'请输入领取养老金额',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#RECEIVEAMOUNT").focus();
			return false;
		}
		if($("#MEDICALINSURANCE").val()==""){
			$("#MEDICALINSURANCE").tips({
				side:3,
	            msg:'请输入医疗保险参保情况',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MEDICALINSURANCE").focus();
			return false;
		}
		if($("#MEDICALINSURANCEDATE").val()==""){
			$("#MEDICALINSURANCEDATE").tips({
				side:3,
	            msg:'请输入投保时间',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MEDICALINSURANCEDATE").focus();
			return false;
		}
		if($("#MEDICALINSURANCEID").val()==""){
			$("#MEDICALINSURANCEID").tips({
				side:3,
	            msg:'请输入医保卡号',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MEDICALINSURANCEID").focus();
			return false;
		}
		if($("#MEDICALINSURANCEAMOUNT").val()==""){
			$("#MEDICALINSURANCEAMOUNT").tips({
				side:3,
	            msg:'请输入缴纳金额',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#MEDICALINSURANCEAMOUNT").focus();
			return false;
		}
		if($("#BASICLIVING").val()==""){
			$("#BASICLIVING").tips({
				side:3,
	            msg:'请输入低保类型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BASICLIVING").focus();
			return false;
		}
		if($("#BASICLIVINGAMOUNT").val()==""){
			$("#BASICLIVINGAMOUNT").tips({
				side:3,
	            msg:'请输入低保金',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BASICLIVINGAMOUNT").focus();
			return false;
		}
		if($("#SPECIALCROWD").val()==""){
			$("#SPECIALCROWD").tips({
				side:3,
	            msg:'请输入特殊人群',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#SPECIALCROWD").focus();
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
		if($("#HOUSEID").val()==""){
			$("#HOUSEID").tips({
				side:3,
	            msg:'请输入房屋id',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSEID").focus();
			return false;
		} */
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	function getFloorList(obj){
		var gridId = obj.value;
		$("#GRIDNAME").val(obj.options[obj.options.selectedIndex].innerHTML);	
		$.ajax({
			type: "POST",
			url: '<%=basePath%>floor/byGridId.do?GRIDID='+gridId,
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
	function getHouseList(obj){
		var floorId = obj.value;
		$("#FLOORNAME").val(obj.options[obj.options.selectedIndex].innerHTML);
		$.ajax({
			type: "POST",
			url: '<%=basePath%>house/byFloorId.do',
	    	data: {FLOORID:floorId,tm:new Date().getTime()},
			dataType:'json',
			cache: false,
			success: function(data){
				 var varList=data.houseList;
				 var HOUSEID = document.getElementById("HOUSEID");
				 HOUSEID.length=1;
					for(var j=0;j<varList.length;j++){
						HOUSEID.options.add(new Option(varList[j].HOUSENAME,varList[j].HOUSE_ID));
					   }
					 $(".chzn-select").trigger("liszt:updated");
			}
		});
	}
	function changeHouseName(obj){
		$("#HOUSENAME").val(obj.options[obj.options.selectedIndex].innerHTML);
	}
</script>
	</head>
<body>
	<form action="PartyMember/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="POPULATION_ID" id="POPULATION_ID" value="${pd.POPULATION_ID}"/>
		<input type="hidden" name="SPECIALCROWD" id="SPECIALCROWD" />
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
				<td style="width:110px;text-align: right;padding-top: 13px;">楼号:
				<input type="hidden" name="FLOORNAME" id="FLOORNAME" value="${pd.FLOORNAME}" />
				</td>
				<td>
				<select class="chzn-select" name="FLOORID" id="FLOORID" data-placeholder="请选择楼号" onchange="getHouseList(this)" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${floorList}" var="obj">
					<option value="${obj.FLOOR_ID }" <c:if test="${obj.FLOORNAME == pd.FLOORNAME }">selected</c:if>>${obj.FLOORNAME }</option>
				</c:forEach>
				</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">房号:
				<input type="hidden" name="HOUSENAME" id="HOUSENAME" value="${pd.HOUSENAME}" />
				</td>
				<td>
				<select class="chzn-select" name="HOUSEID" id="HOUSEID" data-placeholder="请选择房号" onchange="changeHouseName(this)" style="vertical-align:top;">
				<option value=""></option>
				<c:forEach items="${houseList}" var="obj">
					<option value="${obj.HOUSE_ID }" <c:if test="${obj.HOUSE_ID == pd.HOUSEID }">selected</c:if>>${obj.HOUSENAME }</option>
				</c:forEach>
				</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">姓名:</td>
				<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="32" placeholder="这里输入姓名" title="姓名"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">性别:</td>
				<td>
				<select class="chzn-select" name="SEX" id="SEX" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'男' == pd.SEX }">selected</c:if>>男</option>
							<option <c:if test="${'女' == pd.SEX }">selected</c:if>>女</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">民族:</td>
				<td><input type="text" name="NATION" id="NATION" value="${pd.NATION}" maxlength="32" placeholder="这里输入民族" title="民族"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">身份证号:</td>
				<td><input type="text" name="CARDID" id="CARDID" value="${pd.CARDID}" maxlength="32" placeholder="这里输入身份证号" title="身份证号"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">出生日期:</td>
				<td>
				<input class="date-picker" name="BIRTHDAY" id="BIRTHDAY" value="${pd.BIRTHDAY}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入出生日期"/>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">文化程度:</td>
				<td>
				<select class="chzn-select" name="EDUDEGREE" id="EDUDEGREE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'初中及以下' == pd.EDUDEGREE }">selected</c:if>>初中及以下</option>
							<option <c:if test="${'高中中专' == pd.EDUDEGREE }">selected</c:if>>高中中专</option>
							<option <c:if test="${'大专' == pd.EDUDEGREE }">selected</c:if>>大专</option>
							<option <c:if test="${'本科及以上' == pd.EDUDEGREE }">selected</c:if>>本科及以上</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">政治面貌:</td>
				<td>
				<select class="chzn-select" name="POLITICAL" id="POLITICAL" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'党员' == pd.POLITICAL }">selected</c:if>>党员</option>
							<option <c:if test="${'群众团员' == pd.POLITICAL }">selected</c:if>>群众</option>
							<option <c:if test="${'团员' == pd.POLITICAL }">selected</c:if>>团员</option>
							<option <c:if test="${'其他党派' == pd.POLITICAL }">selected</c:if>>其他党派</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">入党时间:</td>
				<td>
				<input class="date-picker" name="JOINPARTYDATE" id="JOINPARTYDATE" value="${pd.JOINPARTYDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入入党时间"/>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">健康状况:</td>
				<td>
				<select class="chzn-select" name="HEALTH" id="HEALTH" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'健康' == pd.HEALTH }">selected</c:if>>健康</option>
							<option <c:if test="${'残疾' == pd.HEALTH }">selected</c:if>>残疾</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">两代表一委员:</td>
				<td>
				<select class="chzn-select" name="ISREPRESENTATIVE" id="ISREPRESENTATIVE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'是' == pd.ISREPRESENTATIVE }">selected</c:if>>是</option>
							<option <c:if test="${'否' == pd.ISREPRESENTATIVE }">selected</c:if>>否</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">与户主关系:</td>
				<td><input type="text" name="RELATIONSHIP" id="RELATIONSHIP" value="${pd.RELATIONSHIP}" maxlength="32" placeholder="这里输入与户主关系" title="与户主关系"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">婚姻状况:</td>
				<td>
				<select class="chzn-select" name="MERRIAGESTATUS" id="MERRIAGESTATUS" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'已婚' == pd.MERRIAGESTATUS }">selected</c:if>>已婚</option>
							<option <c:if test="${'未婚' == pd.MERRIAGESTATUS }">selected</c:if>>未婚</option>
							<option <c:if test="${'离异' == pd.MERRIAGESTATUS }">selected</c:if>>离异</option>
							<option <c:if test="${'丧偶' == pd.MERRIAGESTATUS }">selected</c:if>>丧偶</option>
							<option <c:if test="${'再婚' == pd.MERRIAGESTATUS }">selected</c:if>>再婚</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">联系电话:</td>
				<td><input type="text" name="TEL" id="TEL" value="${pd.TEL}" maxlength="32" placeholder="这里输入联系电话" title="联系电话"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">工作单位:</td>
				<td><input type="text" name="WORKUNIT" id="WORKUNIT" value="${pd.WORKUNIT}" maxlength="32" placeholder="这里输入工作单位" title="工作单位"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">工资:</td>
				<td><input type="text" name="SALARY" id="SALARY" value="${pd.SALARY}" maxlength="32" placeholder="这里输入工资" title="工资"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">户口类别:</td>
				<td>
				<select class="chzn-select" name="HOUSEHOLDTYPE" id="HOUSEHOLDTYPE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'农业' == pd.HOUSEHOLDTYPE }">selected</c:if>>农业</option>
							<option <c:if test="${'非农' == pd.HOUSEHOLDTYPE }">selected</c:if>>非农</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">原居住地:</td>
				<td><input type="text" name="NATIVEHABITAT" id="NATIVEHABITAT" value="${pd.NATIVEHABITAT}" maxlength="32" placeholder="这里输入原居住地" title="原居住地"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">户籍所在地:</td>
				<td><input type="text" name="HOUSEHOLDREGISTER" id="HOUSEHOLDREGISTER" value="${pd.HOUSEHOLDREGISTER}" maxlength="32" placeholder="这里输入户籍所在地" title="户籍所在地"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">志愿者:</td>
				<td>
				<select class="chzn-select" name="ISVOLUNTEER" id="ISVOLUNTEER" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'是' == pd.ISVOLUNTEER }">selected</c:if>>是</option>
							<option <c:if test="${'否' == pd.ISVOLUNTEER }">selected</c:if>>否</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">兵役状况:</td>
				<td>
				<select class="chzn-select" name="MILITARYSERVICE" id="MILITARYSERVICE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'正服兵役' == pd.MILITARYSERVICE }">selected</c:if>>正服兵役</option>
							<option <c:if test="${'退役' == pd.MILITARYSERVICE }">selected</c:if>>退役</option>
							<option <c:if test="${'未服役' == pd.MILITARYSERVICE }">selected</c:if>>未服役</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">统战对象:</td>
				<td>
				<select class="chzn-select" name="UNITEDFRONT" id="UNITEDFRONT" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'是' == pd.UNITEDFRONT }">selected</c:if>>是</option>
							<option <c:if test="${'否' == pd.UNITEDFRONT }">selected</c:if>>否</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">社保编号:</td>
				<td><input type="text" name="SOCIALSECURITYCODE" id="SOCIALSECURITYCODE" value="${pd.SOCIALSECURITYCODE}" maxlength="32" placeholder="这里输入社保编号" title="社保编号"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">退休时间:</td>
				<td>
				<input class="date-picker" name="RETIREDATE" id="RETIREDATE" value="${pd.RETIREDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入退休时间"/>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">领取退休金金额:</td>
				<td><input type="text" name="PENSION" id="PENSION" value="${pd.PENSION}" maxlength="32" placeholder="这里输入领取退休金金额" title="领取退休金金额"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">养老保险参保情况:</td>
				<td>
				<select class="chzn-select" name="PARTICIPATION" id="PARTICIPATION" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'未参保' == pd.PARTICIPATION }">selected</c:if>>未参保</option>
							<option <c:if test="${'城镇居民' == pd.PARTICIPATION }">selected</c:if>>城镇居民</option>
							<option <c:if test="${'城镇职工' == pd.PARTICIPATION }">selected</c:if>>城镇职工</option>
							<option <c:if test="${'农保' == pd.PARTICIPATION }">selected</c:if>>农保</option>
					  	</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">参保时间:</td>
				<td>
				<input class="date-picker" name="INSUREDDATE" id="INSUREDDATE" value="${pd.INSUREDDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入参保时间"/>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">参保金额:</td>
				<td><input type="text" name="INSUREDAMOUNT" id="INSUREDAMOUNT" value="${pd.INSUREDAMOUNT}" maxlength="32" placeholder="这里输入参保金额" title="参保金额"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">领取养老金时间:</td>
				<td>
				<input class="date-picker" name="RECEIVEDATE" id="RECEIVEDATE" value="${pd.RECEIVEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入领取养老金时间"/>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">领取养老金额:</td>
				<td><input type="text" name="RECEIVEAMOUNT" id="RECEIVEAMOUNT" value="${pd.RECEIVEAMOUNT}" maxlength="32" placeholder="这里输入领取养老金额" title="领取养老金额"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">医疗保险参保情况:</td>
				<td>
				<select class="chzn-select" name="MEDICALINSURANCE" id="MEDICALINSURANCE" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'商业保险' == pd.MEDICALINSURANCE }">selected</c:if>>商业保险</option>
							<option <c:if test="${'城镇居民' == pd.MEDICALINSURANCE }">selected</c:if>>城镇居民</option>
							<option <c:if test="${'城镇职工' == pd.MEDICALINSURANCE }">selected</c:if>>城镇职工</option>
							<option <c:if test="${'新农合' == pd.MEDICALINSURANCE }">selected</c:if>>新农合</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">投保时间:</td>
				<td>
				<input class="date-picker" name="MEDICALINSURANCEDATE" id="MEDICALINSURANCEDATE" value="${pd.MEDICALINSURANCEDATE}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly"  placeholder="这里输入投保时间"/>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">医保卡号:</td>
				<td><input type="text" name="MEDICALINSURANCEID" id="MEDICALINSURANCEID" value="${pd.MEDICALINSURANCEID}" maxlength="32" placeholder="这里输入医保卡号" title="医保卡号"/></td>
				<td style="width:70px;text-align: right;padding-top: 13px;">缴纳金额:</td>
				<td><input type="text" name="MEDICALINSURANCEAMOUNT" id="MEDICALINSURANCEAMOUNT" value="${pd.MEDICALINSURANCEAMOUNT}" maxlength="32" placeholder="这里输入缴纳金额" title="缴纳金额"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">低保类型:</td>
				<td>
				<select class="chzn-select" name="BASICLIVING" id="BASICLIVING" data-placeholder="请选择" style="vertical-align:top;">
							<option value="">请选择</option>
							<option <c:if test="${'城镇' == pd.BASICLIVING }">selected</c:if>>城镇</option>
							<option <c:if test="${'农村' == pd.BASICLIVING }">selected</c:if>>农村</option>
					  	</select>
				</td>
				<td style="width:70px;text-align: right;padding-top: 13px;">低保金:</td>
				<td><input type="text" name="BASICLIVINGAMOUNT" id="BASICLIVINGAMOUNT" value="${pd.BASICLIVINGAMOUNT}" maxlength="32" placeholder="这里输入低保金" title="低保金"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">特殊人群:</td>
				<td colspan="3" nowrap>
				<label><input type="checkbox" name="checkSPECIALCROWD" value="孤儿" <c:if test="${pd.SPECIALCROWD1=='1'}">checked="checked"</c:if> /> 孤儿<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="残疾" <c:if test="${pd.SPECIALCROWD2=='1'}">checked="checked"</c:if> /> 残疾<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="精神病" <c:if test="${pd.SPECIALCROWD3=='1'}">checked="checked"</c:if> /> 精神病<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="刑释解教" <c:if test="${pd.SPECIALCROWD4=='1'}">checked="checked"</c:if> /> 刑释解教<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="社区矫正" <c:if test="${pd.SPECIALCROWD5=='1'}">checked="checked"</c:if> /> 社区矫正<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="信访重点人" <c:if test="${pd.SPECIALCROWD6=='1'}">checked="checked"</c:if> /> 信访重点人<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="服刑人员" <c:if test="${pd.SPECIALCROWD7=='1'}">checked="checked"</c:if> /> 服刑人员<span class="lbl"></span></label>
			<label><input type="checkbox" name="checkSPECIALCROWD" value="吸毒人员" <c:if test="${pd.SPECIALCROWD8=='1'}">checked="checked"</c:if> /> 吸毒人员<span class="lbl"></span></label>
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
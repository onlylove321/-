<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  String path = request.getContextPath();
			String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- jsp�ļ�ͷ��ͷ�� -->
<%@ include file="../../system/admin/top.jsp"%>
<link rel="stylesheet" href="static/css/imageHotAreaStyle.css" />
</head>
<body>

	<div class="container-fluid" id="main-container">


		<div id="page-content" class="clearfix">

			<div class="row-fluid">


				<div class="row-fluid">

					<!-- ����  -->
					<form action="" method="post" name="gdzcForm"
						id="gdzcForm">
						<div id="imgMap">
							<img src="static/img/sq001.jpg" name="test" border="0"
								usemap="#Map" ref='imageMaps' />
							<map name="Map">
								<!-- ��ʼѭ�� -->
								<c:choose>
									<c:when test="${not empty hotList}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${hotList}" var="var" varStatus="vs">
												<area shape="rect" coords="${var.areaMapInfo}"
													onclick="checkMsg('${var.type}','${var.linkId}');" />
											</c:forEach>
										</c:if>
										<c:if test="${QX.cha == 0 }">
											<tr>
												<td colspan="100" class="center">����Ȩ�鿴</td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr class="main_info">
											<td colspan="100" class="center">û���������</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</map>
						</div>


						<!-- PAGE CONTENT ENDS HERE -->
				</div>
				<!--/row-->

			</div>
			<!--/#page-content-->
		</div>
		<!--/.fluid-container#main-container-->

		<!-- ���ض���  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>

		<!-- ���� -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/jquery.image-maps5.0.js"></script>
		<!-- ������ -->
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
		<!-- ������ -->
		<script type="text/javascript"
			src="static/js/bootstrap-datepicker.min.js"></script>
		<!-- ���ڿ� -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script>
		<!-- ȷ�ϴ��� -->
		<!-- ���� -->


		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<!--��ʾ��-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		//����
		function search(){
			top.jzts();
			$("#gdzcForm").submit();
		}
		
		
		</script>

		<script type="text/javascript">
		
		$(function() {
			$('#imgMap').imageMaps(); 
			//���ڿ�
			$('.date-picker').datepicker();
			
			//������
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//��ѡ��
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
	
		$(document).ready(function() {
			//$(function(){
				var setting = {
					maxAmount:100,
					tag:'tr',
					params:{
						//'areaLink':'�������ʱ��Ĭ��ֵ',
						//'areaType':'�������ʱ��Ĭ��ֵ'
					},
					//proportion:"0.5",
					domCallBack:function(params){
						//console.log(params);
					}
				}

				//��ʼ������
				var areas = "[{'areaTitle':'����1','areaLink':'','areaMapInfo':'0,0,120,80'},{'areaTitle':'���� 2','areaLink':'','areaMapInfo':'260,13,353,112'}]";
				$("#hotAreas").val(areas);  

				//$('#hotAreas').val('');     //�����������
				//$('#image_map').imageMaps(setting);
				//imageMaps.originalManual("./size.jpg",setting,true);
				imageMaps.proportionNoSameManual("static/img/sq001.jpg",setting,1,1,true);
				
				//"hotAreas" : "[{'areaTitle':'����1','areaLink':'','areaMapInfo':'0,0,90,30'},{'areaTitle':'���� 2','areaLink':'','areaMapInfo':'260,13,353,112'}]"
			});
		function checkMsg(type,linkId){
			 <%-- top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="��ѯ";
			 diag.URL = '<%=basePath%>sqpicturecheck/goCheck.do?type=' + type+'&linkId='+linkId;
				diag.Width = 225;
				diag.Height = 415;
				diag.CancelEvent = function() { //�ر��¼�
					if (diag.innerFrame.contentWindow.document
							.getElementById('zhongxin').style.display == 'none') {
						setTimeout("self.location.reload()", 100);
						top.jzts();
					}
					diag.close();
				};
				diag.show();
			} --%>
			window.location.href ='<%=basePath%>sqpicturecheck/goCheck.do?type=' + type+'&linkId='+linkId;
		}
		</script>
</body>
</html>


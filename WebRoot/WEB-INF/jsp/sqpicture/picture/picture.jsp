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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<link rel="stylesheet" href="static/css/imageHotAreaStyle.css" />
	</head> 
<body>
		
<div class="container-fluid" id="main-container">


<div id="page-content" class="clearfix">
						
  <div class="row-fluid">


	<div class="row-fluid">

			<!-- 检索  -->
			<form action="sqpicture/save.do" method="post" name="Form" id="Form">
  
			    <div class="hot_area" id = "areaContent">
     <!-- 1.图片url显示部分：-->
     <!-- <input id="" type="text"class="" readonly="readonly" value=""> -->

    <!-- 2.图片展示部分：-->
     <div class="" name="imageMap" id="image_map">
       <img src=""  ref="imageMap" id="photo"/>
     </div> 

    <!--3.添加热区对应编辑链接列表渲染部分，目前需两者选一：
     1)tablebody样式：-->
     <table><tbody id="areaItems"> </tbody></table>

    <!-- 2)ul样式：
     <ul id="areaItems"></ul>-->

    <!-- 4.添加热区按钮部分：-->
     <p><!-- <a id="add_hot_area" href="JavaScript:;" class="">添加热区</a> --> &nbsp; <!-- <a id="" href="JavaScript:viewMap();" class="">查看热区</a> --></p>
	 <p></p>

    <!-- 5.热区数据存储（隐藏）：-->
     <!-- <input type="text" class="" id="hotAreas" name="hotAreas"  value=''> -->

    <!-- 6.可添加热区数量与还可添加热区数量实时显示（可选）：-->
     <p><span class="">已添加<b class="added_amount">0</b>个热区， 还可添加<b class="remain_amount">X</b>个热区</span></p>

 			<table width="100%" border="0" cellspacing="0" cellpadding="6"  style="margin-top:20px;">
              <tr>
                <td align="center">
                <a id="add_hot_area" href="JavaScript:;" class="btn btn-mini btn-primary">添加热区</a>
	                <a class="btn btn-mini btn-primary" onClick="save();">提交</a>
	                <a class="btn btn-mini btn-primary" onClick="changeMap();">更换地图</a>

                </td>
                 
              </tr>
            </table>
 
 
 
	<!-- PAGE CONTENT ENDS HERE -->
  </div><!--/row-->
	
</div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->
		
		<!-- 返回顶部  -->
		<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
			<i class="icon-double-angle-up icon-only"></i>
		</a>
		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/jquery.image-maps5.0.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		
		
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
	
		
		
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			/* $('#imgMap').imageMaps();  */
			//日期框
			$('.date-picker').datepicker();
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//复选框
			/* $('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			}); */
			
		});

		var floorList = ${pd.floorList};
		var gridList = ${pd.gridList};
		$(document).ready(function() {
			//$(function(){
				var setting = {
					maxAmount:100,
					tag:'tr',
					params:{
					},
					data:{
						'gridList':${pd.gridList},
						'floorList':${pd.floorList},
						'hotList':${pd.hotList}
					},
					//proportion:"0.5",
					domCallBack:function(params){
						//console.log(params);
					}
				};
				//初始化加载
				//var areas = "[{'areaTitle':'热区1','areaLink':'','areaMapInfo':'0,0,120,80'},{'areaTitle':'热区 2','areaLink':'','areaMapInfo':'260,13,353,112'}]";
				var areas = ${pd.hotList};
				$("#hotAreas").val(areas);  

				//$('#hotAreas').val('');     //清空热区数据
				//$('#image_map').imageMaps(setting);
				// imageMaps.originalManual("./size.jpg",setting,true);
				imageMaps.proportionNoSameManual("static/img/sq001.jpg",setting,1,1,false);
				//"hotAreas" : "[{'areaTitle':'热区1','areaLink':'','areaMapInfo':'0,0,90,30'},{'areaTitle':'热区 2','areaLink':'','areaMapInfo':'260,13,353,112'}]"
			});
		function editUser(user_id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="资料";
			 diag.URL = '<%=basePath%>user/goEditU.do?USER_ID='+user_id;
			 diag.Width = 225;
			 diag.Height = 415;
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					setTimeout("self.location.reload()",100);
					top.jzts();
				}
				diag.close();
			 };
			 diag.show();
		}
		function save(){
			$("#Form").submit();
		}
		function changeType(obj){
			var index = obj.id.substring(4);
			var value = obj.value;
			$("#linkName"+index).val("");
			if(value==0){
				$("#typeName"+index).val("网格");
				var link = document.getElementById("linkId"+index);
				link.length=1;
				for(var j=0;j<gridList.length;j++){
					link.options.add(new Option(gridList[j].NAME,gridList[j].ID));
				   }
			}else{
				$("#typeName"+index).val("楼");
				var link = document.getElementById("linkId"+index);
				link.length=1;
				for(var j=0;j<floorList.length;j++){
					link.options.add(new Option(floorList[j].NAME,floorList[j].ID));
				   }
			}
		}
		function changeLink(obj){
			var index = obj.id.substring(6);
			$("#linkName"+index).val(obj.options[obj.options.selectedIndex].innerHTML);	
			
		}

		function changeMap(){
			top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag = true;
			 diag.Title = "地图更换";
			 diag.URL = '<%=basePath%>sqpicture/goUpload.do';
			 diag.Width = 280;
			 diag.Height = 370;
			 diag.CancelEvent = function(){ //关闭事件
				diag.close();
			 };
			 diag.show();	
			
		}
		</script>
		
	</body>
</html>


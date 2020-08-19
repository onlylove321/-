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
	<base href="<%=basePath%>"><!-- jsp文件头和头部 -->
	<%@ include file="../system/admin/top.jsp"%> 
	</head>	
	<style type="text/css">
	.btn1{
/* 	position:abslute;  */
/* 	top:0; */
/* 	left:0;  */
float:right;
	}
	.scale{
	background-size:contain|cover;
    width:100%;
    height: auto;
	}	
	</style>
	
	 <style>
   a1{
         position:relative;
   }
   a1  img{
         position:absolute;
         z-index:-1;
   }
</style>
<body>
		
<!-- <div class="container-fluid a1" id="main-container"> -->
<!-- <img src="uploadFiles/uploadImgs/backgroundimage.png" usemap="#testmap" alt="test" width=100% height=100%/> -->


<!-- <!-- <img src="uploadFiles/uploadImgs/watermark.png" usemap="#testmap" alt="test" style="background-size=100%;"/> -->


<div class="scale">
<img src="uploadFiles/uploadImgs/backgroundGridding.png" usemap="#testmap" alt="test" style="background-size=100%;"/>
<map name="testmap" id="testmap">
<area shape="rect" coords="688,155,726,192" href ="javascript:void(0);" onclick="lookContent(1);" alt="工作流程" style="outline:none;"/>
<area shape="rect" coords="682,364,737,402" href ="javascript:void(0);" onclick="lookContent(2);" alt="职责" style="outline:none;"/>
<area shape="rect" coords="883,46,937,92" href ="javascript:void(0);" onclick="lookContent(3);" alt="概念" style="outline:none;"/>
<area shape="rect" coords="1094,148,1149,197" href ="javascript:void(0);" onclick="lookContent(4);" alt="意义" style="outline:none;"/>
<area shape="rect" coords="1099,360,1157,405" href ="javascript:void(0);" onclick="lookContent(5);" alt="制度" style="outline:none;"/>
</map>
</div>




		
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
		<!-- 引入 -->
		<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
		<script type="text/javascript">
		
		$(top.hangge());
		
		

		
		//查看属性内容
		function lookContent(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="查看属性内容";
			 diag.URL = '<%=basePath%>griddingintroduce/golookContent.do?num='+Id;
			 diag.Width = 800;
			 diag.Height = 700;
			 diag.show();
		}
		</script>
		
		<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>griddingintroduce/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		}

		</script>
		
	</body>
</html>


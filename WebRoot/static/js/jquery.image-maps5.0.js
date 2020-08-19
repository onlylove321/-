/**
 * @name jQuery imageMaps plugin 5.0
 * @author liuyuqin
 * @data 2016��11��25��09:54:51
 * ===========�������ͼƬdom�ṹ����(��ʾ������Ϊ����)��=================
 * <div class="hot_area">
 * 	1.ͼƬչʾ���֣�
 * 	<div class="" name="imageMap" id="image_map">
 *       	<img src=""  ref="imageMap" id="photo"/>
 * 	</div>
 * 	2.���������Ⱦ����(�����ʽѡ1������ʽѡ2)��
 * 	1)table body��ʽ��																	2)ul��ʽ��
 * 	<table><tbody id="areaItems"> </tbody></table>				<ul id="areaItems"></ul>
 * 	3.���������ť���֣�
 * 	<p><a id="add_hot_area" href="javascript:;" class="">�������</a></p>
 * 	4.�������ݴ洢�����أ���
 * 	<input type="hidden" class="" id="hotAreas" name="hotAreas" value="">
 * 	5.��������������뻹�������������ʵʱ��ʾ��
 * 	<p><span class="">����������<b class="added_amount">0</b>���������������<b class="remain_amount">X</b>������</span></p>
 * 	6.ͼƬurl��
 * 	<input type="text" id="picUrl" name="" class=""/>
 *  </div>    
 * 
 * ======================setting �������� ��==========================
 * ���ԣ�
 * 1.�����룩maxAmount                  ���ֵ�趨
 * 2.�����룩tag                                   ��dom��ǩ��Ŀǰ����ʹ��tr,li 
 * 3.�����룩params                           ���������������ƶ��󣬶�����ʽ��setting.params = {'areaLink':'�������ʱ��Ĭ��ֵ','areaType':'�������ʱ��Ĭ��ֵ'};
 * 
 * �ص�������
 * 4.�����룩domCallBack(params)                   ����dom�����ص����������룩�� ������������dom�ṹ����,������<tr></tr>��<li></li>��params���������params��������ǰ����params.index��
 * 5.����ѡ��initCallBack(params)                     ��ʼ���лص���������ѡ������ʼ����������������params���������params��������ǰ����params.index��
 * 6.����ѡ��deleteCallBack(_this,index)          ɾ���в����ص���������ѡ����ɾ����������������_this��ɾ����tr��li����index��ɾ��������
 * 7.�����룩readjustCallBack(_this,index)      ���µ���ʣ���лص����������룩��ɾ�����������µ���ʣ���б������ݺ�����_this�����µ���ÿ�α�������tr��li����index����ǰ����
 * 
 * =======================����ͨ��dom��ȡ ��===========================
 * 
 * 1.areaSort   ���������class
 * 2.areaTitle  ��������class
 * 3.areaMapInfo  ��������class
 * 4.area_item ������class
 * 
 *  =============================˵�� ��===============================
 *  
 * 1.<div class="" name="imageMap" id="image_map"> ͼƬdom���������ݴ�dom����ʼ��
 * 2.��Ⱦ����Ϊÿ��������Ӧ���������ӵ���Ϣ���Ա���ul li��ʽչʾ
 * 3.hotAreasװ��������Ϣjson�������������ƣ����꣬���ӵ���Ϣ����Ҫ�û�����dom��ȡֵȻ��ƴ�ӳ�json����������Ϣ
 * 	���ڼ�����Ⱦʱ��Ҳ�Ǹ��ݴ˲�����ֵ������������Ϣ�����磺
 * "hotAreas" : "[{'areaTitle':'���� 1','areaLink':'','areaMapInfo':'0,0,90,30'},
 * 						   {'areaTitle':'���� 2','areaLink':'','areaMapInfo':'260,13,353,112'}]"
 * 4.ͨ�ò��������storeBaseUtils.js����jsΪ����ͨ��js����ɾ������ͬʱ�޸�baseUtils.showNormalDialog����
 * 5.ɾ�������� �����µ���������������ʾ���֣�Ҳ�����ʣ��tr��li���������Ƽ�������ţ�readjustCallBack���ڱ���ѭ���жԵ�ǰ�е�����dom�Ĵ���
 */

	
			
			var imageMaps = {};
			var proportionDefaultWidth = 1;
			var proportionDefaultHeight = 1;
			
			$.fn.imageMaps = function(setting){
				var initFlag = false;
				var deleteFlag = false;
				
				if(setting.initCallBack != null){
					initFlag = true;
				}
				if(setting.deleteCallBack != null){
					deleteFlag = true;
				}

				function initAddClickEvent(){
					// 初始化添加热区功能按钮
					$("#add_hot_area").unbind("click").click(function () {
						var index;
						var imageMap = $("#image_map");
						var areaContainer = imageMap.parent();
						positionContainer = areaContainer.find('.position_container');
						index = areaContainer.find(setting.tag+ '[name="areaItem"]').length + 1;
						if ($("#image_map").find('img').attr('src') == '') {
							/*dialogUtil.showNormalDialog({
								"title" : "��ܰ��ʾ",
								"content" : '�����ϴ�ͼƬ',
								"showCancelBtn" : false
							});*/
							alert('请上传图片');
							return;
						}
						var rowCount = $(".area_item");
						if (rowCount != null) {
							var c = rowCount.length;
							if (c == setting.maxAmount) {
								/*dialogUtil.showNormalDialog({
									"title" : "��ܰ��ʾ",
									"content" : 'ֻ�����'+ setting.maxAmount+ '������',
									"showCancelBtn" : false
								});*/
								alert( '只能添加'+ setting.maxAmount+ '个热区');
								return;
							}
						}
						//清除setting中的特殊dom参数
						for(var attr in setting.params){
							setting.params[attr] =  '';
						}
						setting.params.index = index;
						$('#areaItems').append(createAreaItem(index,null,null,'','0,0,90,30',setting.tag,0,setting.domCallBack(setting.params)));
						if(initFlag){
							setting.initCallBack(setting.params);
						}
						selectPosition();
						positionContainer.append('<div ref="'+ index+ '" class="map_position map_selected_position" style="left:0px;top:0px;width:90px;height:30px;"><div class="map_position_bg"></div><span class="link_number_text"> '+ index+ '</span><span class="delete"></span><span class="resize"></span></div>');
						bindMapEvent();
						updateAreaCount();
						initDeleteClickEvent();
						return false;
					});
				}
				
				
				function initDeleteClickEvent(){
					//初始化删除热区功能按钮
					$('.hot_area .delete').unbind('click').click(function () {
						//点击热区内的删除按钮和点击table中的删除按钮dom层级不一致
						var ref = $(this).parents('[ref]').eq(0).attr('ref');
						var areaContainer = $(".hot_area");
						var positionContainer = areaContainer.find('.position_container');
						var pictureId=areaContainer.find("input[name='pictureId']").val();
						areaContainer.find(setting.tag +'[name="areaItem"][ref='+ ref + ']').remove();
						positionContainer.find('.map_position[ref=' + ref+ ']').remove();
						
						$.ajax({
							type: "POST",
							url: 'sqpicture/delete.do?pictureId='+pictureId,
					    	data: {pictureId:pictureId,tm:new Date().getTime()},
							dataType:'json',
							cache: false,
							success: function(data){
								 
							}
						});
						//window.location.href='sqpicture/delete.do?pictureId='+areaContainer.find("input[name='pictureId']").val();
						
						var index = 1;
						areaContainer.find(setting.tag + '[name="areaItem"]').each(function() {
							$(this).attr('ref',index);
							$(this).find('.areaSort').html('热区'+ index+"：");
							$(this).find("input[id='pictureId"+ref+"']").attr('id','pictureId'+ index);
							$(this).find("input[name='typeName']").attr('id','typeName'+ index);
							$(this).find("input[name='linkName']").attr('id','linkName'+ index);
							$(this).find("select[name='type']").attr('id','type'+ index);
							$(this).find("select[name='linkId']").attr('id','linkId'+ index);
							if(deleteFlag){
								setting.deleteCallBack($(this),index);
							}
							index++;
						});
						index = 1;
						positionContainer.find('.map_position').each(function() {
								$(this).attr('ref',index).find('.link_number_text').html(index);
								index++;
						});
						updateAreaCount();
					});
				}
				
				//初始化热区
				this.each(function() {
					var imageMap = $(this);
					var hotImage = imageMap.find('img[ref=imageMap]');
					// 清空容器的原有内容，重新填充内容
					// 清除原有热区
					imageMap.empty();
					imageMap.append(hotImage);
					//删除所有热区条目
					$(setting.tag + '[name="areaItem"]').remove();
					updateAreaCount();
					//初始化热区dom结构和可移动范围
					if (hotImage != null) {
						hotImage.wrap('<div class="image_container" style="position:relative;"></div>').css('border', '1px solid #ccc');
						var imageContainer = hotImage.parent(), imgConrainerOffset = imageContainer.offset(), imgOffset = hotImage.offset();
						imageContainer.append(/msie/.test(navigator.userAgent.toLowerCase()) ? $('<div class="position_container"></div>').css({
							background : '#fff',
							opacity : 0
						}): '<div class="position_container"></div>');
						imageContainer.find('.position_container').css({
							top : imgOffset.top- imgConrainerOffset.top,
							left : imgOffset.left- imgConrainerOffset.left,
							width : hotImage.width(),// 这里按照1.0，将hotImage改为imageMap
							height : hotImage.height(),
							border : '1px solid transparent'
						});
					}
					initAreaInfo();
					bindMapEvent();
					updateAreaCount();
					initAddClickEvent();
					initDeleteClickEvent();
				});

				
				// 初始化热区信息
				function initAreaInfo(){
					// 根据dom做了名称改动
					//var areaInfo = $('input[name="hotAreas"]').val();
					var areaInfo = setting.data.hotList;
					if ($('.hot_area img[ref=imageMap]').attr("src")
							&& areaInfo != null && areaInfo != '') {
						var index = 1;
						var areaContainer = $(".hot_area");
						var positionContainer = areaContainer
								.find('.position_container');
console.log(areaInfo);
						var areaInfoJson = eval(areaInfo);
						areaInfoJson = areaInfoJson;
						if (areaInfoJson != null && areaInfoJson.length > 0) {
							for (var j = 0; j < areaInfoJson.length; j++) {
								var typeName = areaInfoJson[j].typeName;
								var linkName = areaInfoJson[j].linkName;
								var pictureId = areaInfoJson[j].pictureId;
								var areaMapInfo = areaInfoJson[j].areaMapInfo;
								for(var attr in setting.params){
									setting.params[attr] =  areaInfoJson[j][attr];
								}
								//将行序号添加至特殊参数名称数组的开头
								setting.params.index = index;
								if (typeName == null) {
									typeName == '';
								}
								if (linkName == null) {
									linkName == '';
								}
								if (areaMapInfo == null) {
									areaMapInfo == '';
								}
								if(areaMapInfo) {
									//进行图片尺寸缩放
	    	                        var coordsTemp = areaMapInfo.split(',');
	    	                        coordsTemp[0] = coordsTemp[0]*proportionDefaultWidth;
	    	                        coordsTemp[1] = coordsTemp[1]*proportionDefaultHeight;
	    	                        coordsTemp[2] = coordsTemp[2]*proportionDefaultWidth;
	    	                        coordsTemp[3] = coordsTemp[3]*proportionDefaultHeight;
	    	                        areaMapInfo = coordsTemp[0]+','+coordsTemp[1]+','+coordsTemp[2]+','+coordsTemp[3];
	                            	$('#areaItems').append(createAreaItem(index, typeName,linkName,pictureId, areaMapInfo,setting.tag,1,setting.domCallBack(setting.params)));
	            					if(initFlag){
	            						setting.initCallBack(setting.params);
	            					}
	            					var coords = areaMapInfo.split(',');
	                                positionContainer.append('<div ref="'+index+'" class="map_position" style="left:'+coords[0]+'px;top:'+coords[1]+'px;width:'+(coords[2]-coords[0])+'px;height:'+(coords[3]-coords[1])+'px;"><div class="map_position_bg"></div><span class="link_number_text"> '+index+'</span><span class="delete"></span><span class="resize"></span></div>');
	                                index++;
								}
							}
						}
					}
				}

				//done
				function createAreaItem(index, typeName,linkName,pictureId,areaMapInfo,rowTagDom,type,specialHotItemDom) {
//console.log("specialHotItemDom:"+specialHotItemDom);
					var item = [];
					var gridList=eval(setting.data.gridList);
					//目前仅可使用table和ul li 样式
					if (type == 0) {
						item.push('<tr name = "areaItem" class="mt area_item" ref="'+ index + '">');
						item.push('<td><span class="areaSort"><b>热区'+ index+ '</b></span><input type="hidden" name="typeName" id="typeName'+ index+ '" value="'+ typeName + '"/></td>');
						item.push('<td><select  name="type" id="type'+ index+ '" data-placeholder="请选择" onchange="changeType(this)" style="vertical-align:top;width: 80px;">');
						item.push('<option value="">请选择</option><option value="0">网格</option><option value="1">楼</option></select></td>');
						item.push('<td><input type="hidden" name="linkName" id="linkName'+ index+ '" value="'+ linkName + '"/>');
						item.push('<select  name="linkId" id="linkId'+ index+ '" onchange="changeLink(this)" style="vertical-align:top;width: 90px;"><option value="">请选择</option>');
						for(var i=0;i<gridList.length;i++){
							item.push('<option value="'+gridList[i].ID+'">'+gridList[i].NAME+'</option>');
							
						}
					    item.push('</select></td>');
						item.push('<td>位置<input type="text" name="areaMapInfo" id="areaMapInfo'+ index+ '" style="vertical-align:top;width: 90px;" class="areaMapInfo" value="'+ areaMapInfo + '" /></td>');
						item.push('<td><a href="javascript:;" class="second_btn ml delete">删除</a></td>');
						item.push('</tr>');
					} else {
						item.push('<tr name = "areaItem" class="mt area_item" ref="'+ index + '">');
						item.push('<td><input type="hidden" disabled name="pictureId" id="pictureId'+ index+ '" value="'+ pictureId + '"/><span class="areaSort"><b>热区'+ index+ '</b></span></td>');
						item.push('<td><span class=""><b>&nbsp;&nbsp;'+ typeName+ '</b></span></td>');
						item.push('<td><span class=""><b>&nbsp;&nbsp;'+ linkName+ '</b></span></td>');

						item.push('<td>&nbsp;&nbsp位置<input type="text" class="areaMapInfo" value="'+ areaMapInfo + '" /></td>');
						item.push('<td><a href="javascript:;" class="second_btn ml delete">删除</a></td>');
						item.push('</tr>');
					}
					return item.join('');
				}


				//��map�¼� done
		        function bindMapEvent(){
		            $(document).unbind("mousemove");
		            $(document).unbind("mouseup");
		            $('.position_container .map_position .map_position_bg').each(function(){
		                var mapPositionBg = $(this);
		                var container = $(this).parent().parent();
		                var mapPosition = $(this).parent();
		                var linkNumberText = mapPosition.find('.link_number_text');
		                
		                mapPositionBg.unbind('mousedown').mousedown(function(event){
		                    mapPositionBgMousedownFtn(event);
		                });
		                
		                linkNumberText.unbind('mousedown').mousedown(function(event){
		                    mapPositionBgMousedownFtn(event);
		                });
		                
		                function mapPositionBgMousedownFtn(event) {
		                    mapPositionBg.data('mousedown', true);
		                    mapPositionBg.data('pageX', event.pageX);
		                    mapPositionBg.data('pageY', event.pageY);
		                    mapPositionBg.css('cursor','move');
		                    selectPosition(mapPosition);
		                    return false;
		                }
		                
		                $(document).mousemove(function(event) {
		                    if (!mapPositionBg.data('mousedown')) return false;
		                        var dx = event.pageX - mapPositionBg.data('pageX');
		                        var dy = event.pageY - mapPositionBg.data('pageY');
		                        if ((dx == 0) && (dy == 0)){
		                            return false;
		                        }
		                        var mapPosition = mapPositionBg.parent();
		                        var p = mapPosition.position();
		                        
		                        var left = p.left+dx;
		                        
		                        if(left < 0) left = 0;
		                        var top = p.top+dy;
		                        if (top < 0) top = 0;
		                        var bottom = top + mapPosition.height();
		                        if(bottom > container.height()){
									top = top-(bottom-container.height());
								}
		                        var right = left + mapPosition.width();
		                        if(right > container.width()){
									left = left-(right-container.width());
								}
		                        
		                        mapPosition.css({
		                            left:left,
		                            top:top
		                        });
		                        mapPositionBg.data('pageX', event.pageX);
		                        mapPositionBg.data('pageY', event.pageY);
		                        
		                        bottom = top + mapPosition.height();
		                        right = left + mapPosition.width();
		                        $(setting.tag + '[name="areaItem"][ref='+ mapPosition.attr('ref') +'] .areaMapInfo').val(new Array(Math.round(left),Math.round(top),Math.round(right),Math.round(bottom)).join(','));
		                        return false;   
		                }).mouseup(function(event){
		                    mapPositionBg.data('mousedown', false);
		                    mapPositionBg.css('cursor','default');
		                    return false;
		                });
		            });
		        $('.position_container .map_position .resize').each(function(){
		            var mapPositionResize = $(this);
		            var container = $(this).parent().parent();
		            var mapPosition = $(this).parent();
		            
		            mapPositionResize.unbind('mousedown').mousedown(function(event){
		                mapPositionResize.data('mousedown', true);
		                mapPositionResize.data('pageX', event.pageX);
		                mapPositionResize.data('pageY', event.pageY);
		                return false;
		            }).unbind('mouseup').mouseup(function(event){
		                mapPositionResize.data('mousedown', false);
		                return false;
		            });
		            $(document).mousemove(function(event){
		                if (!mapPositionResize.data('mousedown')) return false;

		                var dx = event.pageX - mapPositionResize.data('pageX');
		                var dy = event.pageY - mapPositionResize.data('pageY');
		                if ((dx == 0) && (dy == 0)){
		                    return false;
		                }
		                var mapPosition = mapPositionResize.parent();
		                var p = mapPosition.position();
		                var left = p.left;
		                var top = p.top;
		                var height = mapPosition.height()+dy;
		                if((top+height) > container.height()){
		                    height = height-((top+height)-container.height());
		                }
		                if (height <20) height = 20;
		                var width = mapPosition.width()+dx;
		                if((left+width) > container.width()){
		                    width = width-((left+width)-container.width());
		                }
		                if(width <12) width = 12;
		                mapPosition.css({
		                    width:width,
		                    height:height
		                });
		                mapPositionResize.data('pageX', event.pageX);
		                mapPositionResize.data('pageY', event.pageY);
		                
		                bottom = top + mapPosition.height();
		                right = left + mapPosition.width();
		                $(setting.tag + '[name="areaItem"][ref='+ mapPosition.attr('ref') +'] .areaMapInfo').val(new Array(Math.round(left),Math.round(top),Math.round(right),Math.round(bottom)).join(','));
		                return false;
		            }).mouseup(function(event){
		                mapPositionResize.data('mousedown', false);
		                return false;
		            });
		        });
			}

			//ѡ��ĳ������map
			function selectPosition(selectedPosition) {
				$(".map_position").removeClass("map_selected_position");
				if (selectedPosition) {
					selectedPosition.addClass("map_selected_position");
				}
			}

			//������������
			function updateAreaCount() {
				var maxCount = setting.maxAmount;
				var rowCount = $(".area_item");
				if (rowCount != null) {
					var c = rowCount.length;
					$(".added_amount").html(c);
					$(".remain_amount").html(maxCount - c);
				}
			}
	};
	
	//��ȡ��Ӧ�еı���
	imageMaps.getAreaTitle = function(item){
		return item.find('.area_title').val();
	}
	
	//��ȡ��Ӧ�е������
	imageMaps.getAreaSort = function(item){
		return item.find('.areaSort').val();
	}
	
	//��ȡ��Ӧ�е����꣨�������ţ�
	imageMaps.getAreaMapInfo = function(item){
		return item.find('.areaMapInfo').val();
	}
	
	//��ȡ��Ӧ�е����꣨���ȱ����ţ��������з�����
	imageMaps.getProportionAreaMapInfo = function(item,proportion){
		var rate = proportionDefaultWidth;
		if(proportion){
			rate = proportion;
		}
    	var areaMapInfo = item.find('.areaMapInfo').val();
        var coordsTemp = areaMapInfo.split(',');
        coordsTemp[0] = parseInt(coordsTemp[0]/rate);
        coordsTemp[1] = parseInt(coordsTemp[1]/rate);
        coordsTemp[2] = parseInt(coordsTemp[2]/rate);
        coordsTemp[3] = parseInt(coordsTemp[3]/rate);
        areaMapInfo = coordsTemp[0]+','+coordsTemp[1]+','+coordsTemp[2]+','+coordsTemp[3];
        return areaMapInfo;
	};
	
	//��ȡ��Ӧ�е����꣨���ǵȱ����ţ��������з�����
	imageMaps.getProportionNoSameAreaMapInfo = function(item,proportionWidth,proportionHeight){
		if(!proportionWidth){
			proportionWidth = 1;
		}
		if(!proportionHeight){
			proportionHeight = 1;
		}
    	var areaMapInfo = item.find('.areaMapInfo').val();
        var coordsTemp = areaMapInfo.split(',');
        coordsTemp[0] = parseInt(coordsTemp[0]/proportionWidth);
        coordsTemp[1] = parseInt(coordsTemp[1]/proportionHeight);
        coordsTemp[2] = parseInt(coordsTemp[2]/proportionWidth);
        coordsTemp[3] = parseInt(coordsTemp[3]/proportionHeight);
        areaMapInfo = coordsTemp[0]+','+coordsTemp[1]+','+coordsTemp[2]+','+coordsTemp[3];
        return areaMapInfo;
	};
	
	/**
	 * 1.�ǵȱ����š�������ȣ����߱�
	 * pic��ͼƬurl
	 * setting��������������
	 * proportionWidth�����ű��� 0-1
	 * proportionHeight�����ű��� 0-1
	 * imageMapsSwitch ������������أ�true�������false����
	 */
	imageMaps.proportionNoSameManual = function(pic,setting,proportionWidth,proportionHeight,imageMapsSwitch){
		var imageMap = $("#image_map");
		if(!(imageMap.hasClass("none"))){
			imageMap.addClass("none");	
		}
    	var obj = $('#photo');
		obj.attr('src', pic);
	    obj.error(function() {
	    	obj.attr('src', pic);
	    }); 
	    var datas = { pic : pic, setting : setting , proportionWidth: proportionWidth, proportionHeight : proportionHeight, imageMapsSwitch : imageMapsSwitch};
	    obj.load(datas,function(event){
			//����ͼƬ��������src
		   	var img = new Image();
		   	img.src = event.data.pic;
		   	var imageWidth = img.width;
		   	var imageHeight = img.height;
	    	imageMap.removeClass("none");
		   	this.width = imageWidth * event.data.proportionWidth;
		   	this.height = imageHeight * event.data.proportionHeight;
		   	proportionDefaultWidth = proportionWidth;
		   	proportionDefaultHeight = proportionHeight;
		   	if(!imageMapsSwitch || imageMapsSwitch == true){
		   		//����ͼƬ�������
	            $('#image_map').imageMaps(setting);
		   	}
        });
    };
    
	/**
	 * 2.�ǵȱ����š�����������
	 * pic��ͼƬurl
	 * setting��������������
	 * scaleWidth�� ��� 
	 * scaleHeight���߶�
	 * imageMapsSwitch ������������أ�true�������false����
	 */
	imageMaps.scaleNoSameManual = function(pic,setting,scaleWidth,scaleHeight,imageMapsSwitch){
		var imageMap = $("#image_map");
		if(!(imageMap.hasClass("none"))){
			imageMap.addClass("none");	
		}
    	var obj = $('#photo');
		obj.attr('src', pic);
	    obj.error(function() {
	    	obj.attr('src', pic);
	    }); 
	    var datas = { pic : pic, setting : setting , scaleWidth: scaleWidth, scaleHeight : scaleHeight, imageMapsSwitch : imageMapsSwitch};
	    obj.load(datas,function(event){
			//����ͼƬ��������src
		   	var img = new Image();
		   	img.src = event.data.pic;
		   	var imageWidth = img.width;
		   	var imageHeight = img.height;
	    	imageMap.removeClass("none");
		   	this.width = scaleWidth;
		   	this.height = scaleHeight;
		   	proportionDefaultWidth = scaleWidth/imageWidth;
		   	proportionDefaultHeight = scaleHeight/imageHeight;
		   	if(!imageMapsSwitch || imageMapsSwitch == true){
		   		//����ͼƬ�������
	            $('#image_map').imageMaps(setting);
		   	}
        });
    };
    
	/**
	 * 3.�ȱ����š��������
	 * pic��ͼƬurl
	 * setting��������������
	 * proportion�����ű��� 0-1
	 * imageMapsSwitch ������������أ�true�������false����
	 */
	imageMaps.proportionSameManual = function(pic,setting,proportion,imageMapsSwitch){
		var imageMap = $("#image_map");
		if(!(imageMap.hasClass("none"))){
			imageMap.addClass("none");	
		}
    	var obj = $('#photo');
		obj.attr('src', pic);
	    obj.error(function() {
	    	obj.attr('src', pic);
	    }); 
	    var datas = { pic : pic, setting : setting , proportion : proportion , imageMapsSwitch : imageMapsSwitch};
	    obj.load(datas,function(event){
	    	//����ͼƬ��������src
		   	var img = new Image();
		   	img.src = event.data.pic;
	    	imageMap.removeClass("none");
		   	var imageWidth = img.width;
		   	this.width = imageWidth * event.data.proportion;
		   	proportionDefaultWidth = proportion;
		   	proportionDefaultHeight = proportion;
		   	if(!imageMapsSwitch || imageMapsSwitch == true){
		   		//����ͼƬ�������
	            $('#image_map').imageMaps(setting);
		   	}
        });
    };
    
	/**
	 * 4.�ȱ����š�������
	 * pic��ͼƬurl
	 * setting��������������
	 * scaleWidth�����ź�Ŀ��
	 * imageMapsSwitch ������������أ�true�������false����
	 */
	imageMaps.scaleWidthSameManual = function(pic,setting,scaleWidth,imageMapsSwitch){
		var imageMap = $("#image_map");
		if(!(imageMap.hasClass("none"))){
			imageMap.addClass("none");	
		}
    	var obj = $('#photo');
		obj.attr('src', pic);
	    obj.error(function() {
	    	obj.attr('src', pic);
	    }); 
	    var datas = { pic : pic, setting : setting , scaleWidth: scaleWidth, imageMapsSwitch : imageMapsSwitch};
	    obj.load(datas,function(event){
	    	//����ͼƬ��������src
		   	var img = new Image();
		   	img.src = event.data.pic;
	    	imageMap.removeClass("none");
		   	var imageWidth = img.width;
		   	this.width = scaleWidth;
		   	proportionDefaultWidth = scaleWidth/imageWidth;
		   	proportionDefaultHeight = proportionDefaultWidth;
		   	if(!imageMapsSwitch || imageMapsSwitch == true){
		   		//����ͼƬ�������
	            $('#image_map').imageMaps(setting);
		   	}
        });
    };
    
	/**
	 *  5.�ǵȱ����š����������߱�
	 *  pic��ͼƬurl
	 *  setting��������������
	 *  scaleWidth�����ź�Ŀ��
	 *  proportionHeight���߶����ű��� 0-1
	 * imageMapsSwitch ������������أ�true�������false����
	 */
	imageMaps.scaleWidthproportionHeightManual = function(pic,setting,scaleWidth,proportionHeight,imageMapsSwitch){
		var imageMap = $("#image_map");
		if(!(imageMap.hasClass("none"))){
			imageMap.addClass("none");	
		}
    	var obj = $('#photo');
		obj.attr('src', pic);
	    obj.error(function() {
	    	obj.attr('src', pic);
	    }); 
	    var datas = { pic : pic, setting : setting , scaleWidth: scaleWidth,proportionHeight:proportionHeight, imageMapsSwitch : imageMapsSwitch};
	    obj.load(datas,function(event){
	    	//����ͼƬ��������src
		   	var img = new Image();
		   	img.src = event.data.pic;
	    	imageMap.removeClass("none");
		   	var imageWidth = img.width;
			var imageHeight = img.height;
		   	this.width = scaleWidth;
		   	this.height = imageHeight * proportionHeight;
		   	proportionDefaultWidth = scaleWidth/imageWidth;
		   	proportionDefaultHeight = proportionHeight;
		   	if(!imageMapsSwitch || imageMapsSwitch == true){
		   		//����ͼƬ�������
	            $('#image_map').imageMaps(setting);
		   	}
        });
    };
    
		/**
		* 6.�ȱ����š����Զ�
		* pic��ͼƬurl
		* setting��������������
		* imageMapsSwitch ������������أ�true�������false����
		*/
		imageMaps.proportionAutoManual = function(pic,setting,imageMapsSwitch){
			//����imageMap
			var imageMap = $("#image_map");
			if(!(imageMap.hasClass("none"))){
				imageMap.addClass("none");	
			}
	    	var obj = $('#photo');
	    	var proportion;
			obj.attr('src', pic);
		    obj.error(function() {
		    	obj.attr('src', pic);
		    }); 
		    var datas = { pic : pic, setting : setting , imageMapsSwitch : imageMapsSwitch};
		    obj.load(datas,function(event){
				//����ͼƬ��������src
			   	var img = new Image();
			   	img.src = event.data.pic;
			   	var imageWidth = img.width;
		    	imageMap.removeClass("none");
		    	var img_width = $('#image_map').width();
			   	if(imageWidth <= img_width){
			   		proportion = 1;
			   	}
			   	else{
			   		proportion = img_width/imageWidth;
			   	}
			   	this.width = imageWidth * proportion;
			   	proportionDefaultWidth = proportion;
			   	proportionDefaultHeight = proportion;
			   	if(!imageMapsSwitch || imageMapsSwitch == true){
			   		//����ͼƬ�������
		            $('#image_map').imageMaps(setting);
			   	}
	        });
	   };
	   
	   
		/**
		* 6.����������
		* pic��ͼƬurl
		* setting��������������
		* imageMapsSwitch ������������أ�true�������false����
		*/
		imageMaps.originalManual = function(pic,setting,imageMapsSwitch){
			//����imageMap
			var imageMap = $("#image_map");
			if(!(imageMap.hasClass("none"))){
				imageMap.addClass("none");	
			}
	    	var obj = $('#photo');
	    	var proportion;
			obj.attr('src', pic);
		    obj.error(function() {
		    	obj.attr('src', pic);
		    }); 
		    var datas = { pic : pic, setting : setting , imageMapsSwitch : imageMapsSwitch};
		    obj.load(datas,function(event){
				//����ͼƬ��������src
			   	var img = new Image();
			   	img.src = event.data.pic;
			   	var imageWidth = img.width;
		    	imageMap.removeClass("none");
			   	proportionDefaultWidth = 1;
			   	proportionDefaultHeight = 1;
			   	if(!imageMapsSwitch || imageMapsSwitch == true){
			   		//����ͼƬ�������
		            $('#image_map').imageMaps(setting);
			   	}
	        });
	   };
        


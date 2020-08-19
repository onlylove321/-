package com.fh.controller.PartyBuilding.partybrand;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.PartyBuilding.partybrand.PartyBrandService;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;


/** 
 * 类名称：PartyBrandController
 * 创建人：FH 
 * 创建时间：2018-05-04
 */
@Controller
@RequestMapping(value="/partybrand")
public class PartyBrandController extends BaseController {
	
	String menuUrl = "partybrand/list.do"; //菜单地址(权限用)
	@Resource(name="partybrandService")
	private PartyBrandService partybrandService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARTYBRAND_ID", this.get32UUID());	//主键
		pd.put("SUBMISSIONTIME", Tools.date2Str(new Date()));	//提交时间
		partybrandService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			partybrandService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		
	}
	
	/**
	 * 删除附件
	 */
	@RequestMapping(value="/deleteFile")
	public void deleteFile(PrintWriter out,String PARTYBRAND_ID){
		logBefore(logger, "删除PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "deleteFile")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			pd.put("PARTYBRAND_ID",PARTYBRAND_ID);
			String name=partybrandService.findIntroduceById(pd);
			pd.put("BRANDINTRODUCE","");
			pd.put("BRANDINTRODUCE2","");
			partybrandService.editIntroduce(pd);
			String path = "C:\\tomcat\\webapps\\FHMYSQL\\uploadFiles\\file\\";
			File file = new File(path+ File.separator + name);
			if (file.exists()) {
			    file.delete();
			}
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}	
	}
	
	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		partybrandService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表PartyBrand");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData>	varList = partybrandService.list(page);	//列出PartyBrand列表
			mv.setViewName("PartyBuilding/partybrand/partybrand_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增PartyBrand页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("PartyBuilding/partybrand/partybrand_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改PartyBrand页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = partybrandService.findById(pd);	//根据ID读取
			mv.setViewName("PartyBuilding/partybrand/partybrand_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				partybrandService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}
	
	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出PartyBrand到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("品牌名称");	//1
			titles.add("负责人");	//2
			titles.add("创建时间");	//3
			titles.add("下载链接");	//4
			titles.add("品牌备注");	//5
			titles.add("当前登录用户");	//6
			titles.add("提交时间");	//7
			dataMap.put("titles", titles);
			List<PageData> varOList = partybrandService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("BRANDNAME"));	//1
				vpd.put("var2", varOList.get(i).getString("BRANDPERSON"));	//2
				vpd.put("var3", varOList.get(i).getString("BRANDTIME"));	//3
				vpd.put("var4", varOList.get(i).getString("BRANDINTRODUCE"));	//4
				vpd.put("var5", varOList.get(i).getString("BRANDREMARKS"));	//5
				vpd.put("var6", varOList.get(i).getString("CURRENTLYUSERS"));	//6
				vpd.put("var7", varOList.get(i).getString("SUBMISSIONTIME"));	//7
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="/download")
	public String download(HttpServletRequest request,
		HttpServletResponse response) throws Exception{	
		logBefore(logger, "下载PartyBrand");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "download")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String fileName2=partybrandService.findOringalIntroduceById(pd);
		String fileName=partybrandService.findIntroduceById(pd);
	response.setCharacterEncoding("utf-8");
	response.setContentType("multipart/form-data");
	response.setHeader("Content-Disposition","attachment;fileName="+ new String(fileName2.getBytes("utf-8"), "ISO-8859-1"));
		String path = "C:\\tomcat\\webapps\\FHMYSQL\\uploadFiles\\file\\";
		InputStream inputStream = new FileInputStream(new File(path
				+ File.separator + fileName));
		OutputStream os = response.getOutputStream();
		byte[] b = new byte[2048];
		int length;
		while ((length = inputStream.read(b)) > 0) {
			os.write(b, 0, length);
			os.flush();
		}
		 // 这里主要关闭。
		os.close();
		inputStream.close();
	return null;
	}
	
	
	/**
	 * 去跳转到品牌备注介绍
	 */
	@RequestMapping(value="/goSkipMask")
	public ModelAndView goSkipMask()throws Exception{
		logBefore(logger, "查看PartyBrandMasks");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "goSkipMask")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String redouction=partybrandService.findMaskById(pd);
		mv.setViewName("PartyBuilding/partybrand/partybrand_lookMask");
		mv.addObject("msg4",redouction);
		return mv;
	}
	
	/**
	 * 跳转到上传页面
	 */
	@RequestMapping(value="/gouploadMask")
	public ModelAndView gouploadMask(String PARTYBRAND_ID)throws Exception{
		logBefore(logger, "查看PartyBrandMasks");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "gouploadMask")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		mv.addObject("id",PARTYBRAND_ID);
		mv.setViewName("PartyBuilding/partybrand/partybrand_uploadMask");
		return mv;
	}
	
	/**
	 * 进行文件上传并将文件名保存到数据库中
	 */
	@RequestMapping(value="/uploadFile")
	public ModelAndView uploadFile(String BRANDINTRODUCE,String PARTYBRAND_ID,HttpServletRequest request,MultipartFile BRANDINTRODUCE1)throws Exception{
		logBefore(logger, "进行文件上传");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "uploadFile")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARTYBRAND_ID",PARTYBRAND_ID);	    //主键
		
        
        String originalFilename = UUID.randomUUID()+BRANDINTRODUCE1.getOriginalFilename();
        String BRANDINTRODUCE2=originalFilename;
        System.out.println(BRANDINTRODUCE2);
        
        
        String name=partybrandService.findIntroduceById(pd);  //获取需要删除的附件名称
        if(name!=null && name!=""){
		String path = "C:\\tomcat\\webapps\\FHMYSQL\\uploadFiles\\file\\";
		File file = new File(path+ File.separator + name);
		if (file.exists()) {
		    file.delete();
		}
        }
        
        
        if(BRANDINTRODUCE1!=null && originalFilename!=null && originalFilename.length()>0){
        	String pic_path = "C:\\tomcat\\webapps\\FHMYSQL\\uploadFiles\\file\\";
        	File newFile = new File(pic_path+originalFilename);
        	BRANDINTRODUCE1.transferTo(newFile);
        }
        
		pd.put("BRANDINTRODUCE",BRANDINTRODUCE);	//提交页面显示的名称
		pd.put("BRANDINTRODUCE2", BRANDINTRODUCE2); //提交文档真实名称
		
		
        	partybrandService.editIntroduce(pd);
        	mv.addObject("msg","success");
    		mv.setViewName("save_result");
    		return mv;
	}
	
	@RequestMapping(value="/nameSelect")
	public ModelAndView nameSelect(String field4)throws Exception{
		logBefore(logger, "列表PartyBrand");
		ModelAndView mv = this.getModelAndView();
		try{
			List<PageData>	varList = partybrandService.NameSelectMapper(field4);	//列出PartyBrand列表
			mv.setViewName("PartyBuilding/partybrand/partybrand_list");
			mv.addObject("varList", varList);
			mv.addObject("field4", field4);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 取消上传
	 */
	@RequestMapping(value="/giveUpupload")
	public ModelAndView giveUpupload()throws Exception{
		logBefore(logger, "取消文件上传");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "giveUpupload")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
        mv.addObject("msg","success");
    	mv.setViewName("save_result");
   		return mv;
	}
	
	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

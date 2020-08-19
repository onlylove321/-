package com.fh.controller.PartyBuilding.PartyActivities;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.PartyBuilding.tool.ImageUploadUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.PartyBuilding.partyactivities.PartyActivitiesService;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;


/** 
 * 类名称：PartyActivitiesController
 * 创建人：FH 
 * 创建时间：2018-05-03
 */
@Controller
@RequestMapping(value="/partyactivities")
public class PartyActivitiesController extends BaseController {
	
	String menuUrl = "partyactivities/list.do"; //菜单地址(权限用)
	@Resource(name="partyactivitiesService")
	private PartyActivitiesService partyactivitiesService;
	
	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增PartyActivities");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PARTYACTIVITIES_ID", this.get32UUID());	//主键
		pd.put("SUBMISSIONTIME", Tools.date2Str(new Date()));	//提交时间
		partyactivitiesService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除PartyActivities");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			partyactivitiesService.delete(pd);
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
		logBefore(logger, "修改PartyActivities");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		partyactivitiesService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表PartyActivities");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			List<PageData>	varList = partyactivitiesService.list(page);	//列出PartyActivities列表
			mv.setViewName("PartyBuilding/partyactivities/partyactivities_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去统计页面
	 * @throws Exception 
	 */
	@RequestMapping(value="/goStatistical")
	public ModelAndView goStatistical(int summaryTime,HttpServletRequest request) throws Exception{
		logBefore(logger, "去新增PartyActivities页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	varList = new ArrayList<PageData>();
		if(summaryTime!=0){
		String bigsummaryTime =(summaryTime+1)+"";          //将获取的时间+1，并转换为string类型
		String lowsummaryTime=(summaryTime)+"";             //将获取的时间-1，并转换为string类型
		pd.put("bigsummaryTime", bigsummaryTime);           //保存数据
		pd.put("lowsummaryTime", lowsummaryTime);
		varList = partyactivitiesService.StatisticalSummary(pd);
		}
		else{
		varList = partyactivitiesService.StatisticalSummaryAll(pd);
		}
		long catagory1sum = 0;
		long catagory2sum = 0;
		long catagory3sum = 0;
		long catagory4sum = 0;
		long catagory5sum = 0;
		long catagory6sum = 0;
		long catagory7sum = 0;
		for(int j=0;j<varList.size();j++){
			PageData a = varList.get(j);
			String category=a.getString("ACTIVITIESCATEGORY");
			switch(category){
			case "三会一课" :
				catagory1sum= (long) a.get("sum");
				System.out.println(catagory1sum);
				break;
			case "党日活动" :
				catagory2sum=(long) a.get("sum");
				break;
			case "在职党员进社区" :
				catagory3sum=(long) a.get("sum");
				break;
			case "两代表一委员活动" :
				catagory4sum=(long) a.get("sum");
				break;
			case "组织生活会" :
				catagory5sum=(long) a.get("sum");
				break;
			case "民主评议党员" :
				catagory6sum=(long) a.get("sum");
				break;
			case "其它" :
				catagory7sum=(long) a.get("sum");
				break;
			}	
		}
		request.setAttribute("summaryTime", summaryTime);
		request.setAttribute("catagory1sum", catagory1sum);
		request.setAttribute("catagory2sum", catagory2sum);
		request.setAttribute("catagory3sum", catagory3sum);
		request.setAttribute("catagory4sum", catagory4sum);
		request.setAttribute("catagory5sum", catagory5sum);
		request.setAttribute("catagory6sum", catagory6sum);
		request.setAttribute("catagory7sum", catagory7sum);
		try {
			mv.setViewName("PartyBuilding/partyactivities/partyactivities_StatisticalSummary");
			mv.addObject("msg", "StatisticalClose");
			mv.addObject("pd", pd);
			mv.addObject("varList",varList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}
	
	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增PartyActivities页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("PartyBuilding/partyactivities/partyactivities_edit");
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
		logBefore(logger, "去修改PartyActivities页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = partyactivitiesService.findById(pd);	//根据ID读取
			mv.setViewName("PartyBuilding/partyactivities/partyactivities_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去跳转到活动内容详情页面
	 */
	@RequestMapping(value="/goSkip")
	public ModelAndView goSkip()throws Exception{
		logBefore(logger, "查看PartyActivities");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "goSkip")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String redouction=partyactivitiesService.goskip(pd);
		mv.setViewName("PartyBuilding/partyactivities/partyactivities_look");
		mv.addObject("msg3",redouction);
		return mv;
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除PartyActivities");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				partyactivitiesService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, "导出PartyActivities到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("活动名称");	//1
			titles.add("活动类别");	//2
			titles.add("活动时间");	//3
			titles.add("活动发布人");	//4
			titles.add("活动内容");	//5
			titles.add("当前登录用户");	//6
			titles.add("提交时间");	//7
			dataMap.put("titles", titles);
			List<PageData> varOList = partyactivitiesService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i<varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("ACTIVITIESNAME"));	//1
				vpd.put("var2", varOList.get(i).getString("ACTIVITIESCATEGORY"));	//2
				vpd.put("var3", varOList.get(i).getString("ACTIVITIESTIME"));	//3
				vpd.put("var4", varOList.get(i).getString("ACTIVITIESISSUER"));	//4
				vpd.put("var5", varOList.get(i).getString("ACTIVITIESCONTENT"));	//5
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
	
	@RequestMapping(value="/nameSelect")
	public ModelAndView nameSelect(String field3)throws Exception{
		logBefore(logger, "列表PartyActivities");
		ModelAndView mv = this.getModelAndView();
		try{
			List<PageData>	varList = partyactivitiesService.NameSelectMapper(field3);	//列出PartyOrganization列表
			mv.setViewName("PartyBuilding/partyactivities/partyactivities_list");
			mv.addObject("varList", varList);
			mv.addObject("field3", field3);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/*
	 * ckeditor上传图片action
	 * @return
	 */
	@RequestMapping(value="/imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response) {
	    String DirectoryName="uploadFiles/uploadImgs/";
	    try {
	        ImageUploadUtil.ckeditor(request,response,DirectoryName);
	    } catch (IllegalStateException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
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

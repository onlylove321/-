package com.fh.controller.Gridding;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.Gradding.GriddingIntroduceService;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;

/** 
 * 类名称：GriddingIntroduceController
 * 创建人：FH 
 * 创建时间：2018-05-10
 */
@Controller
@RequestMapping(value="/griddingintroduce")
public class GriddingIntroduceController extends BaseController {
	
	String menuUrl = "griddingintroduce/list.do"; //菜单地址(权限用)
	@Resource(name="griddingintroduceService")
	private GriddingIntroduceService griddingintroduceService;
	
	/**
	 * 页面加载
	 */
	@RequestMapping(value="/list")
	public ModelAndView list() throws Exception{
		logBefore(logger, "页面加载");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "list")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("griddingintroduce/griddingintroduce_list");
		return mv;
	}
	

	
	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改GriddingIntroduce");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		griddingintroduceService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改GriddingIntroduce页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = griddingintroduceService.findById(pd);	//根据ID读取
			mv.setViewName("griddingintroduce/griddingintroduce_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	
	
	/**
	 * 去跳转到属性内容
	 */
	@RequestMapping(value="/golookContent")
	public ModelAndView golookContent(int num)throws Exception{
		logBefore(logger, "查看GriddingContent");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "golookContent")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		StringBuffer grid = new StringBuffer();
		switch(num){
		case 1:
			grid.append("网格化工作流程");
			break;
		case 2:
			grid.append("网格化职责");
			break;
		case 3:
			grid.append("网格化概念");
			break;
		case 4:
			grid.append("网格化意义");
			break;
		case 5:
			grid.append("网格化制度");
			break;
		}
		String GRIDDINGNAME = grid.toString();
		pd.put("GRIDDINGNAME",GRIDDINGNAME);
		String content = griddingintroduceService.findByName(pd);
		mv.setViewName("griddingintroduce/griddingintroduce_look");
		mv.addObject("msg2",content);
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

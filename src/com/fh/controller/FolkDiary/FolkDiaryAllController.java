package com.fh.controller.FolkDiary;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.PartyBuilding.tool.ImageUploadUtil;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.service.FolkDiary.FolkDiaryService;
import com.fh.util.Const;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;


/** 
 * 类名称：FolkDiaryController
 * 创建人：FH 
 * 创建时间：2018-05-08
 */
@Controller
@RequestMapping(value="/folkdiary")
public class FolkDiaryAllController extends BaseController {
	
	String menuUrl = "folkdiary/listAll.do"; //菜单地址(权限用)
	@Resource(name="folkdiaryService")
	private FolkDiaryService folkdiaryService;
	
	/**
	 * 列表
	 */
	@RequestMapping(value="/listAll")
	public ModelAndView list(Page page,String field1,String lastLoginStart,String lastLoginEnd){
		logBefore(logger, "列表FolkDiary");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);
			pd.put("name", field1);
			pd.put("lastLoginStart", lastLoginStart);
			pd.put("lastLoginEnd", lastLoginEnd);
			List<PageData>	varList = folkdiaryService.list(page);	//列出FolkDiary列表
			mv.setViewName("folkDiary/folkdiary_listAll");
			mv.addObject("varList", varList);
			mv.addObject("field1", field1);
			mv.addObject("lastLoginStart", lastLoginStart);
			mv.addObject("lastLoginEnd", lastLoginEnd);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 去跳转到日记内容
	 */
	@RequestMapping(value="/golookContent")
	public ModelAndView goSkip()throws Exception{
		logBefore(logger, "查看FolkDiaryContent");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "golookContent")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String redouction=folkdiaryService.findByPdId(pd);
		mv.setViewName("folkDiary/folkdiary_lookDiary");
		mv.addObject("msg2",redouction);
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

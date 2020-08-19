package com.fh.controller.PartyBuilding.PartyMember;

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
import com.fh.entity.system.User;
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.basemessage.house.HouseService;
import com.fh.service.basemessage.population.PopulationService;
import com.fh.service.dictionaries.floor.FloorService;
import com.fh.service.dictionaries.sqmanager.SqmanagerService;

/**
 * 类名称：PopulationController 创建人：FH 创建时间：2018-05-02
 */
@Controller
@RequestMapping(value = "/PartyMember")
public class PartyMemberController extends BaseController {

  String menuUrl = "PartyMember/list.do"; // 菜单地址(权限用)
  @Resource(name = "populationService")
  private PopulationService populationService;
  @Resource(name = "floorService")
  private FloorService floorService;
  @Resource(name = "sqmanagerService")
  private SqmanagerService sqmanagerService;
  @Resource(name = "houseService")
  private HouseService houseService;
 

  /**
   * 修改
   */
  @RequestMapping(value = "/edit")
  public ModelAndView edit() throws Exception {
    logBefore(logger, "修改partyMember");
    if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
      return null;
    } // 校验权限
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    populationService.edit(pd);
    mv.addObject("msg", "success");
    mv.setViewName("save_result");
    return mv;
  }
  
  /**
   * 列表
   */
  @RequestMapping(value = "/list")
  public ModelAndView list(Page page,String KEYWORD) {
    logBefore(logger, "列表partyMember");
    // if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      page.setPd(pd);
		Subject currentUser = SecurityUtils.getSubject();
	    Session session = currentUser.getSession();
	    session.setAttribute("Member", KEYWORD);
      List<PageData> varList = populationService.listMember(page); // 列出Population列表
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
      mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
      mv.setViewName("PartyBuilding/partyMessage/partyMessage_list");
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return mv;
  }

  /**
   * 去修改页面
   */
  @RequestMapping(value = "/goEdit")
  public ModelAndView goEdit() {
    logBefore(logger, "去修改partyMember页面");
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    try {
      pd = populationService.findById(pd); // 根据ID读取
      String SPECIALCROWD=pd.getString("SPECIALCROWD");
      String[] strs=SPECIALCROWD.split(",");
      for(int i=0;i<strs.length;i++) {
        switch(strs[i]) {
        case "孤儿":pd.put("SPECIALCROWD1", 1);break;
        case "残疾":pd.put("SPECIALCROWD2", 1);break;
        case "精神病":pd.put("SPECIALCROWD3", 1);break;
        case "刑释解教":pd.put("SPECIALCROWD4", 1);break;
        case "社区矫正":pd.put("SPECIALCROWD5", 1);break;
        case "信访重点人":pd.put("SPECIALCROWD6", 1);break;
        case "服刑人员":pd.put("SPECIALCROWD7", 1);break;
        case "吸毒人员":pd.put("SPECIALCROWD8", 1);break;
        }
      }
      List<PageData>    gridList = sqmanagerService.listAll(pd);    //列出网格列表
      List<PageData>    floorList = floorService.listAll(pd);  //列出Floor列表
      List<PageData>    houseList = houseService.listAll(pd);  //列出House列表
      mv.addObject("houseList", houseList);
      mv.addObject("floorList", floorList);
      mv.addObject("gridList", gridList);
      mv.setViewName("PartyBuilding/partyMessage/partyMessage_edit");
      mv.addObject("msg", "edit");
      mv.addObject("pd", pd);
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return mv;
  }

  /*
   * 导出到excel
   * 
   * @return
   */
  @RequestMapping(value = "/excel")
  public ModelAndView exportExcel() {
    logBefore(logger, "导出PartyMember到excel");
    if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
      return null;
    }
    ModelAndView mv = new ModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    Subject currentUser = SecurityUtils.getSubject();
    Session session = currentUser.getSession();
    pd.put("KEYWORD", session.getAttribute("Member"));
    try {
      Map<String, Object> dataMap = new HashMap<String, Object>();
      List<String> titles = new ArrayList<String>();
      titles.add("姓名"); // 1
      titles.add("性别"); // 2
      titles.add("民族"); // 3
      titles.add("身份证号"); // 4
      titles.add("出生日期"); // 5
      titles.add("文化程度"); // 6
      titles.add("政治面貌"); // 7
      titles.add("入党时间"); // 8
      titles.add("健康状况"); // 9
      titles.add("两代表一委员"); // 10
      titles.add("与户主关系"); // 11
      titles.add("婚姻状况"); // 12
      titles.add("联系电话"); // 13
      titles.add("工作单位"); // 14
      titles.add("工资"); // 15
      titles.add("户口类别"); // 16
      titles.add("原居住地"); // 17
      titles.add("户籍所在地"); // 18
      titles.add("志愿者"); // 19
      titles.add("兵役状况"); // 20
      titles.add("统战对象"); // 21
      titles.add("社保编号"); // 22
      titles.add("退休时间"); // 23
      titles.add("领取退休金金额"); // 24
      titles.add("养老保险参保情况"); // 25
      titles.add("参保时间"); // 26
      titles.add("参保金额"); // 27
      titles.add("领取养老金时间"); // 28
      titles.add("领取养老金额"); // 29
      titles.add("医疗保险参保情况"); // 30
      titles.add("投保时间"); // 31
      titles.add("医保卡号"); // 32
      titles.add("缴纳金额"); // 33
      titles.add("低保类型"); // 34
      titles.add("低保金"); // 35
      titles.add("特殊人群"); // 36
      titles.add("网格名称"); // 37
      titles.add("楼号名称"); // 38
      titles.add("房屋名称"); // 39
      dataMap.put("titles", titles);
      List<PageData> varOList = populationService.listAllMember(pd);
      List<PageData> varList = new ArrayList<PageData>();
      for (int i = 0; i < varOList.size(); i++) {
        PageData vpd = new PageData();
        vpd.put("var1", varOList.get(i).getString("NAME")); // 1
        vpd.put("var2", varOList.get(i).getString("SEX")); // 2
        vpd.put("var3", varOList.get(i).getString("NATION")); // 3
        vpd.put("var4", varOList.get(i).getString("CARDID")); // 4
        vpd.put("var5", varOList.get(i).getString("BIRTHDAY")); // 5
        vpd.put("var6", varOList.get(i).getString("EDUDEGREE")); // 6
        vpd.put("var7", varOList.get(i).getString("POLITICAL")); // 7
        vpd.put("var8", varOList.get(i).getString("JOINPARTYDATE")); // 8
        vpd.put("var9", varOList.get(i).getString("HEALTH")); // 9
        vpd.put("var10", varOList.get(i).getString("ISREPRESENTATIVE")); // 10
        vpd.put("var11", varOList.get(i).getString("RELATIONSHIP")); // 11
        vpd.put("var12", varOList.get(i).getString("MERRIAGESTATUS")); // 12
        vpd.put("var13", varOList.get(i).getString("TEL")); // 13
        vpd.put("var14", varOList.get(i).getString("WORKUNIT")); // 14
        vpd.put("var15", varOList.get(i).getString("SALARY")); // 15
        vpd.put("var16", varOList.get(i).getString("HOUSEHOLDTYPE")); // 16
        vpd.put("var17", varOList.get(i).getString("NATIVEHABITAT")); // 17
        vpd.put("var18", varOList.get(i).getString("HOUSEHOLDREGISTER")); // 18
        vpd.put("var19", varOList.get(i).getString("ISVOLUNTEER")); // 19
        vpd.put("var20", varOList.get(i).getString("MILITARYSERVICE")); // 20
        vpd.put("var21", varOList.get(i).getString("UNITEDFRONT")); // 21
        vpd.put("var22", varOList.get(i).getString("SOCIALSECURITYCODE")); // 22
        vpd.put("var23", varOList.get(i).getString("RETIREDATE")); // 23
        vpd.put("var24", varOList.get(i).getString("PENSION")); // 24
        vpd.put("var25", varOList.get(i).getString("PARTICIPATION")); // 25
        vpd.put("var26", varOList.get(i).getString("INSUREDDATE")); // 26
        vpd.put("var27", varOList.get(i).getString("INSUREDAMOUNT")); // 27
        vpd.put("var28", varOList.get(i).getString("RECEIVEDATE")); // 28
        vpd.put("var29", varOList.get(i).getString("RECEIVEAMOUNT")); // 29
        vpd.put("var30", varOList.get(i).getString("MEDICALINSURANCE")); // 30
        vpd.put("var31", varOList.get(i).getString("MEDICALINSURANCEDATE")); // 31
        vpd.put("var32", varOList.get(i).getString("MEDICALINSURANCEID")); // 32
        vpd.put("var33", varOList.get(i).getString("MEDICALINSURANCEAMOUNT")); // 33
        vpd.put("var34", varOList.get(i).getString("BASICLIVING")); // 34
        vpd.put("var35", varOList.get(i).getString("BASICLIVINGAMOUNT")); // 35
        vpd.put("var36", varOList.get(i).getString("SPECIALCROWD")); // 36
        vpd.put("var37", varOList.get(i).getString("GRIDNAME")); // 37
        vpd.put("var38", varOList.get(i).getString("FLOORNAME")); // 38
        vpd.put("var39", varOList.get(i).getString("HOUSENAME")); // 39
        varList.add(vpd);
      }
      dataMap.put("varList", varList);
      ObjectExcelView erv = new ObjectExcelView();
      mv = new ModelAndView(erv, dataMap);
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return mv;
  }

  /* ===============================权限================================== */
  public Map<String, String> getHC() {
    Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
    Session session = currentUser.getSession();
    return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
  }
  /* ===============================权限================================== */

  @InitBinder
  public void initBinder(WebDataBinder binder) {
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
  }

}

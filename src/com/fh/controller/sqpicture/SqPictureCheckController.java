package com.fh.controller.sqpicture;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
import com.fh.service.basemessage.house.HouseService;
import com.fh.service.basemessage.population.PopulationService;
import com.fh.service.basemessage.unitmessage.UnitmessageService;
import com.fh.service.dictionaries.floor.FloorService;
import com.fh.service.dictionaries.sqmanager.SqmanagerService;
import com.fh.service.sqpicture.PictureService;
import com.fh.service.system.menu.MenuService;
import com.fh.service.system.role.RoleService;
import com.fh.service.system.hkd.HkdService;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileDownload;
import com.fh.util.FileUpload;
import com.fh.util.GetPinyin;
import com.fh.util.Jurisdiction;
import com.fh.util.ObjectExcelRead;
import com.fh.util.PageData;
import com.fh.util.PageDataaArray;
import com.fh.util.ObjectExcelView;
import com.fh.util.PathUtil;
import com.fh.util.Tools;

import net.sf.json.JSONArray;

/**
 * 类名称：HkdController 创建人：FH 创建时间：2014年6月28日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/sqpicturecheck")
public class SqPictureCheckController extends BaseController {

  String menuUrl = "sqpicturecheck/picture.do"; // 菜单地址(权限用)
  @Resource(name = "sqmanagerService")
  private SqmanagerService sqmanagerService;
  @Resource(name = "floorService")
  private FloorService floorService;
  @Resource(name = "pictureService")
  private PictureService pictureService;
  @Resource(name = "houseService")
  private HouseService houseService;
  @Resource(name = "populationService")
  private PopulationService populationService;
  @Resource(name = "unitmessageService")
  private UnitmessageService unitmessageService;
  /**
   * 去修改用户页面
   */
  @RequestMapping(value = "/picture")
  public ModelAndView picture() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    List<PageData> hotList = pictureService.listAll(pd); // 列出热区列表
    mv.setViewName("sqpicture/picture/picture_check");
    mv.addObject("pd", pd);
    mv.addObject("hotList", hotList);
    return mv;
  }

  /**
   * 列表
   */
  @RequestMapping(value = "/goCheck")
  public ModelAndView goCheck(Page page) {
    logBefore(logger, "列表");
    // if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    try {
      pd = this.getPageData();
      String linkId=pd.getString("linkId");
      String type=pd.getString("type");
      if("0".equals(type)) {
        pd.put("GRIDID", linkId);
      }else {
        pd.put("FLOORID", linkId);
      }
      page.setPd(pd);
      String status=pd.getString("status");
      List<PageData> varList = new ArrayList<>();
      if("1".equals(status)) {
        varList = populationService.list(page); 
        mv.setViewName("sqpicture/picture/population_list");
      }else if("2".equals(status)) {
        varList = unitmessageService.list(page); 
        mv.setViewName("sqpicture/picture/unitmessage_list");
      }else {
      
       varList = houseService.list(page); // 列出House列表
      mv.setViewName("sqpicture/picture/house_list");
      }
      mv.addObject("varList", varList);
      mv.addObject("pd", pd);
      mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    return mv;
  }
  @InitBinder
  public void initBinder(WebDataBinder binder) {
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
  }

  /* ===============================权限================================== */
  public Map<String, String> getHC() {
    Subject currentHkd = SecurityUtils.getSubject(); // shiro管理的session
    Session session = currentHkd.getSession();
    return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
  }
  /* ===============================权限================================== */
}

package com.fh.controller.sqpicture;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.system.Role;
import com.fh.entity.system.User;
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
import com.fh.util.PageData;
import com.fh.util.PageDataaArray;
import com.fh.util.ObjectExcelView;
import com.fh.util.PathUtil;

import net.sf.json.JSONArray;


/**
 * 类名称：HkdController 创建人：FH 创建时间：2014年6月28日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/sqpicture")
public class SqPictureController extends BaseController {

  String menuUrl = "sqpicture/picture.do"; // 菜单地址(权限用)
  @Resource(name = "sqmanagerService")
  private SqmanagerService sqmanagerService;
  @Resource(name = "floorService")
  private FloorService floorService;
  @Resource(name = "pictureService")
  private PictureService pictureService;

  /**
   * 新增
   */
  @RequestMapping(value = "/save")
  public ModelAndView save() throws Exception {
    logBefore(logger, "保存热区");
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    PageDataaArray pda = new PageDataaArray();
    pda = this.getPageDataaArray();
    Object[] strs = pda.getStringArr("linkId");
    int len =0;
    if(strs[0]!=null) {
     len = strs.length;// 获取mId长度
    }
    Subject currentUser = SecurityUtils.getSubject();
    Session session = currentUser.getSession();
    User user = (User) session.getAttribute(Const.SESSION_USER);
    pd.put("CREATOR", user.getUSERNAME()); // 获取当前操作人
    pd.put("CREATDATE", DateUtil.getTime().toString()); // 获取日期
    pd.put("IPADDRESS", user.getIP()); // IP地址

    for (int i = 0; i < len; i++) {
      pd.put("pictureId", this.get32UUID()); //主键
      pd.put("typeName", pda.getStringArr("typeName")[i]);
      pd.put("type", pda.getStringArr("type")[i]);
      pd.put("linkName", pda.getStringArr("linkName")[i]);
      pd.put("linkId", pda.getStringArr("linkId")[i]);
      pd.put("areaMapInfo", pda.getStringArr("areaMapInfo")[i]);
      pictureService.save(pd);
    }
    mv.addObject("msg", "success");
    mv.setViewName("save_result");
    return new ModelAndView("redirect:/sqpicture/picture");
  }

  /**
   * 去修改用户页面
   */
  @RequestMapping(value = "/picture")
  public ModelAndView picture() throws Exception {
    ModelAndView mv = this.getModelAndView();
    PageData pd = new PageData();
    pd = this.getPageData();
    List<PageData> hotList = pictureService.listAll(pd); // 列出热区列表
    List<PageData> gridList = sqmanagerService.nameList(pd); // 列出Sqmanager列表
    List<PageData> floorList = floorService.nameList(pd); // 列出楼列表
    pd.put("hotList", JSONArray.fromObject(hotList).toString());
    pd.put("gridList", JSONArray.fromObject(gridList));
    pd.put("floorList", JSONArray.fromObject(floorList));
    mv.setViewName("sqpicture/picture/picture");
    mv.addObject("pd", pd);

    return mv;
  }

  /**
   * 打开上传地图页面
   */
  @RequestMapping(value = "/goUpload")
  public ModelAndView goUploadExcel() throws Exception {
      ModelAndView mv = this.getModelAndView();
      mv.setViewName("sqpicture/picture/upload");
      return mv;
  }
  /**
   * 上传图片
   */
  @RequestMapping(value = "/uploadPicture")
  public ModelAndView uploadPicture(@RequestParam("image_file")MultipartFile file,HttpServletRequest request) throws Exception {
      ModelAndView mv = this.getModelAndView();
      
      /*---------------------------------eidt by zhangmiao-----------------------------------------*/
//    String path=request.getSession().getServletContext().getRealPath("uploadFiles/uploadImgs/");
      String path = PathUtil.getClasspath() + "static/img/";
      System.out.println(path);
//    String fileName = file.getOriginalFilename();  
              String fileName = "sq001.jpg"; 
              File targetFile = new File(path, fileName);  
               if(!targetFile.exists()){  
                   targetFile.mkdirs();  
               }  
       try {  
           file.transferTo(targetFile);  
          } catch (Exception e) {  
                  e.printStackTrace();  
       }  
      
      mv.addObject("msg", "success");
      mv.setViewName("save_result");
      return mv;
  }
  
 

  /**
   * 根据类型获取列表 type为0，获取网格列表 type为1，获取楼号列表
   */
  @RequestMapping(value = "/getList")
  @ResponseBody
  public Object getList() {
    Map<String, List<PageData>> map = new HashMap<String, List<PageData>>();
    PageData pd = new PageData();
    List<PageData> varList = new ArrayList<>();
    try {
      pd = this.getPageData();
      String type = pd.getString("type");
      if ("0".equals(type)) {
        varList = sqmanagerService.listAll(pd); // 列出Sqmanager列表
      } else {
        varList = floorService.listAll(pd); // 列出楼列表
      }
    } catch (Exception e) {
      logger.error(e.toString(), e);
    }
    JSONArray arr = JSONArray.fromObject(varList);
    map.put("varList", arr); // 返回结果
    return AppUtil.returnObject(new PageData(), map);
  }
  /**
   * 删除
   */
  @RequestMapping(value="/delete")
  public void delete(PrintWriter out){
      logBefore(logger, "删除");
      if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
      PageData pd = new PageData();
      try{
          pd = this.getPageData();
          pictureService.delete(pd);
          out.write("success");
          out.close();
      } catch(Exception e){
          logger.error(e.toString(), e);
      }
      
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

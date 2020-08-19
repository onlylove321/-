package com.fh;

import static org.junit.Assert.*;

import org.junit.Before;  
import org.junit.Test;  
import org.springframework.context.ApplicationContext;  
import org.springframework.context.support.ClassPathXmlApplicationContext;  

import com.fh.service.basemessage.unitmessage.UnitmessageService;
import com.fh.util.PageData;

public class UnitmessageText {  
    private ApplicationContext as = null;  
    private UnitmessageService unitMessageService = null;  
    PageData pd = new PageData();
    @Before  
    public void init(){
        as = new ClassPathXmlApplicationContext(new String[] {  
                "ApplicationContext.xml"});  
        unitMessageService = (UnitmessageService) as.getBean("UnitmessageService");     
    }  
  
    @Test  
    public void deleteAllunit() throws Exception {
    	String DATA_IDS = pd.getString("DATA_IDS");
    	String ArrayDATA_IDS[] = DATA_IDS.split(",");
    	unitMessageService.deleteAll(ArrayDATA_IDS);
    }  
    
    @Test  
    public void editunit() throws Exception {
  	  pd.put("UNITMESSAGE_ID", "fdsf135"); // 主键
  	  pd.put("CREATOR", "王五"); // 创建人
  	  unitMessageService.edit(pd);
    }
    
    @Test  
    public void deleteunit() throws Exception {  
        pd.put("UNITMESSAGE_ID", "fdsf135"); // 主键
    	unitMessageService.delete(pd);
    } 
    
    
    @Test  
    public void listunit() throws Exception {  
    	unitMessageService.listAll(pd);
    } 
    
    @Test  
    public void saveunit() throws Exception {  
    	 pd.put("UNITMESSAGE_ID", "fdsf135"); // 主键
    	 pd.put("CREATOR", "李四"); // 创建人
    	 pd.put("CREATEDATE", "20180526"); // 创建日期
    	 unitMessageService.save(pd);
    } 
    @Test  
    public void findunit() throws Exception {  
    	 pd.put("UNITMESSAGE_ID", "fdsf135"); // 主键
    	 unitMessageService.findById(pd);
    } 
}  

    
   
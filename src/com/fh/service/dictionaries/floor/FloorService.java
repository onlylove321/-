package com.fh.service.dictionaries.floor;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("floorService")
public class FloorService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("FloorMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("FloorMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("FloorMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("FloorMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FloorMapper.listAll", pd);
	}
	
	
	/*
	*新增、编辑人口信息下拉框使用列表(全部)
	*/
	public List<PageData> listAllInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("FloorMapper.listAllInfo", pd);
	}
	
	   /*
     *列表(全部)
     */
     public List<PageData> nameList(PageData pd)throws Exception{
         return (List<PageData>)dao.findForList("FloorMapper.nameList", pd);
     }
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("FloorMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("FloorMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


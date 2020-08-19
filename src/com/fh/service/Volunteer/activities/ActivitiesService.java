package com.fh.service.Volunteer.activities;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("activitiesService")
public class ActivitiesService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("ActivitiesMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("ActivitiesMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("ActivitiesMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ActivitiesMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ActivitiesMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ActivitiesMapper.findById", pd);
	}
	
	/*
	* 通过活动名称进行模糊查询
	*/
	public List<PageData> ActivitiesSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("ActivitiesMapper.ActivitiesSelectMapper", name);
	}
	
	/*
	* 通过志愿者队伍进行模糊查询
	*/
	public List<PageData> VolunteerSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("ActivitiesMapper.VolunteerSelectMapper", name);
	}
	
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ActivitiesMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


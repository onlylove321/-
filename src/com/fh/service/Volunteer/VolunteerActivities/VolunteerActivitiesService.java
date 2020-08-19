package com.fh.service.Volunteer.VolunteerActivities;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("volunteeractivitiesService")
public class VolunteerActivitiesService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("VolunteerActivitiesMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("VolunteerActivitiesMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("VolunteerActivitiesMapper.edit", pd);
	}
	
	/*
	* 查看活动内容
	*/
	public String findByPdId(PageData pd)throws Exception{
		return (String) dao.findForObject("VolunteerActivitiesMapper.findByPdId",pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerActivitiesMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerActivitiesMapper.listAll", pd);
	}
	
	/*
	*队伍名称列表(全部)
	*/
	public List<PageData> listAllInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerActivitiesMapper.listAllInfo", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VolunteerActivitiesMapper.findById", pd);
	}
	
	/*
	* 通过活动名称进行模糊查询
	*/
	public List<PageData> NameSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerActivitiesMapper.NameSelectMapper", name);
	}
	
	/*
	* 通过id查询其参与队伍
	*/
	public List<PageData> VolunteerSelectMapper(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerActivitiesMapper.VolunteerSelectMapper", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("VolunteerActivitiesMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


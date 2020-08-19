package com.fh.service.Volunteer.VolunteerTeam;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("volunteerteamService")
public class VolunteerTeamService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("VolunteerTeamMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("VolunteerTeamMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("VolunteerTeamMapper.edit", pd);
	}
	
	/*
	* 查看成员构成
	*/
	public String findByPdId(PageData pd)throws Exception{
		return (String) dao.findForObject("VolunteerTeamMapper.findByPdId",pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerTeamMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerTeamMapper.listAll", pd);
	}
	
	/*
	*队伍名称列表(全部)
	*/
	public List<PageData> listAllInfo(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerTeamMapper.listAllInfo", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("VolunteerTeamMapper.findById", pd);
	}
	
	/*
	* 通过队伍名称进行模糊查询
	*/
	public List<PageData> NameSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerTeamMapper.NameSelectMapper", name);
	}
	
	/*
	* 通过id查询其参与活动
	*/
	public List<PageData> ActivitiesSelectMapper(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("VolunteerTeamMapper.ActivitiesSelectMapper", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("VolunteerTeamMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


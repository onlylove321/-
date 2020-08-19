package com.fh.service.PartyBuilding.partyactivities;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("partyactivitiesService")
public class PartyActivitiesService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("PartyActivitiesMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("PartyActivitiesMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("PartyActivitiesMapper.edit", pd);
	}
	
	/*
	* 查看详细信息
	*/
	public String goskip(PageData pd)throws Exception{
		return (String) dao.findForObject("PartyActivitiesMapper.findByPdId",pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PartyActivitiesMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PartyActivitiesMapper.listAll", pd);
	}
	
	/*
	*统计汇总活动类别根据年份
	*/
	public List<PageData> StatisticalSummary(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PartyActivitiesMapper.StatisticalSummary", pd);
	}
	
	/*
	*统计汇总活动类别
	*/
	public List<PageData> StatisticalSummaryAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PartyActivitiesMapper.StatisticalSummaryAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PartyActivitiesMapper.findById", pd);
	}
	
	/*
	* 通过党务名称进行模糊查询
	*/
	public List<PageData> NameSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("PartyActivitiesMapper.NameSelectMapper", name);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PartyActivitiesMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


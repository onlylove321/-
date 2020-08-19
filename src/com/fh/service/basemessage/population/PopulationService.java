package com.fh.service.basemessage.population;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("populationService")
public class PopulationService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("PopulationMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("PopulationMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("PopulationMapper.edit", pd);
	}

	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.datalistPage", page);
	}
	
	/*
	*党员列表
	*/
	public List<PageData> listMember(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.dataMemberlistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.listAll", pd);
	}
	
	/*
	*党员列表(全部)
	*/
	public List<PageData> listAllMember(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.listAllMember", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PopulationMapper.findById", pd);
	}
	
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PopulationMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	*统计汇总性别
	*/
	public List<PageData> StatisticalSummarySex(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.StatisticalSummarySex", pd);
	}
	
	/*
	*统计汇总年龄
	*/
	public List<PageData> StatisticalSummaryOld(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.StatisticalSummaryOld", pd);
	}
	
	/*
	*统计汇总文化程度
	*/
	public List<PageData> StatisticalSummaryEducation(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.StatisticalSummaryEducation", pd);
	}
	
	/*
	*统计汇总政治面貌
	*/
	public List<PageData> StatisticalSummaryPolicy(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PopulationMapper.StatisticalSummaryPolicy", pd);
	}
	
}


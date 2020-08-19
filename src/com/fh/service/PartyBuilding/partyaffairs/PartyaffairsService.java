package com.fh.service.PartyBuilding.partyaffairs;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("partyaffairsService")
public class PartyaffairsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("PartyaffairsMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("PartyaffairsMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("PartyaffairsMapper.edit", pd);
	}
	
	/*
	* 查看详细信息
	*/
	public String goskip(PageData pd)throws Exception{
		return (String) dao.findForObject("PartyaffairsMapper.findByPdId",pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PartyaffairsMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PartyaffairsMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PartyaffairsMapper.findById", pd);
	}
	
	/*
	* 通过党务名称进行模糊查询
	*/
	public List<PageData> NameSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("PartyaffairsMapper.NameSelectMapper", name);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PartyaffairsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


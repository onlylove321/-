package com.fh.service.Gradding;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("griddingintroduceService")
public class GriddingIntroduceService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("GriddingIntroduceMapper.save", pd);
	}
	

	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("GriddingIntroduceMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("GriddingIntroduceMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("GriddingIntroduceMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("GriddingIntroduceMapper.findById", pd);
	}
	
	
	/*
	* 通过name获取内容详情
	*/
	public String findByName(PageData pd)throws Exception{
		return (String)dao.findForObject("GriddingIntroduceMapper.findByName", pd);
	}
	
}


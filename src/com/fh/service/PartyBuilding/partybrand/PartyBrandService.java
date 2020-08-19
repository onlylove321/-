package com.fh.service.PartyBuilding.partybrand;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("partybrandService")
public class PartyBrandService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("PartyBrandMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("PartyBrandMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("PartyBrandMapper.edit", pd);
	}
	
	/*
	* 修改党建附件名称
	*/
	public void editIntroduce(PageData pd)throws Exception{
		dao.update("PartyBrandMapper.editIntroduce", pd);
	}
	
	/*
	* 查看品牌链接
	*/
	public String findIntroduceById(PageData pd)throws Exception{
		return (String) dao.findForObject("PartyBrandMapper.findIntroduceById",pd);
	}
	
	/*
	* 查看品牌初始名称
	*/
	public String findOringalIntroduceById(PageData pd)throws Exception{
		return (String) dao.findForObject("PartyBrandMapper.findOringalIntroduceById",pd);
	}
	
	/*
	* 查看品牌备注
	*/
	public String findMaskById(PageData pd)throws Exception{
		return (String) dao.findForObject("PartyBrandMapper.findMaskById",pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("PartyBrandMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("PartyBrandMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("PartyBrandMapper.findById", pd);
	}
	
	/*
	* 通过品牌名称进行模糊查询
	*/
	public List<PageData> NameSelectMapper(String name)throws Exception{
		return (List<PageData>)dao.findForList("PartyBrandMapper.NameSelectMapper", name);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("PartyBrandMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


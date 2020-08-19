package com.fh.service.system.hkd;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.system.Hkd;
import com.fh.util.PageData;

@Service("hkdService")
public class HkdService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	// ======================================================================================

	/*
	 * 通过id获取数据
	 */
	public PageData findByUiId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("HkdXMapper.findByUiId", pd);
	}

	/*
	 * 通过loginname获取数据
	 */
	public PageData findByUId(PageData pd) throws Exception {
		return (PageData) dao.findForObject("HkdXMapper.findByUId", pd);
	}

	/*
	 * 通过邮箱获取数据
	 */
	public PageData findByUE(PageData pd) throws Exception {
		return (PageData) dao.findForObject("HkdXMapper.findByUE", pd);
	}

	/*
	 * 通过编号获取数据
	 */
	public PageData findByUN(PageData pd) throws Exception {
		return (PageData) dao.findForObject("HkdXMapper.findByUN", pd);
	}

	/*
	 * 保存用户
	 */
	public void saveU(PageData pd) throws Exception {
		dao.save("HkdXMapper.saveU", pd);
	}

	/*
	 * 修改用户
	 */
	public void editU(PageData pd) throws Exception {
		dao.update("HkdXMapper.editU", pd);
	}

	/*
	 * 换皮肤
	 */
	public void setSKIN(PageData pd) throws Exception {
		dao.update("HkdXMapper.setSKIN", pd);
	}

	/*
	 * 删除用户
	 */
	public void deleteU(PageData pd) throws Exception {
		dao.delete("HkdXMapper.deleteU", pd);
	}

	/*
	 * 批量删除用户
	 */
	public void deleteAllU(String[] USER_IDS) throws Exception {
		dao.delete("HkdXMapper.deleteAllU", USER_IDS);
	}

	/*
	 * 用户列表(用户组)
	 */
	public List<PageData> listPdPageHkd(Page page) throws Exception {
		return (List<PageData>) dao.findForList("HkdXMapper.hkdlistPage", page);
	}

	/*
	 * 用户列表(全部)
	 */
	public List<PageData> listAllHkd(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("HkdXMapper.listAllHkd", pd);
	}

	/*
	 * 用户列表(供应商用户)
	 */
	public List<PageData> listGPdPageHkd(Page page) throws Exception {
		return (List<PageData>) dao.findForList("HkdXMapper.hkdGlistPage", page);
	}

	/*
	 * 保存用户IP
	 */
	public void saveIP(PageData pd) throws Exception {
		dao.update("HkdXMapper.saveIP", pd);
	}

	/*
	 * 登录判断
	 */
	public PageData getHkdByNameAndPwd(PageData pd) throws Exception {
		return (PageData) dao.findForObject("HkdXMapper.getHkdInfo", pd);
	}

	/*
	 * 跟新登录时间
	 */
	public void updateLastLogin(PageData pd) throws Exception {
		dao.update("HkdXMapper.updateLastLogin", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public Hkd getHkdAndRoleById(String USER_ID) throws Exception {
		return (Hkd) dao.findForObject("HkdMapper.getHkdAndRoleById", USER_ID);
	}

}

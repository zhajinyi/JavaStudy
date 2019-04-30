package com.jee.ssm.base;

import com.github.pagehelper.PageHelper;

public class BaseEntity {
	
	private Integer id;//所有表的主键均为ID
	
	private PageHelper pageHelper;//添加分页信息

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public PageHelper getPageHelper() {
		return pageHelper;
	}

	public void setPageHelper(PageHelper pageHelper) {
		this.pageHelper = pageHelper;
	}
	
	
	
}

package com.ssh.action;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.opensymphony.xwork2.ActionSupport;
import com.ssh.pojo.Employee;
import com.ssh.service.EmployeeService;
@Controller
@Scope("prototype")
public class EmployeeAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	HttpServletRequest request;
	@Autowired
	EmployeeService employeeService;
	public String list(){
		return "list";
		
	}
	
	PageInfo<Employee> pageInfo;
	int pn;
	
	public int getPn() {
		return pn;
	}


	public void setPn(int pn) {
		this.pn = pn;
	}


	public PageInfo<Employee> getPageInfo() {
		return pageInfo;
	}


	public void setPageInfo(PageInfo<Employee> pageInfo) {
		this.pageInfo = pageInfo;
	}


	public String getEmps() {
		pn = Integer.parseInt(ServletActionContext.getRequest().getParameter("pn"));
		PageHelper.startPage(pn, 10);
		List<Employee> employees = employeeService.getAll();
		pageInfo = new PageInfo<Employee>(employees, 10);
		
		return "ajax";
	}

}

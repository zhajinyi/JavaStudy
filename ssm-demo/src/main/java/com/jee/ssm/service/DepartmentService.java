package com.jee.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jee.ssm.bean.Department;
import com.jee.ssm.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getparts() {
		
		List<Department> depts = departmentMapper.selectByExample(null);
		
		return depts;
		
	}
}

package com.zhajinyi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhajinyi.bean.Department;
import com.zhajinyi.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	DepartmentMapper departmentMapper;
	
	public List<Department> getparts() {
		
		List<Department> depts = departmentMapper.selectByExample(null);
		
		return depts;
		
	}
}

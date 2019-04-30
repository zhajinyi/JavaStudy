package com.ssh.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssh.dao.DepartmentDao;
import com.ssh.pojo.Department;
import com.ssh.service.DepartmentService;
@Service
public class DepartmentServiceImpl implements DepartmentService {
	
	@Autowired
	DepartmentDao departmentDao;

	@Override
	public boolean add(Department department) {
		// TODO Auto-generated method stub
		
		return departmentDao.add(department) > 0;
	}

	@Override
	public boolean update(Department department) {
		// TODO Auto-generated method stub
		return departmentDao.update(department) > 0;
	}

	@Override
	public boolean delete(Department department) {
		// TODO Auto-generated method stub
		return departmentDao.delete(department) > 0;
	}

	@Override
	public Department getByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return departmentDao.getByPrimaryKey(id);
	}

	@Override
	public List<Department> getAll() {
		// TODO Auto-generated method stub
		return departmentDao.getAll();
	}

	@Override
	public List<Department> getByTemplete(Department department) {
		// TODO Auto-generated method stub
		return departmentDao.getByTemplete(department);
	}

}

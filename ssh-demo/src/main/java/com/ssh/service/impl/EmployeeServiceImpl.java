package com.ssh.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ssh.dao.EmployeeDao;
import com.ssh.pojo.Employee;
import com.ssh.service.EmployeeService;
import com.ssh.utils.Msg;
@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	EmployeeDao employeeDao;

	@Override
	public Msg add(Employee employee) {
		// TODO Auto-generated method stub
		return employeeDao.add(employee)? Msg.success() : Msg.failure();
	}

	@Override
	public Msg update(Employee employee) {
		// TODO Auto-generated method stub
		return employeeDao.update(employee)? Msg.success() : Msg.failure();
	}

	@Override
	public Msg delete(Integer id) {
		// TODO Auto-generated method stub
		return employeeDao.delete(id)? Msg.success() : Msg.failure();
	}

	@Override
	public Employee getByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return employeeDao.getByPrimaryKey(id);
	}

	@Override
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeDao.getAll();
	}

	@Override
	public List<Employee> getByTemplete(Employee employee) {
		// TODO Auto-generated method stub
		return employeeDao.getByTemplete(employee);
	}

	

}

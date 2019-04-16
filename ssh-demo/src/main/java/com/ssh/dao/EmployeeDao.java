package com.ssh.dao;

import java.util.List;

import com.ssh.pojo.Employee;

public interface EmployeeDao {
	
	boolean add (Employee employee);
	
	boolean update (Employee employee);
	
	boolean delete (Integer id);
	
	Employee getByPrimaryKey (Integer id);
	
	List<Employee> getAll ();
	
	List<Employee> getByTemplete (Employee employee);

}

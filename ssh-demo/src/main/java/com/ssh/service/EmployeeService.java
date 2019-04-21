package com.ssh.service;

import java.util.List;

import com.ssh.pojo.Employee;
import com.ssh.utils.Msg;

public interface EmployeeService {
	Msg add (Employee employee);
	
	Msg update (Employee employee);
	
	Msg delete (Integer id);
	
	Employee getByPrimaryKey (Integer id);
	
	List<Employee> getAll ();
	
	List<Employee> getByTemplete (Employee employee);

}

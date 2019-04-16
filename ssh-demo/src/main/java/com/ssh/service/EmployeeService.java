package com.ssh.service;

import com.ssh.pojo.Employee;
import com.ssh.utils.Msg;

public interface EmployeeService {
	Msg add (Employee employee);
	
	Msg update (Employee employee);
	
	Msg delete (Integer id);
	
	Msg getByPrimaryKey (Integer id);
	
	Msg getAll ();
	
	Msg getByTemplete (Employee employee);

}

package com.ssh.service;

import java.util.List;

import com.ssh.pojo.Department;

public interface DepartmentService {
	
	boolean add (Department department);
	
	boolean update (Department department);
	
	boolean delete (Department department);
	
	Department getByPrimaryKey (Integer id);
	
	List<Department> getAll ();
	
	List<Department> getByTemplete (Department department);
}

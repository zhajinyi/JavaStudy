package com.ssh.dao;

import java.util.List;

import com.ssh.pojo.Department;

public interface DepartmentDao {
	
	int add (Department department);
	
	int update (Department department);
	
	int delete (Department department);
	
	Department getByPrimaryKey (Integer id);
	
	List<Department> getAll ();
	
	List<Department> getByTemplete (Department department);

}

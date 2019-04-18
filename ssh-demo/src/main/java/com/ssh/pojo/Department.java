package com.ssh.pojo;

import java.util.Set;

public class Department {
	
	private Integer id;
	
	private String name;
	
	public Department(Integer id) {
		this.id = id;
	}
	
	public Department() {
		
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

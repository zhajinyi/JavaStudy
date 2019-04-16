package com.ssh.pojo;

import java.util.Date;

public class Employee {
	
	private Integer id;//工号
	
	private String name;//姓名
	
	private int sex;//0为男,1为女;
	
	private String eMail;//邮箱
	
	private Date birthDate;//生日
	
	private Department department;//部门

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

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String geteMail() {
		return eMail;
	}

	public void seteMail(String eMail) {
		this.eMail = eMail;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", name=" + name + ", sex=" + sex + ", eMail=" + eMail + ", birthDate="
				+ birthDate + ", department=" + department + "]";
	}
	
	

}

package com.jee.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jee.ssm.bean.Department;
import com.jee.ssm.bean.Msg;
import com.jee.ssm.service.DepartmentService;


@Controller
public class DepertmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping("/getdepts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> depts = departmentService.getparts();
		
		
		return Msg.success().add("depts", depts);
		
	} 

}

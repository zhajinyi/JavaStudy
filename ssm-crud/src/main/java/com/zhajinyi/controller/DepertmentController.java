package com.zhajinyi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhajinyi.bean.Department;
import com.zhajinyi.bean.Msg;
import com.zhajinyi.service.DepartmentService;

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

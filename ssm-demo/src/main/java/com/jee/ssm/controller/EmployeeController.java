package com.jee.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jee.ssm.bean.Employee;
import com.jee.ssm.bean.Msg;
import com.jee.ssm.service.EmployeeService;
/**
 * ����Ա��crud����
 * @author ZhaJinyi
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("PageInfo",page);
		return "list";
	}
	
	@RequestMapping(value = "/emplist")
	public String toEmpList() {
		return "list_json";
	}
	
	
	/**
	 * ����json��String��ʽ���ַ���
	 * 
	 * 
	 */
	@RequestMapping("/emps_json")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("PageInfo",page);
		
	}
	
	/**
	 * 1��֧��JSR303У��
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		Boolean flag = result.hasErrors();
		if(!flag) {
			employeeService.saveEmp(employee);
			return Msg.success();
		}else {
			Map<String,Object> map = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError :errors) {
				String errorName = fieldError.getField();
				String errorValue = fieldError.getDefaultMessage();
				map.put(errorName, errorValue);
			}
			return Msg.failure().add("errorfields", map);
		} 

		
	}
	
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("empname")String empname) {
		boolean flag = employeeService.checkEmpName(empname);
		if(flag) {
			return Msg.success();
			
		}else {
			return Msg.failure();
			
		}
		
		
	}
	//��ѯĳ��Ա��ͨ��ID
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.GET)
	@ResponseBody	
	public Msg getEmp(@PathVariable("empId")Integer empId) {
		Employee employee = employeeService.getEmpById(empId);
		
		return Msg.success().add("emp", employee);
		
	}
	//�޸�Ա��
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody		
	public Msg updateEmp(@Valid Employee employee,BindingResult result) {
		Boolean flag = result.hasErrors();
		if(!flag) {
			employeeService.updateEmp(employee); 
			return Msg.success();
		}else {
			Map<String,Object> map = new HashMap<String,Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError :errors) {
				String errorName = fieldError.getField();
				String errorValue = fieldError.getDefaultMessage();
				map.put(errorName, errorValue);
			}
			return Msg.failure().add("errorfields", map);
		} 
		
	}
	
	
	//ɾ��Ա��ͨ��ID
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.DELETE)
	@ResponseBody	
	public Msg deleteEmp(@PathVariable("empId")String empId) {
		if(empId.contains("-")) {
			//����ɾ��
			String[] empId_array = empId.split("-");
			List<Integer> list = new ArrayList<Integer>();
			for(String empId_single:empId_array) {
				Integer empId_single_int = Integer.parseInt(empId_single);
				list.add(empId_single_int);
			}
			employeeService.deleteEmp_R(list);
		}else {
			Integer empId_int = Integer.parseInt(empId);
			employeeService.deleteEmp(empId_int);
		}
		
		return Msg.success();
		
	}
	
	
}

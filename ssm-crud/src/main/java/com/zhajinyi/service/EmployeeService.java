package com.zhajinyi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhajinyi.bean.Employee;
import com.zhajinyi.bean.EmployeeExample;
import com.zhajinyi.bean.EmployeeExample.Criteria;
import com.zhajinyi.dao.EmployeeMapper;

/**
 * 
 * 查询员工数据，所有的员工
 * @author ZhaJinyi
 *
 */
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	//非分页查询
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
		
	}
	//保存员工信息
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}
	
	//校验名字是否重复
	public boolean checkEmpName(String empName) {
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpNameEqualTo(empName);
		Long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	//按照员工ID查询员工对象
	public Employee getEmpById(Integer empId) {
		Employee employee = employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}
	//更新员工
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);

	}
	//删除员工
	public void deleteEmp(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
		
	}
	//批量删除员工
	public void deleteEmp_R(List<Integer> list) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
		
	}

}

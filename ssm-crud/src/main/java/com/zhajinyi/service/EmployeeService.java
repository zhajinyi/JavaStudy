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
 * ��ѯԱ�����ݣ����е�Ա��
 * @author ZhaJinyi
 *
 */
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	//�Ƿ�ҳ��ѯ
	public List<Employee> getAll(){
		return employeeMapper.selectByExampleWithDept(null);
		
	}
	//����Ա����Ϣ
	public void saveEmp(Employee employee) {
		
		employeeMapper.insertSelective(employee);
	}
	
	//У�������Ƿ��ظ�
	public boolean checkEmpName(String empName) {
		EmployeeExample example = new EmployeeExample();
		example.createCriteria().andEmpNameEqualTo(empName);
		Long count = employeeMapper.countByExample(example);
		return count == 0;
	}
	//����Ա��ID��ѯԱ������
	public Employee getEmpById(Integer empId) {
		Employee employee = employeeMapper.selectByPrimaryKey(empId);
		return employee;
	}
	//����Ա��
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);

	}
	//ɾ��Ա��
	public void deleteEmp(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
		
	}
	//����ɾ��Ա��
	public void deleteEmp_R(List<Integer> list) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(list);
		employeeMapper.deleteByExample(example);
		
	}

}

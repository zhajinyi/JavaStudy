package com.jee.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.aspectj.apache.bcel.util.ClassPath;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.jee.ssm.bean.Department;
import com.jee.ssm.bean.Employee;
import com.jee.ssm.dao.DepartmentMapper;
import com.jee.ssm.dao.EmployeeMapper;

/**
 * ����dao��Ĺ���
 * spring����Ŀ����ʹ��Spring�ĵ�Ԫ���ԣ������Զ�ע��������Ҫ�����
 * 		1������SpringTest��jar��
 * 		2����@ContextConfigurationָ��applicationContext��·��
 * 		3��ֱ��auto wiredҪʹ�õ��������
 * @author ZhaJinyi
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
 	
	/**
	 * ����dept��mapper
	 */
	@Test
	public void testCRUD() {
/*		//1������SpringIOC����
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2���������л�ȡmapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		//System.out.println(departmentMapper);
		
		//1.���벿�Ų���
		//departmentMapper.insertSelective(new Department(null,"���Բ�"));
		//departmentMapper.insertSelective(new Department(null,"�з���"));
		
		//2.����Ա�����ݣ�����Ա������
		//employeeMapper.insertSelective(new Employee(null,"��ǿ","f","dingqiang@163.com",4));
		
		//3.�������룻ʹ�����������ģ�sqlsession
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<10;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			employeeMapper.insertSelective(new Employee(null,uid,"m",uid+"@163.com",5));
		}
		System.out.println("������ɣ�");
		
	}

}

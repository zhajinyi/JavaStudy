package com.zhajinyi.test;

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

import com.zhajinyi.bean.Department;
import com.zhajinyi.bean.Employee;
import com.zhajinyi.dao.DepartmentMapper;
import com.zhajinyi.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 * 		1、导入SpringTest的jar包
 * 		2、用@ContextConfiguration指定applicationContext的路径
 * 		3、直接auto wired要使用的组件即可
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
	 * 测试dept的mapper
	 */
	@Test
	public void testCRUD() {
/*		//1、创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2、从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
		//System.out.println(departmentMapper);
		
		//1.插入部门测试
		//departmentMapper.insertSelective(new Department(null,"测试部"));
		//departmentMapper.insertSelective(new Department(null,"研发部"));
		
		//2.生成员工数据，测试员工插入
		//employeeMapper.insertSelective(new Employee(null,"丁强","f","dingqiang@163.com",4));
		
		//3.批量插入；使用批量操作的，sqlsession
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<10;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			employeeMapper.insertSelective(new Employee(null,uid,"m",uid+"@163.com",5));
		}
		System.out.println("批量完成！");
		
	}

}

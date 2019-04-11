package com.jee.ssm.test;

import java.util.Iterator;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.jee.ssm.bean.Employee;

/**
 * ʹ��Springģ���ṩ�Ĳ��������ܣ�����
 * @author ZhaJinyi
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/WebContent/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MvcTest {
	//����SpringMVC��IOC
	@Autowired
	WebApplicationContext context;
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
		System.out.println("��ʼ����"+mockMvc);
	}
	
	@Test
	public void testpage() throws Exception {
		
		System.out.println("����");
		
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("PageInfo");
		System.out.println("��ǰҳ�棺"+pi.getPageNum());
		System.out.println("��ҳ�룺"+pi.getPages());
		System.out.println("�ܼ�¼����"+pi.getTotal());
		System.out.println("��ҳ����Ҫ������ʾ��ҳ�룺");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(""+i);
			
		}
		
		//��ȡԱ������
		List<Employee> list = pi.getList();
		for(Employee employee : list) {
			System.out.println("ID:"+employee.getEmpId()+";���䣺"+employee.getEmail());
			
		}
		//����ɹ��������л���pageinfo����
	} 

}

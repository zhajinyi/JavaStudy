import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ssh.pojo.Department;
import com.ssh.pojo.Employee;
import com.ssh.service.EmployeeService;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class EmployeeTest extends AbstractJUnit4SpringContextTests{
	
	@Autowired
	EmployeeService employeeService;

	//@Test
	public void insertEmployee() {
		for(int i=0;i<10;i++) {
			Employee employee =new Employee();
			String empName = UUID.randomUUID().toString().substring(0,5);
			employee.setName(empName);
			employee.setSex(i%2==0?0:1);
			employee.setDepartment(new Department(1));
			employee.seteMail(empName+"@dhc.com");
			employee.setBirthDate(new Date());
			employeeService.add(employee);
			System.out.println("已创建员工："+employee.toString());
		}
	}
	
	@Test
	public void getEmployee() {
		List<Employee> employees = employeeService.getAll();
		for(Employee employee : employees) {
			System.out.println(employee.toString());
		}
	}
}

package com.ssh.dao.impl;

import java.util.List;

import javax.mail.Flags.Flag;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ssh.dao.EmployeeDao;
import com.ssh.pojo.Employee;
@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired
	private SessionFactory sessionFactoty;
	private boolean Flag = false;
	
	

	public SessionFactory getSessionFactoty() {
		return sessionFactoty;
	}

	public void setSessionFactoty(SessionFactory sessionFactoty) {
		this.sessionFactoty = sessionFactoty;
	}
	
	@Override
	public boolean add(Employee employee) {
		Session session = null;
		try {
			session = sessionFactoty.openSession();
			session.save(employee);
		} catch (Exception e) {
			return Flag;
		}finally {
			session.close();
		}
		return Flag = true;
	}

	@Override
	public boolean update(Employee employee) {
		Session session = null;
		try {
			session = sessionFactoty.openSession();
			session.update(employee);
		} catch (Exception e) {
			return Flag;
		}finally {
			session.close();
		}
		return Flag = true;
	}

	@Override
	public boolean delete(Integer id) {
		Session session = null;
		try {
			session = sessionFactoty.openSession();
			Employee employee = session.get(Employee.class, id);
			session.delete(employee);
		} catch (Exception e) {
			return Flag;
		}finally {
			session.close();
		}
		return Flag = true;
	}

	@Override
	public Employee getByPrimaryKey(Integer id) {
		Session session = sessionFactoty.openSession();
		Employee employee = session.get(Employee.class, id);
		return employee;
	}

	@Override
	public List<Employee> getAll() {
		Session session = sessionFactoty.openSession();
		List<Employee> employees = session.createQuery("from Employee E left join fetch E.department", Employee.class).getResultList();
		return employees;
	}

	@Override
	public List<Employee> getByTemplete(Employee employee) {
		// TODO Auto-generated method stub
		return null;
	}

}

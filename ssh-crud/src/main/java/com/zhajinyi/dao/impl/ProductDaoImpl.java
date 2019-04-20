package com.zhajinyi.dao.impl;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.zhajinyi.bean.Product;
import com.zhajinyi.dao.ProductDao;

@Repository
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
    SessionFactory sessionFactory;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
    
	
	public Session getSession(){
		return sessionFactory.getCurrentSession();
	}
    

	@Override
	public void saveProduct(Product product) {
		Session session=getSession();
		session.save(product);
		// TODO Auto-generated method stub
		
	}

}

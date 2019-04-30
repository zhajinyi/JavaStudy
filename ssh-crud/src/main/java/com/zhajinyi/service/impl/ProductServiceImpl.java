package com.zhajinyi.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhajinyi.bean.Product;
import com.zhajinyi.dao.ProductDao;
import com.zhajinyi.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{
	
    @Autowired
    private ProductDao productDao;

	@Override
	public void saveProduct(Product product) {
		 productDao.saveProduct(product);
		// TODO Auto-generated method stub
		
	}

}

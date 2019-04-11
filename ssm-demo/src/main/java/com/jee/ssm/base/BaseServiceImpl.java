package com.jee.ssm.base;

import org.springframework.beans.factory.annotation.Autowired;

public class BaseServiceImpl<T> implements BaseService<T> {

	@Autowired
	BaseMapper<T> baseMapper;
	
	@Override
	public boolean insert(T t) {
		// TODO Auto-generated method stub
		return baseMapper.insert(t) > 0;
	}

	@Override
	public boolean insertSelective(T t) {
		// TODO Auto-generated method stub
		return baseMapper.insertSelective(t) > 0;
	}

	@Override
	public T selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

}

package com.jee.ssm.base;

public interface BaseService<T> {
	
	boolean insert(T t);
	
	boolean insertSelective(T t);
	
	T selectAll();
}

package com.jee.ssm.base;

import java.util.List;
import org.springframework.stereotype.Service;

@Service
public interface BaseMapper<T> {
	
    int insert(T t);

    int insertSelective(T t);
    
    long countByExample(T t);

    int deleteByExample(T t);

    int deleteByPrimaryKey(Integer id);

    List<T> selectByExample(T t);

    T selectByPrimaryKey(Integer id);  

    int updateByPrimaryKeySelective(T t);

    int updateByPrimaryKey(T t);
}

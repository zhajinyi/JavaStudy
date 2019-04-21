package com.jee.ssm.utils;

import redis.clients.jedis.Jedis;

public class RedisDemo {
	
	public static void main(String[] args) {
		
		//连接本地的 Redis 服务
		Jedis jedis = new Jedis("localhost",6379);
		

        System.out.println("连接成功");
        //查看服务是否运行
        System.out.println("服务正在运行: "+jedis.ping());
        
        //设置 redis 字符串数据
        jedis.set("runoobkey", "www.runoob.com");
        // 获取存储的数据并输出
        System.out.println("redis 存储的字符串为: "+ jedis.get("runoobkey"));
        System.out.println("redis中存储的value是否存在："+jedis.exists("value"));
        System.out.println(jedis.get("name"));
        
        System.out.println(jedis.shutdown());
		
	}

}

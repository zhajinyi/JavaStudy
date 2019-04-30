package com.zhajinyi.bean;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="product", catalog = "ssh")
public class Product {
<<<<<<< HEAD
	 
    private int productId;// 商品ID
=======
	@Id
    @GeneratedValue(generator = "productId")
	@GenericGenerator(name = "productId", strategy = "native") //自定义主键生成策略 generator = name 
    private int productId;// 商品ID
	@Column(length = 100)
>>>>>>> branch 'master' of https://github.com/zhajinyi/JavaStudy.git
    private String productName;// 商品名称
    private double productPrice;// 商品价格
    
    public Product(String productName,double productPrice) {
    	this.productName = productName;
    	this.productPrice = productPrice;
		// TODO Auto-generated constructor stub
	}
    
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public double getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(double productPrice) {
		this.productPrice = productPrice;
	}
     

     
}

package com.zhajinyi.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;
import com.zhajinyi.bean.Product;
import com.zhajinyi.service.ProductService;


@Controller
@Scope("prototype")
public class ProductAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	
    @Autowired
    private ProductService productService;
    private String productName;
    private double productPrice;

    public String saveProduct() {
        Product product = new Product(productName,productPrice);
        productService.saveProduct(product);
        this.addActionMessage("保存成功！");
        return SUCCESS;
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



	@Override
    public void validate() {
        if(productName == null || "".equals(productName.trim())) {
            this.addFieldError("productName", "商品名称不能为空");
        }
    }
}

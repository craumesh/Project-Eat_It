package com.eatit.businessDomain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrdersVO {
	
	private String order_id;
	private Integer company_no;
	private Integer employee_no;
	private Integer product_no;
	private Integer quantity; 
	private Timestamp order_date;
	private String due_date;
	private String comments;
	private String order_status;
	private Timestamp update_date;
	private Integer delete_status; 
	
	// JOIN 데이터
	private String company_name; 
	private String company_tel; 
	private String product_name; 
	private String photo_paths; 
	private String name; 
	private String company_address; 
	private String company_address_detail; 
	private Integer stock_quantity;
	
}

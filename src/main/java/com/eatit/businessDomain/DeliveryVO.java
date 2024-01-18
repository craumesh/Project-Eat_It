package com.eatit.businessDomain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class DeliveryVO {

	private Integer delivery_id;
	private Integer order_id;
	private Timestamp create_date;
	private Timestamp update_date;
	private Timestamp delivery_start_date;
	private Timestamp delivery_end_date;
	private Integer delivery_employee_no;
	private Integer confirm_employee_no;
	private String delivery_status;
	
	// JOIN 데이터
	private String product_name;
	private String photo_paths;
	private Integer price;
	private Integer quantity;
	private String company_name;
	private String company_tel;
	private String company_zip_code;
	private String company_address;
	private String company_address_detail;
	private String comments;
	
}

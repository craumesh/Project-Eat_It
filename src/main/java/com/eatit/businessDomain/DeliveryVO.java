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
	
}

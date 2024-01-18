package com.eatit.productionDomain;

import java.sql.Date;

import lombok.Data;

@Data
public class productionVO {
	private int production_no;
	private int machine_code;
	private int product_no;
	private int employee_no;
	private Date production_time;
	
}

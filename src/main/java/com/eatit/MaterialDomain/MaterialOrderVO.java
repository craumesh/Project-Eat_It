package com.eatit.MaterialDomain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.ToString;


@Data
public class MaterialOrderVO {
	
	private Integer materialod_id;
	private Integer company_no;
	private Timestamp materialod_date;
	private Integer product_no;
	private Integer quantity;
	private Integer employee_no;
	private String status; 

}

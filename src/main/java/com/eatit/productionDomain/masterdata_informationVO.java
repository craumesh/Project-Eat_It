package com.eatit.productionDomain;

import lombok.Data;

@Data
public class masterdata_informationVO {
	private int product_no;
	private String code;
	private String name;
	private String photo_paths;
	private String category;
	private String category_detail; 
	private int company_no;
	private String unit;
	private String unit_quantity;
	private Float price;
	private int EXP_intervar;
	private String recipe;
}

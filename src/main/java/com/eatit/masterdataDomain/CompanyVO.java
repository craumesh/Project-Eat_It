package com.eatit.masterdataDomain;

import lombok.Data;

@Data
public class CompanyVO {
	
	private int company_no;
	private String company_name;
	private String company_type;
	private String company_zip_code;
	private String company_address;
	private String company_address_detail;
	private String company_reference;
	private String company_tel;
	private String company_manager;
	private String transaction_history;
	private String contract_information;
	private String trading_conditions;
	private String photo_paths;
	
}

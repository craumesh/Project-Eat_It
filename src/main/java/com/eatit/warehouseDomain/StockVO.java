package com.eatit.warehouseDomain;

import java.sql.Date;

import lombok.Data;

@Data
public class StockVO {
	private int stock_id;			// 재고번호
	private String identify_code; 	// 식별코드
	private String product_code;	// 품목코드
	private int warehouse_no;		// 창고번호
	private String category;		// 구분
	private String product_name;	// 품목이름
	private int quantity;			// 재고수량
	private String product_unit;	// 단위
	private Date expiry_date;		// 유통기한
}

package com.eatit.warehouseDomain;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class StockInfoVO {
	private String identify_code; 			// 식별코드
	private int history_no;					// 생산 기록번호
	private String code;					// 제품코드
	private int company_no;					// 거래처정보번호
	private int warehouse_no;				// 창고번호
	private String io_classification;		// 입출고구분
	private String category;				// 구분			
	private String name;					// 품목이름
	private int io_quantities;				// 입출고수량
	private String unit;					// 단위
	private float price;					// 가격
	private Date expiry_date;				// 유통기한
	private Timestamp io_date;				// 입출고일
	private String status;					// 승인 상태
}

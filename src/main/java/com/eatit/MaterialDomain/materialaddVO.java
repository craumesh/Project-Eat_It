package com.eatit.MaterialDomain;


import java.sql.Timestamp;

import org.springframework.format.annotation.DateTimeFormat;

import java.sql.Date;

import lombok.Data;

@Data  
public class materialaddVO {
	
    // 원자재 추가에 필요한 필드들
	private Integer materialadd_no; //자재 입고 기록 번호
	private Timestamp materialadd_date; // 자재입고 일자
	private Integer product_no;			// 품목정보번호
	private Integer warehouse_no;		// 창고번호
    
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date expiry_date;        // 유통기한
    private Integer quantity;       // 수량
    private String status;			// 입고,출고

    
}

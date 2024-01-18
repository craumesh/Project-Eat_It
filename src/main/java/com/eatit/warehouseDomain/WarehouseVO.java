package com.eatit.warehouseDomain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class WarehouseVO {
	private int warehouse_no;		// 창고번호
	private String location_name;	// 위치명
	private String warehouse_name;	// 창고명
	private String category;		// 구분
	private int admin_no;			// 관리자 사번
	private String use_status;		// 사용여부
	private String note;			// 비고
	private String updater;			// 수정자
	private Timestamp updatedate;	// 수정일
	
	// join에 필요한 값
	private int employee_no;
	private String name;
	private String contact;
	private String email;
}

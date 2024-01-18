package com.eatit.MaterialDomain;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class MaterialListVO {
	private Integer material_num; // 원자재 ID
	private String product_code; // 원자재 코드
	private String product_name; // 원자재 이름
	private String product_category_detail; // 원자재 종류
	private Integer material_quantity; // 수량
	private Integer warehouse_no; // 창고 코드
	private Integer employee_no; // 담당자
	private Timestamp material_checkDate; // 확인 날짜

	// Lombok @Data 어노테이션이 getter, setter, toString 등을 자동으로 생성합니다.
}

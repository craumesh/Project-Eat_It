package com.eatit.memberDomain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private int employee_no;
	private String photo_paths;
	private String id;
	private String pw;
	private String name;
	private String depart_name;
	private String position_name;
	private String extension_no;
	private String email;
	private String contact;
	private String address;
	private String status;
	private String active;
	private Timestamp regdate;
	private Timestamp update;
	
	// 조인으로 생성되는 결과를 저장하는 변수
	private List<AuthVO> authList;
}

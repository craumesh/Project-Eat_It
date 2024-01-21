package com.eatit.memberService;

import com.eatit.memberDomain.MemberVO;

public interface MemberService {
	//로그인 처리 동작
	public MemberVO memberLogin(MemberVO vo);
	
	// 회원 등록 메서드
	public void memberJoin(MemberVO vo);
	
	// 내정보 출력 메서드
	public MemberVO memberProfile(MemberVO vo);
	
	// 내정보 수정 메서드
	public void memberUpdateProfile(MemberVO vo);
	
	public MemberVO memberLoginInfo(MemberVO vo);
}

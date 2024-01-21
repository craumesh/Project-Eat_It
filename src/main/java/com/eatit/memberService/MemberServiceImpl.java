package com.eatit.memberService;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.memberDomain.MemberVO;
import com.eatit.memberPersistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Inject
	private MemberDAO mdao;

	@Override
	public MemberVO memberLogin(MemberVO vo) {
		logger.debug("Service - 로그인처리");
		return mdao.LoginMember(vo);
	}
	
	@Override
	public void memberJoin(MemberVO vo) {
		logger.debug("Service - 회원가입 메서드 호출");
		mdao.insertMember(vo);
		
	}

	@Override
	public MemberVO memberProfile(MemberVO vo) {
		logger.debug("내정보 출력");
		return mdao.selectProfile(vo);
	}

	@Override
	public void memberUpdateProfile(MemberVO vo) {
		logger.debug("Service - 내정보 수정");
		mdao.updateProfile(vo);
	}

	@Override
	public MemberVO memberLoginInfo(MemberVO vo) {
		logger.debug("로그인 정보 조회");
		return mdao.selectJoinMemberInfo(vo);
	}
	
}

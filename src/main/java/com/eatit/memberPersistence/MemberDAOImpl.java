package com.eatit.memberPersistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.memberDomain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;

	private static final String NAMESPACE="com.eatit.mapper.MemberMapper";
	
	@Override
	public MemberVO LoginMember(MemberVO vo) {
		logger.debug("DAO - 로그인 처리");
		
		MemberVO resultVO
			= sqlSession.selectOne(NAMESPACE+".LoginMember",vo);
		
		return resultVO;
	}
	
	@Override
	public void insertMember(MemberVO vo) {
		logger.debug("mapper(DB) 회원가입 처리 구문 실행");
		sqlSession.insert(NAMESPACE + ".insertMember",vo);
	
		
	}

	@Override
	public MemberVO selectProfile(MemberVO vo) {
		logger.debug("DAO - 내정보 출력");
		
		return sqlSession.selectOne(NAMESPACE+".selectProfile",vo);
	}

	@Override
	public void updateProfile(MemberVO vo) {
		logger.debug("DAO - 내정보 수정");
		sqlSession.update(NAMESPACE+".updateProfile",vo);
		
	}

	
	
	
}

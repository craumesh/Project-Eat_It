package com.eatit.memberPersistence;

import java.util.List;
import java.util.Map;

import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;

public interface HumanResourceDAO {
	
	public MemberVO selectHrContent(MemberVO vo);

	public List<MemberVO> selectHrList(Criteria cri);
	
	public int getTotalCount();
	
	public void updateHrContent(MemberVO vo);
	
	public List<MemberVO> selectSearchList(Map<String, Object> params);
	
	public int getSearchCount(Map<String, Object> params);	

	public List<MemberVO> selectHrRegList(Criteria cri);
	
	public int getRegCount();	
	
	public void updateHrRegActive(MemberVO vo);
	
	public void deleteHrRegData(MemberVO vo);
}

package com.eatit.memberService;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.memberPersistence.HumanResourceDAO;

@Service
public class HumanResourceServiceImpl implements HumanResourceService {	
	private static final Logger logger = LoggerFactory.getLogger(HumanResourceServiceImpl.class);
	
	@Inject
	HumanResourceDAO hrDAO;

	@Override
	public List<MemberVO> getHrList(Criteria cri) {
		logger.debug("Service(getHrList) -> DAO 호출");
		return hrDAO.selectHrList(cri);
	}

	@Override
	public MemberVO getHrContent(MemberVO vo) {
		logger.debug("Service(getHrContent) -> DAO 호출");
		return hrDAO.selectHrContent(vo);
	}

	@Override
	public int getTotalCount() {
		logger.debug("Service(getTotalCount) -> DAO 호출");
		return hrDAO.getTotalCount();
	}

	@Override
	public void editHrContent(MemberVO vo) {
		logger.debug("Service(editHrContent) -> DAO 호출");
		hrDAO.updateHrContent(vo);
	}

	@Override
	public List<MemberVO> getSearchList(Map<String, Object> params) {
		logger.debug("Service(getSearchList) -> DAO 호출");
		return hrDAO.selectSearchList(params);
	}

	@Override
	public int getSearchCount(Map<String, Object> params) {
		logger.debug("Service(getSearchCount) -> DAO 호출");
		return hrDAO.getSearchCount(params);
	}

	@Override
	public List<MemberVO> getHrRegList(Criteria cri) {
		logger.debug("Service(getHrRegList) -> DAO 호출");
		return hrDAO.selectHrRegList(cri);
	}

	@Override
	public int getRegCount() {
		// TODO Auto-generated method stub
		logger.debug("Service(getRegCount) -> DAO 호출");
		return hrDAO.getRegCount();
	}

	@Override
	public void setHrRegActive(MemberVO vo) {
		logger.debug("Service(setHrRegActive) -> DAO 호출");
		hrDAO.updateHrRegActive(vo);
	}

	@Override
	public void deniedHrReg(MemberVO vo) {
		logger.debug("Service(deniedHrReg) -> DAO 호출");
		hrDAO.deleteHrRegData(vo);
	}

}

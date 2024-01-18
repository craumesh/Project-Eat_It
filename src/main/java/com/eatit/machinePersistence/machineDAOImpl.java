package com.eatit.machinePersistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.mainDomain.Criteria;

@Repository
public class machineDAOImpl implements machineDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(machineDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
private static final String NAMESPACE="com.eatit.mapper.machineMapper";

	@Override
	public void insertmachine(machineVO vo) {
	// 설비를 추가하는 동작
		logger.debug("mapper(DB) 설비를 추가하는 동작 구문 실행 - 시작");
		sqlSession.insert(NAMESPACE+ ".insertmachine",vo);
		logger.debug("mapper(DB) 설비를 추가하는 동작 구문 실행 - 끝");
	}

	@Override
	public List<machineVO> getmachinelist(Criteria cri) {
		logger.debug("machinelist()");
		return sqlSession.selectList(NAMESPACE+ ".getmachinelist",cri);
	}

	@Override
	public void machinehistory(machinehistoryVO vo) {
		logger.debug("machinehistory(machinehistoryVO vo) 구문 시작");
		sqlSession.insert(NAMESPACE+ ".machinehistory", vo);
		logger.debug("machinehistory(machinehistoryVO vo) 구문 끝");
	}

	@Override
	public int getmachinecode() {
		logger.debug("getmachinecode() 구문시작");
		return sqlSession.selectOne(NAMESPACE+ ".getmachinecode");
	}

	@Override
	public machineVO machineinfo(int code) {
		logger.debug("machineinfo() 구문시작");
		return sqlSession.selectOne(NAMESPACE+ ".machineinfo",code);
	}

	@Override
	public int machineupdate(machineVO vo) {
	 logger.debug("machineupdate 구문시작");
	 return sqlSession.update(NAMESPACE + ".machineupdate", vo);	
	}

	@Override
	public void machinedelete(machineVO vo) {
		logger.debug("machinedelete 구문시작");
		sqlSession.delete(NAMESPACE+ ".machinedelete", vo);

	}

	@Override
	public int totalCount() {
		logger.debug("totalCount() 호출");
		return sqlSession.selectOne(NAMESPACE+ ".totalCount");
	}

	@Override
	public void machinedeleteupdate(machineVO vo) {
		logger.debug("machinedeleteupdate() 호출");
		sqlSession.update(NAMESPACE+ ".machinedeleteupdate",vo);
		
	}

	@Override
	public machineVO productstatus(int code) {
		logger.debug("productstatus() 호출");
		return sqlSession.selectOne(NAMESPACE+ ".productstatus", code);
	}

	@Override
	public List<machineVO> machinecategory() {
		logger.debug("DAO : machinecategory()");
		return sqlSession.selectList(NAMESPACE+ ".machinecategory");
	}
	
	
}

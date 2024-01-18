package com.eatit.mainPersistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.mainDomain.mainVO;

@Repository
public class mainDAOImpl implements mainDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(mainDAOImpl.class);

	private static final String NAMESPACE = "com.eatit.mapper.MainMapper";
	
	@Inject
	private SqlSession SqlSession;
	
	@Override
	public List<mainVO> selectOrderChart() {
		logger.debug("DAO : selectOrderChart");
		return SqlSession.selectList(NAMESPACE + ".selectOrderChart");
	}

	@Override
	public List<mainVO> selectChartYear() {
		logger.debug("DAO : selectChartYear");
		return SqlSession.selectList(NAMESPACE + ".selectChartYear");
	}

	@Override
	public List<mainVO> selectChartMonth() {
		logger.debug("DAO : selectChartMonth");
		return SqlSession.selectList(NAMESPACE + ".selectChartMonth");
	}

	@Override
	public List<mainVO> selectYearsOrder(mainVO vo) {
		logger.debug("DAO : selectYearsOrder");
		return SqlSession.selectList(NAMESPACE + ".selectYearOrders",vo);
	}

	@Override
	public mainVO selectMonthOrders(mainVO vo) {
		logger.debug("DAO : selectMonthOrders");
		return SqlSession.selectOne(NAMESPACE + ".selectMonthOrders",vo);
	}

	@Override
	public mainVO selectNowYearPrice() {
		logger.debug("DAO : selectNowYearPrice");
		return SqlSession.selectOne(NAMESPACE + ".selectNowYearPrice");
	}

	@Override
	public mainVO selectRecentUpdate() {
		logger.debug("DAO : selectRecentUpdate");
		return SqlSession.selectOne(NAMESPACE + ".selectRecentUpdate");
	}	
	
	

	
	
}

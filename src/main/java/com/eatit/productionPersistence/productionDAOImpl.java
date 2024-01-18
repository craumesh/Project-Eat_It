package com.eatit.productionPersistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionVO;
import com.eatit.productionDomain.productionhistoryVO;

@Repository
public class productionDAOImpl implements productionDAO{

	
	private static final Logger logger = LoggerFactory.getLogger(productionDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.eatit.mapper.productionMapper";
	private static final String NAMESPACE_machine="com.eatit.mapper.machineMapper";



	@Override
	public int machinetotalCount() {
		logger.debug("machinetotalCount()");
		return sqlSession.selectOne(NAMESPACE+".machinetotalCount");
	}


	@Override
	public List<machineVO> machinelistall(Criteria cri) {
		logger.debug("machinlist()");
		return sqlSession.selectList(NAMESPACE_machine + ".machinelistall", cri);
	}
	
	
	
	
	@Override
	public void productionhistory(productionhistoryVO vo) {
		
	  sqlSession.insert(NAMESPACE+ ".productionhistory", vo);
	}


	@Override
	public List<OrdersVO> selectOrderList(Criteria cri) {
		
		return sqlSession.selectList(NAMESPACE + ".selectOrderlist", cri);
	}


	@Override
	public String recipe(Integer product_no) {
	 logger.debug("DAO : recipe");
		return sqlSession.selectOne(NAMESPACE+ ".recipe", product_no);
	}


	@Override
	public List<masterdata_informationVO> category() {
		logger.debug("DAO : category");
		return sqlSession.selectList(NAMESPACE+ ".category");
	}

	
	
}

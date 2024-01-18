package com.eatit.businessPersistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;

@Repository
public class DeliveryDAOImpl implements DeliveryDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryDAOImpl.class);
	
	private static final String NAMESPACE = "com.eatit.mapper.DeliveryMapper";
	
	@Inject
	private SqlSession SqlSession;

	@Override
	public int selectCountTotalDelivery() {
		logger.debug("DAO: selectCountTotalDelivery()");
		return SqlSession.selectOne(NAMESPACE + ".selectCountTotalDelivery");
	}

	@Override
	public List<DeliveryVO> selectDeliveryList(Criteria cri) {
		logger.debug("DAO: selectDeliveryList(cri)");
		return SqlSession.selectList(NAMESPACE + ".selectDeliveryList", cri);
	}

	@Override
	public int selectCountMatchingDelivery(Map<String, Object> params) {
		logger.debug("DAO: selectCountMatchingDelivery(params)");
		return SqlSession.selectOne(NAMESPACE + ".selectCountMatchingDelivery", params);
	}

	@Override
	public List<DeliveryVO> selectMatchingDeliveryList(Map<String, Object> params) {
		logger.debug("DAO: selectMatchingDeliveryList(params)");
		return SqlSession.selectList(NAMESPACE + ".selectMatchingDeliveryList", params);
	}

	@Override
	public MemberVO selectMemberInfo(String id) {
		logger.debug("DAO: selectMemberInfo(id)");
		return SqlSession.selectOne(NAMESPACE + ".selectMemberInfo", id);
	}

	@Override
	public void insertDelivery(DeliveryVO dvo) {
		logger.debug("DAO: insertDelivery(dvo)");
		SqlSession.insert(NAMESPACE + ".insertDelivery", dvo);
	}

	@Override
	public StockVO selectProductStock(String productName) {
		logger.debug("DAO: selctReleaseInfo(productName)");
		return SqlSession.selectOne(NAMESPACE + ".selectProductStock", productName);
	}

	@Override
	public DeliveryVO selectDeliveryDetail(Integer delivery_id) {
		logger.debug("DAO: selectDeliveryDetail(delivery_id)");
		return SqlSession.selectOne(NAMESPACE + ".selectDeliveryDetail", delivery_id);
	}

	@Override
	public void updateDeliveryStart(Map<String, Object> params) {
		logger.debug("DAO: updateDeliveryStart(params)");
		SqlSession.update(NAMESPACE + ".updateDeliveryStart", params);
	}

	@Override
	public void updateDeliveryComplete(Integer delivery_id) {
		logger.debug("DAO: updateDeliveryComplete(delivery_id)");
		SqlSession.update(NAMESPACE + ".updateDeliveryComplete", delivery_id);
	}

	@Override
	public void updateReleaseComplete(Integer order_id) {
		logger.debug("DAO: updateReleaseComplete(order_id)");
		SqlSession.update(NAMESPACE + ".updateReleaseComplete", order_id);
	}
	
}

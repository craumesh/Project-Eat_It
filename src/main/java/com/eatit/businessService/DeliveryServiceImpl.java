package com.eatit.businessService;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.businessPersistence.DeliveryDAO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;

@Service
public class DeliveryServiceImpl implements DeliveryService {
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryServiceImpl.class);
	
	@Inject
	private DeliveryDAO ddao;

	@Override
	public int getTotalDeliveryCount() {
		logger.debug("Service: getTotalDeliveryCount()");
		return ddao.selectCountTotalDelivery();
	}

	@Override
	public List<DeliveryVO> getDeliveryList(Criteria cri) {
		logger.debug("Service: getDeliveryList(cri)");
		return ddao.selectDeliveryList(cri);
	}

	@Override
	public int getMatchingDeliveryCount(Map<String, Object> params) {
		logger.debug("Service: getMatchingDeliveryCount(params)");
		return ddao.selectCountMatchingDelivery(params);
	}

	@Override
	public List<DeliveryVO> getMatchingDeliveryList(Map<String, Object> params) {
		logger.debug("Service: getMatchingDeliveryList(params)");
		return ddao.selectMatchingDeliveryList(params);
	}

	@Override
	public MemberVO getMemberInfo(String id) {
		logger.debug("Service: getMemberInfo(id)");
		return ddao.selectMemberInfo(id);
	}

}

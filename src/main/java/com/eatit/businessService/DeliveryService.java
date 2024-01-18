package com.eatit.businessService;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;

public interface DeliveryService {

	public int getTotalDeliveryCount();

	public List<DeliveryVO> getDeliveryList(Criteria cri);

	public int getMatchingDeliveryCount(Map<String, Object> params);

	public List<DeliveryVO> getMatchingDeliveryList(Map<String, Object> params);

	public MemberVO getMemberInfo(String id);

}

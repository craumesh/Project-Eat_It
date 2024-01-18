package com.eatit.businessService;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;

public interface DeliveryService {

	public int getTotalDeliveryCount();

	public List<DeliveryVO> getDeliveryList(Criteria cri);

	public int getMatchingDeliveryCount(Map<String, Object> params);

	public List<DeliveryVO> getMatchingDeliveryList(Map<String, Object> params);

	public MemberVO getMemberInfo(String id);

	public void requestDelivery(DeliveryVO dvo);

	public void requestRelease(Integer order_id);

	public DeliveryVO getDeliveryDetail(Integer delivery_id);

	public void startDelivery(Map<String, Object> params);

	public void completeDelivery(Integer delivery_id);
	
	public void completeRelease(Integer order_id);
	
}

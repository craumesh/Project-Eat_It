package com.eatit.businessPersistence;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;

public interface DeliveryDAO {

	public int selectCountTotalDelivery();

	public List<DeliveryVO> selectDeliveryList(Criteria cri);

	public int selectCountMatchingDelivery(Map<String, Object> params);

	public List<DeliveryVO> selectMatchingDeliveryList(Map<String, Object> params);

	public MemberVO selectMemberInfo(String id);

	public void insertDelivery(DeliveryVO dvo);

	public StockVO selectProductStock(String productName);

	public DeliveryVO selectDeliveryDetail(Integer delivery_id);

	public void updateDeliveryStart(Map<String, Object> params);

	public void updateDeliveryComplete(Integer delivery_id);

	public void updateReleaseComplete(Integer order_id);

}

package com.eatit.businessPersistence;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;

public interface DeliveryDAO {

	public int selectCountTotalDelivery();

	public List<DeliveryVO> selectDeliveryList(Criteria cri);

	public int selectCountMatchingDelivery(Map<String, Object> params);

	public List<DeliveryVO> selectMatchingDeliveryList(Map<String, Object> params);

	public MemberVO selectMemberInfo(String id);

}

package com.eatit.businessService;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessDomain.ProductVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.CompanyVO;
import com.eatit.memberDomain.MemberVO;

public interface OrdersService {

	public List<OrdersVO> getOrderList(Criteria cri); 

	public List<OrdersVO> findOrderList(Map<String, Object> params);
	
	public int getTotalCount();
	
	public int getFindCount(Map<String, Object> params);
	
	public MemberVO getMemberInfo(String id);
	
	public void addOrder(OrdersVO ovo); 

	public OrdersVO getOrderDetail(Integer order_id); 

	public List<CompanyVO> getCompanyList(Criteria cri);
	
	public int getTotalCompanyCount();
	
	public int getMatchingCompanyCount(Map<String, Object> params);
	
	public List<CompanyVO> findCompany(Map<String, Object> params);
	
	public CompanyVO selectCompany(int company_no);
	
	public int getTotalProductCount();
	
	public int getMatchingProductCount(Map<String, Object> params);
	
	public List<ProductVO> getProductList(Criteria cri); 
	
	public List<ProductVO> findProduct(Map<String, Object> params);
	
	public ProductVO selectProduct(Integer product_no);
	
	public int editForm(OrdersVO ovo);

	public int cancelForm(int order_id);

	public List<OrdersVO> selectproduct(Criteria cri);
	
	public int selectproductcount();

}

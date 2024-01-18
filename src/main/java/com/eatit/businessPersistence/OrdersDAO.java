package com.eatit.businessPersistence;

import java.util.List;
import java.util.Map;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessDomain.ProductVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.CompanyVO;
import com.eatit.memberDomain.MemberVO;

public interface OrdersDAO {

	public List<OrdersVO> selectOrderList(Criteria cri);

	public List<OrdersVO> findOrderList(Map<String, Object> params);
	
	public int getTotalCount();
	
	public int getFindCount(Map<String, Object> params);
	
	public MemberVO selectMember(String id);
	
	public void insertOrder(OrdersVO ovo); 

	public OrdersVO selectOrderDetail(Integer order_id); 

	public List<CompanyVO> selectCompanyList(Criteria cri);
	
	public int selectCountTotalCompany();
	
	public int selectCountMatchingCompany(Map<String, Object> params);
	
	public List<CompanyVO> findCompany(Map<String, Object> params);
	
	public CompanyVO selectCompany(Integer company_no);
	
	public int selectCountTotalProduct();
	
	public int selectCountMatchingProduct(Map<String, Object> params);
	
	public List<ProductVO> selectProductList(Criteria cri);
	
	public List<ProductVO> findProduct(Map<String, Object> params);
	
	public ProductVO selectProduct(Integer product_no); 
	
	public int updateForm(OrdersVO ovo);

	public int deleteForm(Integer order_id);

	public List<OrdersVO> selectproduct(Criteria cri);
	
	public int selectproductcount();
}

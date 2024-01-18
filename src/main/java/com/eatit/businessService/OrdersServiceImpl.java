package com.eatit.businessService;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessDomain.ProductVO;
import com.eatit.businessPersistence.OrdersDAO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.CompanyVO;
import com.eatit.memberDomain.MemberVO;

@Service
public class OrdersServiceImpl implements OrdersService {
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersServiceImpl.class);

	@Inject
	private OrdersDAO odao;
	
	@Override
	public List<OrdersVO> getOrderList(Criteria cri) {
		logger.debug("Service: getOrderList(cri)");
		return odao.selectOrderList(cri);
	}
	
	@Override
	public List<OrdersVO> findOrderList(Map<String, Object> params) {
		logger.debug("Service: findOrderList(params)");
		return odao.findOrderList(params);
	}

	@Override
	public int getTotalCount() {
		logger.debug("Service: getTotalCount()");
		return odao.getTotalCount();
	}
	
	@Override
	public int getFindCount(Map<String, Object> params) {
		logger.debug("Service: getFindCount(params)");
		return odao.getFindCount(params);
	}

	@Override
	public MemberVO getMemberInfo(String id) {
		logger.debug("Service: getMemberInfo(id)");
		return odao.selectMember(id);
	}
	
	@Override
	public void addOrder(OrdersVO ovo) {
		logger.debug("Service: addOrder(ovo)");
		odao.insertOrder(ovo);
	} 

	@Override
	public OrdersVO getOrderDetail(Integer order_id) {
		logger.debug("Service: getOrderDetail(int order_id)");
		return odao.selectOrderDetail(order_id);
	} 
	
	@Override
	public List<CompanyVO> getCompanyList(Criteria cri) {
		logger.debug("Service: getCompanyList(cri)");
		return odao.selectCompanyList(cri);
	}
	
	@Override
	public int getTotalCompanyCount() {
		logger.debug("Service: getTotalCompanyCount()");
		return odao.selectCountTotalCompany();
	}

	@Override
	public int getMatchingCompanyCount(Map<String, Object> params) {
		logger.debug("Service: getMatchingCompanyCount(params)");
		return odao.selectCountMatchingCompany(params);
	}

	@Override
	public List<CompanyVO> findCompany(Map<String, Object> params) {
		logger.debug("Service: findCompany(params)");
		return odao.findCompany(params);
	}
	
	@Override
	public CompanyVO selectCompany(int company_no) {
		logger.debug("Service: sselectCompany(company_no)");
		return odao.selectCompany(company_no);
	}
	
	@Override
	public int getTotalProductCount() {
		logger.debug("Service: getTotalProductCount()");
		return odao.selectCountTotalProduct();
	}

	@Override
	public int getMatchingProductCount(Map<String, Object> params) {
		logger.debug("Service: getMatchingProductCount(params)");
		return odao.selectCountMatchingProduct(params);
	}

	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		logger.debug("Service: getProductList(cri)");
		return odao.selectProductList(cri);
	}

	@Override
	public List<ProductVO> findProduct(Map<String, Object> params) {
		logger.debug("Service: findProduct(params)");
		return odao.findProduct(params);
	} 
	
	@Override
	public ProductVO selectProduct(Integer product_no) {
		logger.debug("Service: selectProduct(product_no)");
		return odao.selectProduct(product_no);
	} 
	
	@Override
	public int editForm(OrdersVO pvo) {
		logger.debug("Service: editForm(PurchaseVO pvo)");
		return odao.updateForm(pvo);
	}

	@Override
	public int cancelForm(int order_id) {
		logger.debug("Service: cancelForm(int order_id)");
		return odao.deleteForm(order_id);	
	}
	
	@Override
	public List<OrdersVO> selectproduct(Criteria cri) {
		logger.debug("Service: selectproduct");
		return odao.selectproduct(cri);
	}

	@Override
	public int selectproductcount() {
		logger.debug("Service: selectproductcount");
		return odao.selectproductcount();
	}

}

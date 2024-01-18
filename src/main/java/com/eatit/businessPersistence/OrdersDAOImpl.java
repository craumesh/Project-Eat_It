package com.eatit.businessPersistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessDomain.ProductVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.CompanyVO;
import com.eatit.memberDomain.MemberVO;

@Repository
public class OrdersDAOImpl implements OrdersDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersDAOImpl.class);
	
	private static final String NAMESPACE = "com.eatit.mapper.OrdersMapper";

	@Inject
	private SqlSession SqlSession;
	
	@Override
	public List<OrdersVO> selectOrderList(Criteria cri) {
		logger.debug("DAO: selectOrderList(cri)");
		return SqlSession.selectList(NAMESPACE + ".selectOrderlist", cri);
	}
	
	@Override
	public List<OrdersVO> findOrderList(Map<String, Object> params) {
		logger.debug("DAO: findOrderList(params)");
		return SqlSession.selectList(NAMESPACE + ".findOrderList", params);
	}

	@Override
	public int getTotalCount() {
		logger.debug("DAO: getTotalCount()");
		return SqlSession.selectOne(NAMESPACE + ".totalCount");
	}
	
	@Override
	public int getFindCount(Map<String, Object> params) {
		logger.debug("DAO: getFindCount(params)");
		return SqlSession.selectOne(NAMESPACE + ".findCount", params);
	}

	@Override
	public MemberVO selectMember(String id) {
		logger.debug("DAO: selectMember(id)");
		return SqlSession.selectOne(NAMESPACE + ".selectMember", id);
	}
	
	@Override
	public void insertOrder(OrdersVO ovo) {
		logger.debug("DAO: insertOrder(ovo)");
		SqlSession.insert(NAMESPACE + ".insertOrder", ovo);
	} 

	@Override
	public List<CompanyVO> selectCompanyList(Criteria cri) {
		logger.debug("DAO: selectCompanyList(cri)");
		return SqlSession.selectList(NAMESPACE + ".selectCompanyList", cri);
	}
	
	@Override
	public int selectCountTotalCompany() {
		logger.debug("DAO: selectTotalCompanyCount()");
		return SqlSession.selectOne(NAMESPACE + ".selectCountTotalCompany");
	}

	@Override
	public int selectCountMatchingCompany(Map<String, Object> params) {
		logger.debug("DAO: selectCountMatchingCompany(params)");
		return SqlSession.selectOne(NAMESPACE + ".selectCountMatchingCompany", params);
	}

	@Override
	public List<CompanyVO> findCompany(Map<String, Object> params) {
		logger.debug("DAO: findCompany(query)");
		return SqlSession.selectList(NAMESPACE + ".findCompany", params);
	}
	
	@Override
	public CompanyVO selectCompany(Integer company_no) {
		logger.debug("DAO: selectCompany(company_no)");
		return SqlSession.selectOne(NAMESPACE + ".selectCompany", company_no);
	}
	
	@Override
	public int selectCountTotalProduct() {
		logger.debug("DAO: selectCountTotalProduct()");
		return SqlSession.selectOne(NAMESPACE + ".selectCountTotalProduct");
	}
	
	@Override
	public int selectCountMatchingProduct(Map<String, Object> params) {
		logger.debug("DAO: selectCountMatchingProduct(params)");
		return SqlSession.selectOne(NAMESPACE + ".selectCountMatchingProduct", params);
	}

	@Override
	public List<ProductVO> selectProductList(Criteria cri){
		logger.debug("DAO: getProductList(cri)");
		return SqlSession.selectList(NAMESPACE + ".selectProductList", cri);
	}

	@Override
	public List<ProductVO> findProduct(Map<String, Object> params) {
		logger.debug("DAO: findProduct(params)");
		return SqlSession.selectList(NAMESPACE + ".findProduct", params);
	} 
	
	@Override
	public ProductVO selectProduct(Integer product_no) {
		logger.debug("DAO: selectProduct(product_no)");
		return SqlSession.selectOne(NAMESPACE + ".selectProduct", product_no);
	} 
	
	@Override
	public OrdersVO selectOrderDetail(Integer order_id) {
		logger.debug("DAO: selectOrderDetail(order_id)");
		return SqlSession.selectOne(NAMESPACE + ".selectOrderDetail", order_id);
	}

	@Override
	public int updateForm(OrdersVO ovo) {
		logger.debug("DAO: updateForm(PurchaseVO ovo)");
		return SqlSession.update(NAMESPACE + ".updateForm", ovo);
	}
	@Override
	public int deleteForm(Integer order_id) {
		logger.debug("DAO: deleteForm(int order_id)");
		return SqlSession.update(NAMESPACE + ".deleteForm", order_id);
	}

	@Override
	public List<OrdersVO> selectproduct(Criteria cri) {
		logger.debug("DAO: selectproduct");
		return SqlSession.selectList(NAMESPACE+ ".selectproduct", cri);
	}

	@Override
	public int selectproductcount() {
		logger.debug("DAO : selectproductcount");
		return SqlSession.selectOne(NAMESPACE +".selectproductcount");
	}
	
	
	
}

package com.eatit.businessService;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessPersistence.DeliveryDAO;
import com.eatit.businessPersistence.OrdersDAO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehousePersistence.WarehouseDAO;

@Service
public class DeliveryServiceImpl implements DeliveryService {
	
	private static final Logger logger = LoggerFactory.getLogger(DeliveryServiceImpl.class);
	
	@Inject
	private DeliveryDAO ddao;
	
	@Inject 
	private OrdersDAO odao;
	
	@Inject
	private WarehouseDAO wdao;

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

	@Override
	public void requestDelivery(DeliveryVO dvo) {
		logger.debug("Service: requestDelivery(dvo)");
		ddao.insertDelivery(dvo);
	}

	@Override
	public void requestRelease(Integer order_id) {
		logger.debug("Service: requestRelease(Integer order_id)");
		
		// 해당 주문 내역 조회
		OrdersVO ordersVO = odao.selectOrderDetail(order_id);
		
		// 해당 상품 창고 정보 조회
		String productName = ordersVO.getProduct_name();
		StockVO stockVO = ddao.selectProductStock(productName);
		
		// StockInfoVO 객체 생성
		StockInfoVO setStockVO = new StockInfoVO();
		
		// 식별 코드 생성
		int companyNo = ordersVO.getCompany_no();
		String formatCompanyNo = String.format("%03d", companyNo);
		SimpleDateFormat prodateFormat = new SimpleDateFormat("yyyyMMdd");
		String orderDate = prodateFormat.format(ordersVO.getOrder_date());
		String formatorderId = String.format("%04d", order_id);
		
		String identify_code = formatCompanyNo+ stockVO.getProduct_code() + "-O" + orderDate + formatorderId;
		
		// 현재 날짜와 시간을 가져옴
        LocalDateTime now = LocalDateTime.now();
        Timestamp timestamp = Timestamp.valueOf(now);
		
		// siVO에 정보 담기
		setStockVO.setIdentify_code(identify_code);
		setStockVO.setWarehouse_no(stockVO.getWarehouse_no());
		setStockVO.setIo_classification("출고");
		setStockVO.setCategory(stockVO.getCategory());
		setStockVO.setName(ordersVO.getProduct_name());
		setStockVO.setIo_quantities(ordersVO.getQuantity());
		setStockVO.setUnit(stockVO.getProduct_unit());
		setStockVO.setPrice((ordersVO.getPrice()*ordersVO.getQuantity())/10000);
		setStockVO.setExpiry_date(stockVO.getExpiry_date());
		setStockVO.setIo_date(timestamp);
	
		wdao.insertStockInfoList(setStockVO);
	}

	@Override
	public DeliveryVO getDeliveryDetail(Integer delivery_id) {
		logger.debug("Service: getDeliveryDetail(delivery_id)");
		return ddao.selectDeliveryDetail(delivery_id);
	}

	@Override
	public void startDelivery(Map<String, Object> params) {
		logger.debug("Service: startDelivery(params)");
		ddao.updateDeliveryStart(params);
	}

	@Override
	public void completeDelivery(Integer delivery_id) {
		logger.debug("Service: completeDelivery(delivery_id)");
		ddao.updateDeliveryComplete(delivery_id);
	}

	@Override
	public void completeRelease(Integer order_id) {
		logger.debug("Service: completeRelease(order_id)");
		ddao.updateReleaseComplete(order_id);
	}

}

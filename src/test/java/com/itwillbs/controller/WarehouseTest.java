package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;
import com.eatit.warehousePersistence.WarehouseDAO;
import com.eatit.warehouseService.WarehouseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class WarehouseTest {
	
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseTest.class);
	
	private static final String NAMESPACE = "com.eatit.mapper.warehouseMapper.";
	
	@Inject
	private WarehouseDAO wdao;
	
	@Inject
	private WarehouseService wService;
	
	@Inject
	private SqlSession sqlsession;
	
	
//	@Test
	public void warehouseTest() {
		WarehouseVO vo = new WarehouseVO();
		vo.setAdmin_no(3);
		vo.setLocation_name("창고 1동");
		vo.setWarehouse_name("자재2창고");
		vo.setCategory("자재");
		vo.setNote("테스트창고입니다!");
		wdao.insertWarehouse(vo);
	}
	
//	@Test
	public void 창고삭제테스트() {
		WarehouseVO vo = new WarehouseVO();
		vo.setWarehouse_no(50);
		
//		wdao.deleteWarehouse(vo);
	}
	
//	@Test
	public void 직책정보테스트() {
//		wdao.getPositionName();
		wdao.getMembersOfPosition("미정");
	}

	
	@Test
	public void 매퍼테스트정보확인() {
//		wdao.getStockOfFinishedProduct();
//		wdao.getStockOfMaterial();
//		wdao.countIdentifyCode("001M1O120240105000");
//		wdao.getStockInfo();
		String[] id = {"F6C5","M10S6"};
//		wdao.countStock(id);
		
		String[] map = {"002F5C4202401090016","001M7O4202401080015"};
		
		Map<String, Object> testMap = new HashMap();
		testMap.put("identifyCode", map);
		
//		wdao.getStockInfoByIdentifyCode(map);
//		wdao.getStockInfoByIdentifyCode("002F2K1202401090017");
		StockVO vo = new StockVO();
		vo.setWarehouse_no(1);
		vo.setProduct_code("M4S1");
//		wdao.getWarehouseUseStatusByWarehouseNO(vo);
		wdao.getStockOrderByExpiryDateList(vo.getProduct_code());
		StockInfoVO infoVO = new StockInfoVO();
		infoVO.setIdentify_code("009M4S1-O202401120009");
//		wdao.getStockInfoByIdentifyCode(infoVO);
//		wdao.selectQuantityOrderByExpiryDateList(vo.getIdentify_code());
		wdao.countIdentifyCode("002F1C1-I202401030001");
		
	}
}

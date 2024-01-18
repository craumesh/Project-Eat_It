package com.eatit.productionService;

import java.util.List;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionVO;
import com.eatit.productionDomain.production_warehouseVO;
import com.eatit.productionDomain.productionhistoryVO;
import com.eatit.warehouseDomain.StockVO;

public interface productionservice {

	// 페이징 처리 갯수
	public int machinetotalCount();

	// 설비 전체 조회
	public List<machineVO> machinelistall(Criteria cri);
	
	// 생산 완료
	public void productionhistory(productionhistoryVO vo);
	
	// 발주서 확인
	public List<OrdersVO> getOrderList(Criteria cri);
	
	// 레시피 조회
	public String recipe(Integer product_no);
	
	// 자재 조회
	public List<masterdata_informationVO> category();
	
	
	// 이름 으로 조회한 제품 번호
	public masterdata_informationVO nameproduct_no(String name);
	
	// 이름 으로 조회한 창고 정보
	public StockVO stockname(String name);
	
	// 생산 창고 조회
	public production_warehouseVO production_warehouse(String product_name);
	
	// 생산 지시
	public void updatehouse(production_warehouseVO vo);
	
	public void start(productionVO vo);
	
	public int orderid(int order_id);
	
	public void startproduction(machinehistoryVO vo);
	
	public void update_machine(int machine_code);
	
	public void update_machinehistory(int machine_code);
	
	public void start_machine(machineVO vo);
}

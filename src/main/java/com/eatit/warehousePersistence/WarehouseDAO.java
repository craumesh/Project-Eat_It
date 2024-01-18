package com.eatit.warehousePersistence;

import java.util.List;
import java.util.Map;

import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;

public interface WarehouseDAO {
	
	// 창고 정보 모두 가져오기
	public List<WarehouseVO> getWarehouseListAll();
	
	// 회원 정보 모두 가져오기
	public List<MemberVO> getMemberListAll();
	
	// 직책 정보 가져오기 - ajax
	public List<String> getPositionName();
	
	// 직책에 해당하는 회원이름 리스트 가져오기 - ajax
	public List<String> getMembersOfPosition(String position_name);
	
	// 이름에 해당하는 회원정보 리스트 가져오기 - ajax
	public List<MemberVO> getMemberInfoByName(String name);
	
	// 창고 정보 가져오기(main)
	public List<WarehouseVO> getWarehouseListMain();
	
	// 특정 창고 정보 가져오기
	public WarehouseVO getWarehouseInfo(WarehouseVO vo);
	
	// 특정 창고 정보 가져오기(세션 아이디에 해당하는 회원정보) - ajax
	public MemberVO getWarehouseInfo(int no);
	
	// 창고 등록
	public void insertWarehouse(WarehouseVO vo);
	
	// 창고 상세 정보 수정
	public void updateDetailInfo(WarehouseVO vo);
	
	// 창고 삭제
	public void deleteWarehouse(int[] warehouse_no);
	
	// 창고 정보 총갯수
	public int getTotalCount();
	
	// 창고 정보 총갯수(검색어, 필터o)
	public int getFindCount(Map<String, Object> params);
	
	// 입출고 정보 테이블 모두 조회(검색어, 필터 x)
	public List<StockInfoVO> getStockInfo(Criteria cri);
	
	// 입출고 정보 테이블 모두 조회(검색어, 필터 o)
	public List<StockInfoVO> findStockInfoList(Map<String, Object> params);
	
	// 특정 식별 코드 정보 조회
	public StockInfoVO getStockInfoByIdentifyCode(StockInfoVO infoVO);
	
	// 식별코드에 해당하는 입출고 정보 갯수(식별코드 존재 여부에 사용)
	public int countIdentifyCode(String identifyCode);
	
	// 완재품 정보 리스트 정보 받아오기
	public List<StockInfoVO> getStockOfFinishedProduct();
	
	// 완재품 정보 리스트 정보 받아오기
	public List<StockInfoVO> getStockOfMaterial();
	
	// 서비스에서 받아온 완재품 입고 정보를 테이블에 insert
	public void insertStockInfoList(StockInfoVO vo);
	
	// 창고재고 로우 갯수(창고 재고 존재 여부에 사용)
	public int countStock(StockInfoVO infoVO);
	
	// 창고 입출고 테이블의 정보를 창고 테이블 insert
	public void insertStockInfoIntoStock(StockVO vo);
	
	// 창고 정보 테이블 승인 후 update
	public void updateStockInfoStatusWhenApprovalSuccess(StockVO vo);
	
	// 창고 입출고 선택한 요소 배열로 받아서 Map에 넣고 update
	public void updateStockInfoStatusWhenCancel(String[] identifyCode);
	
	// 창고 번호에 해당하는 사용여부상태 조회
	public String getWarehouseUseStatusByWarehouseNO(StockVO vo);
	
	// 창고 번호에 해당하는 사용여부상태 변경
	public void updateWarehouseUseStatus(StockVO vo);
	
	// 창고 조회(그냥 조회)
	public List<StockVO> getStockList();
	
	// 창고 리스트 총갯수(검색어 x, 필터 x) - 페이징
	public int getStockTotalCount(); 
	
	// 입출고 정보 테이블 모두 조회(검색어 x, 필터 x) - 페이징
	public List<StockVO> getStockList(Criteria cri);

	// 창고 리스트 총갯수(검색어 o, 필터 o) - 페이징
	public int findStockList(Map<String, Object> params);
	
	// 입출고 정보 테이블 모두 조회(검색어 o, 필터 o) - 페이징
	public List<StockVO> getFindStockListCount(Map<String, Object> params);
	
	// 재미있는 선입선출
	public List<StockVO> getStockOrderByExpiryDateList();

}

package com.eatit.warehousePersistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;

@Repository
public class WarehouseDAOImpl implements WarehouseDAO {
	
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseDAOImpl.class);
	private static final String NAMESPACE = "com.eatit.mapper.warehouseMapper.";
	
	@Inject
	private SqlSession sqlsession;

	@Override
	// 창고 정보 모두 가져오기
	public List<WarehouseVO> getWarehouseListAll() {
		return sqlsession.selectList(NAMESPACE+"getWarehouseListAll");
	}

	@Override
	// 회원 정보 모두 가져오기
	public List<MemberVO> getMemberListAll() {
		return sqlsession.selectList(NAMESPACE+"getMemberListAll");
	}

	@Override
	// 직책 정보 가져오기- ajax
	public List<String> getPositionName() {
		return sqlsession.selectList(NAMESPACE+"getPositionName");
	}

	@Override
	// 직책에 맞는 회원이름 가져오기- ajax
	public List<String> getMembersOfPosition(String position_name) {
		return sqlsession.selectList(NAMESPACE+"getMembersOfPosition", position_name);
	}
	
	@Override
	// 이름에 맞는 회원정보 가져오기- ajax
	public List<MemberVO> getMemberInfoByName(String name) {
		return sqlsession.selectList(NAMESPACE+"getMemberInfoByName", name);
	}

	@Override
	// 창고 정보 가져오기(main)
	public List<WarehouseVO> getWarehouseListMain() {
		return sqlsession.selectList(NAMESPACE+"getWarehouseMainList");
	}

	@Override
	// 특정 창고 정보 가져오기 - ajax
	public WarehouseVO getWarehouseInfo(WarehouseVO vo) {
		return sqlsession.selectOne(NAMESPACE+"getWarehouseInfo", vo);
	}

	@Override
	// 특정 창고 정보 가져오기(세션 아이디에 해당하는 회원정보)
	public MemberVO getWarehouseInfo(int no) {
		return sqlsession.selectOne(NAMESPACE+"getWarehouseAdminInfo", no);
	}

	@Override
	// 창고 등록
	public void insertWarehouse(WarehouseVO vo) {
		sqlsession.insert(NAMESPACE+"insertWarehouse", vo);
	}
	
	@Override
	// 창고 수정
	public void updateDetailInfo(WarehouseVO vo) {
		sqlsession.update(NAMESPACE+"updateDetailInfo", vo);
	}

	@Override
	// 창고 삭제
	public void deleteWarehouse(int[] warehouse_no) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("warehouse_no", warehouse_no);
		sqlsession.delete(NAMESPACE+"deleteWarehouse",paramMap);
	}

	@Override
	public int getTotalCount() {
		return sqlsession.selectOne(NAMESPACE+"totalCount");
	}
	
	@Override
	public int getFindCount(Map<String, Object> params) {
		return sqlsession.selectOne(NAMESPACE + "findCount", params);
	}
	
	@Override
	public List<StockInfoVO> findStockInfoList(Map<String, Object> params) {
		return sqlsession.selectList(NAMESPACE+"findStockInfoList", params);
	}

	@Override
	// 입출고 정보 테이블 모두 조회
	public List<StockInfoVO> getStockInfo(Criteria cri) {
//		logger.debug("dao - "+sqlsession.selectList(NAMESPACE+"getStockInfo"));
		return sqlsession.selectList(NAMESPACE+"getStockInfo",cri);
	}
	
//	@Override
	// 특정 식별 코드 테이블 조회
	public List<StockInfoVO> getStockInfoByIdentifyCode1(String[] identifyCode) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("identifyCode", identifyCode);
		return sqlsession.selectList(NAMESPACE+"getStockInfoByIdentifyCode", paramMap);
	}

	@Override
	// 특정 식별 코드 정보 조회
	public StockInfoVO getStockInfoByIdentifyCode(StockInfoVO infoVO) {
		return sqlsession.selectOne(NAMESPACE+"getStockInfoByIdentifyCode", infoVO);
	}

	@Override
	// 식별코드에 해당하는 입출고 정보 갯수(식별코드 존재 여부에 사용)
	public int countIdentifyCode(String identifyCode) {
		return sqlsession.selectOne(NAMESPACE+"countIdentifyCode",identifyCode);
	}

	@Override
	// 생산에 해당하는 완재품 정보 리스트 받아오기
	public List<StockInfoVO> getStockOfFinishedProduct() {
		return sqlsession.selectList(NAMESPACE+"getStockOfFinishedProduct");
	}

	@Override
	// 자재입고에 해당하는 완재품 정보 리스트 받아오기
	public List<StockInfoVO> getStockOfMaterial() {
		return sqlsession.selectList(NAMESPACE+"getStockOfMaterial");
	}

	@Override
	// 서비스에서 받아온 완재품 입고 정보를 테이블에 insert
	public void insertStockInfoList(StockInfoVO vo) {
		sqlsession.insert(NAMESPACE+"insertStockInfo", vo);
	}

//	@Override
	// 창고재고 로우 갯수(창고 재고 존재 여부에 사용)
	public int countStock1(String[] productCode) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("productCode", productCode);
		return sqlsession.selectOne(NAMESPACE+"countStock1",paramMap);
	}
	
	@Override
	// 해당 식별번호에 대한 품목 이름 가져오기
	public int countStock(StockInfoVO infoVO) {
		return sqlsession.selectOne(NAMESPACE+"countStock", infoVO);
	}

	@Override
	// 창고 테이블에 insert
	public void insertStockInfoIntoStock(StockVO vo) {
		sqlsession.insert(NAMESPACE+"insertStock", vo);
	}
	
	@Override
	// 창고 정보 테이블 승인 후 update
	public void updateStockInfoStatusWhenApprovalSuccess(StockVO vo) {
		sqlsession.insert(NAMESPACE+"updateStockInfoStatusWhenApprovalSuccess",vo);
	}
	
	@Override
	// 창고 입출고 선택한 요소 배열로 받아서 Map에 넣고 update
	public void updateStockInfoStatusWhenCancel(String[] identifyCode) {
		Map<String,Object> idCodeMap = new HashMap<String, Object>();
		idCodeMap.put("identifyCode", identifyCode);
		sqlsession.update(NAMESPACE+"updateStockInfoStatusWhencancel", idCodeMap);
	}
	
	@Override
	public String getWarehouseUseStatusByWarehouseNO(StockVO vo) {
//		logger.debug("조회한 창고 상태 : "+sqlsession.selectOne(NAMESPACE+"warehouseUseStatusByWarehouseNO",vo));
		return sqlsession.selectOne(NAMESPACE+"getwarehouseUseStatusByWarehouseNO",vo);
	}
	
	@Override
	// 창고 번호에 해당하는 사용여부상태 변경
	public void updateWarehouseUseStatus(StockVO vo) {
		sqlsession.update(NAMESPACE+"updateWarehouseUseStatus", vo);
	}

	@Override
	// 창고 조회
	public List<StockVO> getStockList() {
		return sqlsession.selectList(NAMESPACE+"getStockList");
	}

	@Override
	// 창고 리스트 총갯수(검색어 x, 필터 x) - 페이징
	public int getStockTotalCount() {
		return sqlsession.selectOne(NAMESPACE+"getStockTotalCount");
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 x, 필터 x) - 페이징
	public List<StockVO> getStockList(Criteria cri) {
		return sqlsession.selectList(NAMESPACE+"getStockListAll", cri);
	}

	@Override
	// 창고 리스트 총갯수(검색어 o, 필터 o) - 페이징
	public int findStockList(Map<String, Object> params) {
		return sqlsession.selectOne(NAMESPACE+"getFindStockListCount", params);
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 o, 필터 o) - 페이징
	public List<StockVO> getFindStockListCount(Map<String, Object> params) {
		return sqlsession.selectList(NAMESPACE+"findStockList", params);
	}

	@Override
	// 재미있다 선입선출!
	public List<StockVO> getStockOrderByExpiryDateList() {
		return sqlsession.selectList(NAMESPACE+"selectStockOrderByExpiryDate");
	}
}

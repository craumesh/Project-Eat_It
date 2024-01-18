package com.eatit.warehouseService;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.machinePersistence.machineDAO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;
import com.eatit.warehousePersistence.WarehouseDAO;

@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseServiceImpl.class);
	
	@Inject
	private WarehouseDAO warehousedao;
	
	
	@Inject
	private machineDAO mDao;
	
	@Override
	// 창고 정보 리스트 가져오기(All)
	public List<WarehouseVO> warehouseListAll() {
		logger.debug("S - warehouseListAll() 호출");
		return warehousedao.getWarehouseListAll();
	}

	@Override
	// 회원 정보 리스트 가져오기(All)
	public List<MemberVO> memberListAll() {
		return warehousedao.getMemberListAll();
	}

	@Override
	// 회원 직책 리스트 가져오기 - ajax
	public List<String> memberGetPositionName() {
		return warehousedao.getPositionName();
	}

	@Override
	// 직책에 해당하는 회원이름 리스트 가져오기 - ajax
	public List<String> getMembersOfposition(String position_name) {
		return warehousedao.getMembersOfPosition(position_name);
	}
	
	@Override
	// 이름에 해당하는 회원정보 리스트 가져오기 - ajax
	public List<MemberVO> getMemberInfoByName(String name) {
		return warehousedao.getMemberInfoByName(name);
	}

	@Override
	// 창고 정보 가져오기(main)
	public List<WarehouseVO> warehouseListMain() {
		logger.debug("S - warehouseListMain() 호출");
		return warehousedao.getWarehouseListMain();
	}

	@Override
	// 특정 창고 정보 가져오기 - ajax
	public WarehouseVO warehouseInfo(WarehouseVO vo) {
		logger.debug("S - warehouseInfo(WarehouseVO vo) 호출");
		logger.debug("S vo : " +vo);
		logger.debug("S 전달해주는 : "+warehousedao.getWarehouseInfo(vo));
		return warehousedao.getWarehouseInfo(vo);
	}

	@Override
	// 창고 등록 할 때 등록페이지에 로그인한 회원 정보 가져오기
	public MemberVO warehouseInfo(int no) {
		logger.debug("S - warehouseInfo(int no)");
		return warehousedao.getWarehouseInfo(no);
	}

	@Override
	// 창고 등록
	public void warehouseRegist(WarehouseVO vo) {
		logger.debug("S - warehouseRegist(WarehouseVO vo)");
		warehousedao.insertWarehouse(vo);
	}

	@Override
	// 창고 수정
	public void warehouseUpdate(WarehouseVO vo) {
		warehousedao.updateDetailInfo(vo);
	}

	@Override
	// 창고 삭제
	public void deleteWarehouse(int[] warehouse_no) {
		logger.debug("S - deleteWarehouse(int[] warehouse_no)");
		warehousedao.deleteWarehouse(warehouse_no);
	}
	
	//-----------------------------------------------------------------------------------------//
	// 창고 재고 식별 번호 조회 로직
	// 식별 번호 생성 규칙 : 발주회사번호+품목코드+생산년월일+순번
	private void getStockList() {
		// 완재품 - 필요 데이터 리스트 불러오기
	    List<StockInfoVO> finishedProductStockList = warehousedao.getStockOfFinishedProduct();
//	    logger.debug("완재품 - 식별코드 넣기 전"+finishedProductStockList);
	    
	    // 자재 - 필요 데이터 리스트 불러오기
	    List<StockInfoVO> materialStockList = warehousedao.getStockOfMaterial();
//	    logger.debug("자재 - 식별코드 넣기 전"+materialStockList);
	    
	    // 필요한 변수 초기화
	    String finishedProductCompanyNo = null; // 완제품 회사번호
	    String finishedProductSeqNumber = null; // 완제품 순번
	    String materialCompanyNo = null; 		// 자재 회사번호
	    String materialSeqNumber = null;  		// 자재 순번
	    
	    // 완재품 입고 식별번호 생성
	    for (StockInfoVO finishedProductStockInfoVO : finishedProductStockList) {
	    	
	        // 기존 StockVO에 내용 넣기
	        StockInfoVO setStockVO = new StockInfoVO();
	        setStockVO.setHistory_no(finishedProductStockInfoVO.getHistory_no());
	        setStockVO.setCode(finishedProductStockInfoVO.getCode());
	        setStockVO.setCompany_no(finishedProductStockInfoVO.getCompany_no());
	        setStockVO.setWarehouse_no(finishedProductStockInfoVO.getWarehouse_no());
	        setStockVO.setIo_classification("입고");
	        setStockVO.setCategory(finishedProductStockInfoVO.getCategory());
	        setStockVO.setName(finishedProductStockInfoVO.getName());
	        setStockVO.setIo_quantities(finishedProductStockInfoVO.getIo_quantities());
	        setStockVO.setUnit(finishedProductStockInfoVO.getUnit());
	        setStockVO.setPrice(finishedProductStockInfoVO.getPrice());
	        setStockVO.setExpiry_date(finishedProductStockInfoVO.getExpiry_date());
	        setStockVO.setIo_date(finishedProductStockInfoVO.getIo_date());
	        
	    	// 발주회사번호
	        int companyNo = finishedProductStockInfoVO.getCompany_no();
	        String formatCompanyNo = String.format("%03d", companyNo);
	        finishedProductCompanyNo = formatCompanyNo;
	        
	        // 생산 날짜 포맷
	        SimpleDateFormat prodateFormat = new SimpleDateFormat("yyyyMMdd");
	        String ioDate = prodateFormat.format(finishedProductStockInfoVO.getIo_date());
	        
	        // 순번
        	//history_no 불러온다
        	int historyNO =  finishedProductStockInfoVO.getHistory_no();
        	//history_no 를 '000+hitory_no'형식으로 만든다
        	String FormathistoyNo = String.format("%04d", historyNO);
        	// 완제품 순번에 담는다
        	finishedProductSeqNumber = FormathistoyNo;
	        
	        // 식별 번호 생성 
	        String identify_code = finishedProductCompanyNo+finishedProductStockInfoVO.getCode()+"-"+ioDate+finishedProductSeqNumber;
	        setStockVO.setIdentify_code(identify_code);
	        
	        // 존재하지 않으면(같은 이름의 identify_code가 0개일 때) stock_info 테이블에 insert
	        if(warehousedao.countIdentifyCode(identify_code) == 0) {
	        	warehousedao.insertStockInfoList(setStockVO);
	        }
	        
	    }
	    
	    // 자재 입고 식별번호 생성
	    for(StockInfoVO materialStockInfo : materialStockList) {
	    	
	    	 // 기존 StockVO에 내용 넣기
	        StockInfoVO setStockVO = new StockInfoVO();
	        setStockVO.setHistory_no(materialStockInfo.getHistory_no());
	        setStockVO.setCode(materialStockInfo.getCode());
	        setStockVO.setCompany_no(materialStockInfo.getCompany_no());
	        setStockVO.setWarehouse_no(materialStockInfo.getWarehouse_no());
	        setStockVO.setIo_classification("입고");
	        setStockVO.setCategory(materialStockInfo.getCategory());
	        setStockVO.setName(materialStockInfo.getName());
	        setStockVO.setIo_quantities(materialStockInfo.getIo_quantities());
	        setStockVO.setUnit(materialStockInfo.getUnit());
	        setStockVO.setPrice(materialStockInfo.getPrice());
	        setStockVO.setExpiry_date(materialStockInfo.getExpiry_date());
	        setStockVO.setIo_date(materialStockInfo.getIo_date());
	        
	    	// 발주회사번호
	        int companyNo = materialStockInfo.getCompany_no();
	        String formatCompanyNo = String.format("%03d", companyNo);
	        materialCompanyNo = formatCompanyNo;
	        
	        // 생산 날짜 포메팅
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
	        String ioDate = dateFormat.format(materialStockInfo.getIo_date());
	        
	        // 순번
        	//history_no 불러온다
        	int historyNo =  materialStockInfo.getHistory_no();
        	//history_no 를 '000+hitory_no'형식으로 만든다
        	String FormathistoyNo = String.format("%04d", historyNo);
        	// 완제품 순번에 담는다
        	materialSeqNumber = FormathistoyNo;
	        
	        // 식별 번호 생성 
	        String identify_code = materialCompanyNo+materialStockInfo.getCode()+"-"+ioDate+materialSeqNumber;
	        setStockVO.setIdentify_code(identify_code);
	        
	        // 존재하지 않으면(같은 이름의 identify_code가 0개일 때) stock_info 테이블에 insert
	        if(warehousedao.countIdentifyCode(identify_code) == 0) {
	        	warehousedao.insertStockInfoList(setStockVO);
	        }
	    }
	}
	
	@Override
	public int getTotalCount() {
		return warehousedao.getTotalCount();
	}

	@Override
	public List<StockInfoVO> getStockInfoList(Criteria cri) {
		// 식별번호 생성과 동시에 insert 메서드 호출
		getStockList();
		// 리스트 불러오기
		return warehousedao.getStockInfo(cri);
	}

	@Override
	public int getFindCount(Map<String, Object> params) {
		return warehousedao.getFindCount(params);
	}
	
	@Override
	public List<StockInfoVO> findStockInfoList(Map<String, Object> params) {
		// 식별번호 생성과 동시에 insert 메서드 호출
		getStockList();
		// 리스트 불러오기
		return warehousedao.findStockInfoList(params);
	}

	@Override
	public void stockApprovalProcess(StockInfoVO infoVO) {
		
		// 식별코드에 해당하는 재고 입출고 정보 불러오기
		StockInfoVO stockInfoVO = warehousedao.getStockInfoByIdentifyCode(infoVO);
//		logger.debug("stockInfoVO : "+stockInfoVO);
		
		// 제품코드 추출
		String idCode = infoVO.getIdentify_code();
		String[] idCodeList = idCode.split("-");
		String resultIdCode = idCodeList[0].substring(3);
//		logger.debug("resultIdCode"+resultIdCode);
		infoVO.setCode(resultIdCode);
		stockInfoVO.setCode(resultIdCode);
//		logger.debug("서비스 -infoVO : "+infoVO);
		logger.debug("stockInfoVO : "+stockInfoVO);
		
		
		// -> 유통기한이 다른 상품은 상품이 같더라도 다른 상품이라 조건 따질 필요없이 바로 insert(현재 로직)
		// StockInfoVO에 불러온 정보를 StockVO에 넣음
		StockVO vo = new StockVO();
		vo.setProduct_code(stockInfoVO.getCode());
		vo.setIdentify_code(stockInfoVO.getIdentify_code());
		vo.setWarehouse_no(stockInfoVO.getWarehouse_no());
		vo.setCategory(stockInfoVO.getCategory());
		vo.setProduct_name(stockInfoVO.getName());
		vo.setProduct_unit(stockInfoVO.getUnit());
		vo.setExpiry_date(stockInfoVO.getExpiry_date());
		vo.setQuantity(stockInfoVO.getIo_quantities());
		logger.debug("vo :" +vo);
		
		
		// 입고!
		// insert 후 상태 update
		warehousedao.insertStockInfoIntoStock(vo);
		warehousedao.updateStockInfoStatusWhenApprovalSuccess(vo);
		
		// 식별코드에 대한 품목이름이 재고에 몇개 있는지 카운트 -> 개수 존재 여부에 따라 로직 처리
		int countStock = warehousedao.countStock(infoVO);
		logger.debug("countStock :"+countStock);
		// 해당 창고 번호의 사용여부(상태) 조회
		String warehouseUseStatus = warehousedao.getWarehouseUseStatusByWarehouseNO(vo);
		logger.debug("warehouseUseStatus :"+warehouseUseStatus);
		
		// 창고에 품목이 있고, 창고 상태가 'N'일때만 창고 상태 'Y'로 update
		if(countStock > 0 && "N".equals(warehouseUseStatus)) {
			warehousedao.updateWarehouseUseStatus(vo);
		}
		
//		// 출고!
//		List<StockVO> stockOrderByExpiryDateList = warehousedao.getStockOrderByExpiryDateList();
//		for(StockVO outVO : stockOrderByExpiryDateList) {
//			outVO
//		}
	}

	@Override
	// 창고 취소 처리
	public void stockCancelProcess(String[] identifyCode) {
		warehousedao.updateStockInfoStatusWhenCancel(identifyCode);
	}

	@Override
	// 창고 조회
	public List<StockVO> stockListALL() {
		return warehousedao.getStockList();
	}
	
	@Override
	// 창고 리스트 총갯수(검색어 x, 필터 x) - 페이징
	public int getStockTotalCount() {
		return warehousedao.getStockTotalCount();
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 x, 필터 x) - 페이징
	public List<StockVO> getStockListAll(Criteria cri) {
		// TODO Auto-generated method stub
		return warehousedao.getStockList(cri);
	}

	@Override
	// 창고 리스트 총갯수(검색어 o, 필터 o) - 페이징
	public int getFindStockListCount(Map<String, Object> params) {
		return warehousedao.findStockList(params);
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 o, 필터 o) - 페이징
	public List<StockVO> findStockList(Map<String, Object> params) {
		return warehousedao.getFindStockListCount(params);
	}
	
}

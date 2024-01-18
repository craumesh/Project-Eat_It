package com.eatit.warehouseService;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.businessPersistence.DeliveryDAO;
import com.eatit.businessPersistence.OrdersDAO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.productionDomain.production_warehouseVO;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;
import com.eatit.warehousePersistence.WarehouseDAO;

@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseServiceImpl.class);
	
	@Inject
	private WarehouseDAO wDao;
	
	@Inject
	private DeliveryDAO dDao;
	
	@Inject
	private OrdersDAO oDao;
	
	@Override
	// 창고 정보 리스트 가져오기(All)
	public List<WarehouseVO> warehouseListAll() {
		return wDao.getWarehouseListAll();
	}

	@Override
	// 회원 정보 리스트 가져오기(All)
	public List<MemberVO> memberListAll() {
		return wDao.getMemberListAll();
	}

	@Override
	// 회원 직책 리스트 가져오기 - ajax
	public List<String> memberGetPositionName() {
		return wDao.getPositionName();
	}

	@Override
	// 직책에 해당하는 회원이름 리스트 가져오기 - ajax
	public List<String> getMembersOfposition(String position_name) {
		return wDao.getMembersOfPosition(position_name);
	}
	
	@Override
	// 이름에 해당하는 회원정보 리스트 가져오기 - ajax
	public List<MemberVO> getMemberInfoByName(String name) {
		return wDao.getMemberInfoByName(name);
	}

	@Override
	// 창고 정보 가져오기(main)
	public List<WarehouseVO> warehouseListMain() {
		return wDao.getWarehouseListMain();
	}

	@Override
	// 특정 창고 정보 가져오기 - ajax
	public WarehouseVO warehouseInfo(WarehouseVO vo) {
		return wDao.getWarehouseInfo(vo);
	}

	@Override
	// 창고 등록 할 때 등록페이지에 로그인한 회원 정보 가져오기
	public MemberVO warehouseInfo(int no) {
		return wDao.getWarehouseInfo(no);
	}

	@Override
	// 창고 등록
	public void warehouseRegist(WarehouseVO vo) {
		wDao.insertWarehouse(vo);
	}

	@Override
	// 창고 수정
	public void warehouseUpdate(WarehouseVO vo) {
		wDao.updateDetailInfo(vo);
	}

	@Override
	// 창고 삭제
	public void deleteWarehouse(int[] warehouse_no) {
		wDao.deleteWarehouse(warehouse_no);
	}
	
	//-----------------------------------------------------------------------------------------//
	// 창고 재고 식별 번호 조회 로직
	// 식별 번호 생성 규칙 : 발주회사번호+품목코드+생산년월일+순번
	private void getStockList() {
		// 완재품 - 필요 데이터 리스트 불러오기
	    List<StockInfoVO> finishedProductStockList = wDao.getStockOfFinishedProduct();
//	    logger.debug("완재품 - 식별코드 넣기 전"+finishedProductStockList);
	    
	    // 자재 - 필요 데이터 리스트 불러오기
	    List<StockInfoVO> materialStockList = wDao.getStockOfMaterial();
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
	        String identify_code = finishedProductCompanyNo+finishedProductStockInfoVO.getCode()+"-I"+ioDate+finishedProductSeqNumber;
	        setStockVO.setIdentify_code(identify_code);
	        
	        // 존재하지 않으면(같은 이름의 identify_code의 갯수가 0개일 때) stock_info 테이블에 insert
	        if(wDao.countIdentifyCode(identify_code) == 0) {
	        	wDao.insertStockInfoList(setStockVO);
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
	        String identify_code = materialCompanyNo+materialStockInfo.getCode()+"-I"+ioDate+materialSeqNumber;
	        setStockVO.setIdentify_code(identify_code);
	        
	        // 존재하지 않으면(같은 이름의 identify_code의 갯수가 0개일 때) stock_info 테이블에 insert
	        if(wDao.countIdentifyCode(identify_code) == 0) {
	        	wDao.insertStockInfoList(setStockVO);
	        }
	    }
	}
	
	// 완제품 출고 - orderId 추출 메서드()
	private int extractOrderId(String identifyCode) {
        // 주어진 문자열에서 맨 뒤 4자리 숫자 추출하되, 앞에 붙은 0은 무시
        if (identifyCode != null && identifyCode.length() >= 4) {
            String last4Digits = identifyCode.substring(identifyCode.length() - 4);
            return Integer.parseInt(last4Digits); // 앞에 붙은 0 제거
        } else {
            // 문자열이 4자리 미만인 경우나 null인 경우 처리
            return 0;
        }
    }
	
	@Override
	public int getTotalCount() {
		return wDao.getTotalCount();
	}

	@Override
	public List<StockInfoVO> getStockInfoList(Criteria cri) {
		// 식별번호 생성과 동시에 insert 메서드 호출
		getStockList();
		// 리스트 불러오기
		return wDao.getStockInfo(cri);
	}

	@Override
	public int getFindCount(Map<String, Object> params) {
		return wDao.getFindCount(params);
	}
	
	@Override
	public List<StockInfoVO> findStockInfoList(Map<String, Object> params) {
		// 식별번호 생성과 동시에 insert 메서드 호출
		getStockList();
		// 리스트 불러오기
		return wDao.findStockInfoList(params);
	}

	@Override
	public void stockApprovalProcess(StockInfoVO infoVO) {
		
		// 식별코드에 해당하는 재고 입출고 정보 불러오기
		StockInfoVO stockInfoVO = wDao.getStockInfoByIdentifyCode(infoVO);
		logger.debug("식별코드에 해당하는 재고 입출고 내역- stockInfoVO : "+stockInfoVO);
		
		// 제품코드 추출
		String idCode = infoVO.getIdentify_code();
		String[] idCodeList = idCode.split("-");
		String resultIdCode = idCodeList[0].substring(3);
		infoVO.setCode(resultIdCode);
		stockInfoVO.setCode(resultIdCode);
//		logger.debug("서비스 -infoVO : "+infoVO);
//		logger.debug("stockInfoVO : "+stockInfoVO);
		
		// StockInfoVO에 불러온 정보를 StockVO에 넣음
		StockVO vo = new StockVO();
		vo.setProduct_code(stockInfoVO.getCode());
		vo.setIdentify_code(stockInfoVO.getIdentify_code());
		vo.setWarehouse_no(stockInfoVO.getWarehouse_no());
		vo.setIo_classification(stockInfoVO.getIo_classification());
		vo.setCategory(stockInfoVO.getCategory());
		vo.setProduct_name(stockInfoVO.getName());
		vo.setProduct_unit(stockInfoVO.getUnit());
		vo.setUnit_quantity(stockInfoVO.getUnit_quantity());
		vo.setExpiry_date(stockInfoVO.getExpiry_date());
		vo.setQuantity(stockInfoVO.getIo_quantities());
		logger.debug("vo :" +vo);
		
		// 입고 일때 
		if(vo.getIo_classification().equals("입고")) {
			
			// -> 유통기한이 다른 상품은 상품이 같더라도 다른 상품이라 조건 따질 필요없이 바로 입고(현재 로직)
			// insert 후 상태 update
			logger.debug("입고 동작!!");
			wDao.insertStockInfoIntoStock(vo);
			wDao.updateStockInfoStatusWhenApprovalSuccess(vo);
			
			// 식별코드에 대한 품목이름이 재고에 몇개 있는지 카운트 -> 개수 존재 여부에 따라 로직 처리
			int countStock = wDao.countStock(infoVO);
			
			// 해당 창고 번호의 사용여부(상태) 조회
			String warehouseUseStatus = wDao.getWarehouseUseStatusByWarehouseNO(vo);
			
			// 창고에 품목이 있고, 창고 상태가 'N'일때만 창고 상태 'Y'로 update
			if(countStock > 0 && warehouseUseStatus.equals("N")) {
				wDao.updateWarehouseUseStatus(vo);
			}
			logger.debug("입고 동작 완료!");
		}
		
		// 출고 일때
		if(vo.getIo_classification().equals("출고")) {
			logger.debug("출고 동작!!");
			
			// 출고 품목에 해당하는 재고 정보 불러오기
			List<StockVO> stockOrderByExpiryDateList = wDao.getStockOrderByExpiryDateList(vo.getProduct_code());
			
			// 완제품 출고일 경우
			if(vo.getCategory().equals("완제품")) {
				logger.debug("완제품 출고!");
				
				// 처리 상태 변경 - '대기중' => '승인'  
				wDao.updateStockInfoStatusWhenApprovalSuccess(vo);
				
				// 승인 시 배송, 주문 상태변경
				oDao.updateOrderStatusToReleaseComplete(extractOrderId(vo.getIdentify_code()));
				dDao.updateReleaseComplete(extractOrderId(vo.getIdentify_code()));
				
				// 유통기한 기준 선입선출 로직
			    // 리스트 크기 변수
			    int listSize = stockOrderByExpiryDateList.size();
			    // 정보 저장용 객체 초기화
			    StockVO setOutVO;
			    // 출고 품목에 해당하는 재고 정보 객체 초기화
			    StockVO getStockOutVO;
			    // 출고 수량 초기화 변수
			    int outQuantity = vo.getQuantity();
			    
			    for (int i = 0; i < listSize; i++) {
			    	
			        // 출고 품목에 해당하는 재고의 i번째 인덱스의 수량 StockVO 객체를 가져오기
			        getStockOutVO = stockOrderByExpiryDateList.get(i);
			        
			        // update 할 때 필요한 정보 저장용 객체
					setOutVO = new StockVO();
					
					// 출고수량 < 재고수량 일 때 ex) 50 < 60 => 60 - 50 (재고수량 - 출고수량)
					if(outQuantity < getStockOutVO.getQuantity()) {
						outQuantity = getStockOutVO.getQuantity()-outQuantity; 
						// 해당 재고 업데이트
						logger.debug("1.출고수량 < 재고수량");
						setOutVO.setQuantity(outQuantity);
						logger.debug("남은 재고 quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 업데이트!");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
						break;
					}
					
					// 출고수량 = 재고수량 일 때 ex) 50 == 50 => (재고수량 - 출고수량)
					if(outQuantity == getStockOutVO.getQuantity()) {
						outQuantity = getStockOutVO.getQuantity()-outQuantity; 
						// 해당 재고 삭제
						logger.debug("2.출고수량 == 재고수량");
						setOutVO.setQuantity(outQuantity);
						logger.debug("quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 다씀 업데이트");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
						break;
					}
					
					// 출고수량 > 재고수량 일 때 ex) 50 > 45 => 50 - 45 (출고수량 - 재고수량)
					if(outQuantity > getStockOutVO.getQuantity()) {
						outQuantity = outQuantity - getStockOutVO.getQuantity();
						// 해당 재고 업데이트
						logger.debug("3.출고수량 > 재고수량");
						setOutVO.setQuantity(0);
						logger.debug("남은 출고 quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 다씀 업데이트");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
					}
			    }
				
				logger.debug("완제품 출고 완료!");
			}
			
			// 자재 출고일 경우
			if(vo.getCategory().equals("자재")) {
				logger.debug("자재 출고!");
				
				// 생산 창고에 정보 insert 로직
				production_warehouseVO pdwVO = new production_warehouseVO();
				pdwVO.setProduct_name(vo.getProduct_name());
				pdwVO.setUnit(vo.getProduct_unit());
				pdwVO.setUnit_quantity(vo.getUnit_quantity());
				
				// 생산 창고에 수량에 대한 단위 계산
				String unitQuantity = vo.getUnit_quantity();
				// 숫자가 아닌 문자들을 공백으로 변경
				String intStrUnitQuantity = unitQuantity.replaceAll("[^0-9]", "");
				// 문자열 숫자로 형변환
				int IntUnitQuantity = Integer.parseInt(intStrUnitQuantity);
				// 자재 수량 * 단위에 대한 양 계산
				int totalQuantity = vo.getQuantity()*IntUnitQuantity*1000;
				// pdwVO에 set
				pdwVO.setTotal(totalQuantity);
				
				int NameCheck = wDao.selectNameCheck(vo);
				
				if(NameCheck >= 1) {
					pdwVO.setTotal(pdwVO.getTotal()+wDao.selectNameTotal(vo).getTotal());
					wDao.updateStockIntoPoductionWarehouse(pdwVO);
					logger.debug("생산 창고에 정보 update 완료!");
				} else {
					// 생산 창고에 정보 insert
					wDao.insertStockIntoPoductionWarehouse(pdwVO);
					logger.debug("생산 창고에 정보 insert 완료!");
				}
				// 처리 상태 변경 - '대기중' => '승인'  
				wDao.updateStockInfoStatusWhenApprovalSuccess(vo);
				
				// 유통기한 기준 선입선출 로직
			    // 리스트 크기 변수
			    int listSize = stockOrderByExpiryDateList.size();
			    // 정보 저장용 객체 초기화
			    StockVO setOutVO;
			    // 출고 품목에 해당하는 재고 정보 객체 초기화
			    StockVO getStockOutVO;
			    // 출고 수량 초기화 변수
			    int outQuantity = vo.getQuantity();
			    
			    for (int i = 0; i < listSize; i++) {
			    	
			        // 출고 품목에 해당하는 재고의 i번째 인덱스의 수량 StockVO 객체를 가져오기
			        getStockOutVO = stockOrderByExpiryDateList.get(i);
			        
			        // update 할 때 필요한 정보 저장용 객체
					setOutVO = new StockVO();
					
					// 출고수량 < 재고수량 일 때 ex) 50 < 60 => 60 - 50 (재고수량 - 출고수량)
					if(outQuantity < getStockOutVO.getQuantity()) {
						outQuantity = getStockOutVO.getQuantity()-outQuantity; 
						// 해당 재고 업데이트
						logger.debug("1.출고수량 < 재고수량");
						setOutVO.setQuantity(outQuantity);
						logger.debug("남은 재고 quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 업데이트!");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
						break;
						
					}
					
					// 출고수량 = 재고수량 일 때 ex) 50 == 50 => (재고수량 - 출고수량)
					if(outQuantity == getStockOutVO.getQuantity()) {
						outQuantity = getStockOutVO.getQuantity()-outQuantity; 
						// 해당 재고 삭제
						logger.debug("2.출고수량 == 재고수량");
						setOutVO.setQuantity(outQuantity);
						logger.debug("quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 다씀 업데이트");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
						break;
						
					}
					
					// 출고수량 > 재고수량 일 때 ex) 50 > 45 => 50 - 45 (출고수량 - 재고수량)
					if(outQuantity > getStockOutVO.getQuantity()) {
						outQuantity = outQuantity - getStockOutVO.getQuantity();
						// 해당 재고 업데이트
						logger.debug("3.출고수량 > 재고수량");
						setOutVO.setQuantity(0);
						logger.debug("남은 출고 quantity : "+outQuantity);
						setOutVO.setIdentify_code(getStockOutVO.getIdentify_code());
						logger.debug("업데이트할 재고수량에 해당하는 로트번호 : "+setOutVO.getIdentify_code());
						logger.debug("재고 다씀 업데이트");
						wDao.updateQuantity(setOutVO);
						logger.debug("재고 업데이트 완료!");
						
					}
			    }
				
				logger.debug("자재 출고 완료!");
			}
			logger.debug("출고 동작 완료!");
		}
	}

	@Override
	// 창고 취소 처리
	public void stockCancelProcess(String[] identifyCode) {
		wDao.updateStockInfoStatusWhenCancel(identifyCode);
	}

	@Override
	// 창고 조회
	public List<StockVO> stockListALL() {
		return wDao.getStockListALL();
	}
	
	@Override
	// 창고 리스트 총갯수(검색어 x, 필터 x) - 페이징
	public int getStockTotalCount() {
		return wDao.getStockTotalCount();
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 x, 필터 x) - 페이징
	public List<StockVO> getStockListAll(Criteria cri) {
		return wDao.getStockList(cri);
	}

	@Override
	// 창고 리스트 총갯수(검색어 o, 필터 o) - 페이징
	public int getFindStockListCount(Map<String, Object> params) {
		return wDao.findStockList(params);
	}
	
	@Override
	// 입출고 정보 테이블 모두 조회(검색어 o, 필터 o) - 페이징
	public List<StockVO> findStockList(Map<String, Object> params) {
		return wDao.getFindStockListCount(params);
	}

	@Override
	// 창고 재고 삭제
	public void deleteStock(String[] identifyCode) {
		logger.debug("Service - deleteStock(String[] identifyCode)");
		wDao.deleteStock(identifyCode);
	}
	
	
	
}

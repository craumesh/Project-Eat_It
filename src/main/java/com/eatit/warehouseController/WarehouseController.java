package com.eatit.warehouseController;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eatit.businessService.OrdersService;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;
import com.eatit.memberDomain.MemberVO;
import com.eatit.memberService.HumanResourceService;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehouseDomain.WarehouseVO;
import com.eatit.warehouseService.WarehouseService;

@Controller
@RequestMapping(value="/warehouse/*")
public class WarehouseController {
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseController.class);
	
	@Inject
	private WarehouseService warehouseService;
	
	@Inject
	private HumanResourceService hrService;
	
	@Inject OrdersService oService;
////////////////////////////////////////// 창고 메인 페이지 시작 ///////////////////////////////////////
	//http://localhost:8088/warehouse/warehouseMain
	@GetMapping(value = "/warehouseMain")
	public void warehouseMainGET(Model model,@SessionAttribute("no") int no, HttpSession session) {
		logger.debug("C - wareHouseMainGET() 호출");
		// ID 세션값 저장 확인
//		logger.debug("no : "+no);
		
		// 서비스 - 창고 리스트 가져오기
		List<WarehouseVO> warehouseListMain = warehouseService.warehouseListMain();
		
		// 서비스 - 회원 리스트 가져오기
		List<MemberVO> memberList = warehouseService.memberListAll();
		
		// 서비스 - 직책 정보 가져오기
		List<String> positionName = warehouseService.memberGetPositionName();
		
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("warehouseListMain", warehouseListMain);
		model.addAttribute("memberList", memberList);
		model.addAttribute("positionName", positionName);
	}
	
	// 창고 모달창에서 정보 수정
   @RequestMapping(value = "/updateDetailInfo", method = RequestMethod.POST)
   public String updateDetailInfo(WarehouseVO vo) {
      logger.debug("/warehouse/updateDetailInfo 호출 -> updateDetailInfo() 실행");
//      logger.debug("vo : "+vo);
      
      // 정보 수정
      warehouseService.warehouseUpdate(vo);
      
      return "redirect:/warehouse/warehouseMain";
   }
	
	// 창고등록
	@RequestMapping(value = "/warehouseRegist", method = RequestMethod.GET)
	public void warehouseModifyGET(@SessionAttribute("no") int no,Model model) {
//		logger.debug("C - warehouseModifyGET()");
//		logger.debug("no : "+ no);
		
		// 서비스 - 창고 등록 할 때 등록페이지에 로그인한 회원 정보 가져오기
		MemberVO warehouseInfo = warehouseService.warehouseInfo(no);
//		logger.debug("@_@"+warehouseInfo);
		// 데이터를 연결된 뷰페이지로 전달
		model.addAttribute("warehouseAdminInfo", warehouseInfo);
	}
	
	@RequestMapping(value = "/warehouseRegist", method = RequestMethod.POST)
	public String warehouseModifyPOST(WarehouseVO vo, RedirectAttributes rttr ) {
		logger.debug("C - warehouseModifyPOST()");
//		logger.debug("vo : "+vo);
		
		// 서비스 - 창고 등록
		warehouseService.warehouseRegist(vo);
		
		return "redirect:/warehouse/registClose";
	}
	
	// 창고삭제
	@RequestMapping(value = "/deleteWarehouse", method = RequestMethod.POST)
	public String deleteWarehousePOST(@RequestParam("chk") int[] warehouse_no) {
		logger.debug("C - deleteWarehousePOST()");
		logger.debug("vo : "+warehouse_no);
		
		// 서비스 - 창고 삭제
		warehouseService.deleteWarehouse(warehouse_no);
		
		return "redirect:/warehouse/warehouseMain";
	}
	
	// 등록 후 창닫기 전용 페이지
	@GetMapping(value = "/registClose")
	public void registClose() {
		logger.debug("C - registClose()");
	}
	
////////////////////////////////////////// 창고 메인 페이지 끝 /////////////////////////////////////////

	
////////////////////////////////////////// 재고 관련 페이지 시작 ////////////////////////////////////////////
	
	//http://localhost:8088/warehouse/stockMain
	// 창고 재고 페이지
	@RequestMapping(value = "/stockMain", method = RequestMethod.GET)
	public void warehouseStockMainGET(Model model, Criteria cri,
									  @RequestParam(name = "searchword", required = false) String searchword, 
									  @RequestParam(name = "filter", required = false) String filter, 
									  Map<String, Object> params) {
		
		// 페이지 사이즈 변경
		cri.setPageSize(13);
		List<StockVO> stockList;
		
		// 페이징
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(searchword == null && filter == null) {
			pageVO.setTotalCount(warehouseService.getStockTotalCount());
			stockList = warehouseService.getStockListAll(cri);
		}else {
			params.put("cri", cri);
			params.put("searchword", searchword);
			params.put("filter", filter);
			pageVO.setTotalCount(warehouseService.getFindStockListCount(params));
			stockList = warehouseService.findStockList(params);
		}
		model.addAttribute("listUrl", "stockMain");
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("stockList", stockList);
	}
	
	@PostMapping(value = "/stockMain")
	public String warehouseStockMainPOST(StockInfoVO infoVO,
										 @RequestParam(name="searchword", required = false) String searchword,
										 @RequestParam(name="filter", required = false) String filter
										 ) {
		
		return "redirect:/warehouse/stockMain";
	}
	
	@GetMapping(value = "/stockInfo")
	public void stockInfoGET(Model model, Criteria cri,
							@RequestParam(name = "searchword", required = false) String searchword, 
							@RequestParam(name = "filter", required = false) String filter,
							@RequestParam(name = "page", required = false) String page,
							 Map<String, Object> params) {
//		logger.debug("C - stockInfoGET()");
//		logger.debug("Getpage : "+page);
//		logger.debug("cri :"+cri);
		
		
		// 페이지 사이즈 변경
		cri.setPageSize(13);
		List<StockInfoVO> stockInfoList;
		
		// 페이징
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(searchword == null && filter == null) {
			pageVO.setTotalCount(warehouseService.getTotalCount());
			stockInfoList = warehouseService.getStockInfoList(cri);
		}else {
			params.put("cri", cri);
			params.put("searchword", searchword);
			params.put("filter", filter);
			pageVO.setTotalCount(warehouseService.getFindCount(params));
			stockInfoList = warehouseService.findStockInfoList(params);
		}
		
		// 데이터전달
		model.addAttribute("page",page);
		model.addAttribute("listUrl", "stockInfo");
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("stockInfoList",stockInfoList);
	}
	
	@PostMapping(value = "/stockInfo")
	public String stockInfoPOST(StockInfoVO infoVO,
								@RequestParam(name="searchword", required = false) String searchword,
								@RequestParam(name="filter", required = false) String filter,
								@RequestParam(name="page", required = false) String page) {
//		logger.debug("Postpage : "+page);
//		logger.debug("infoVO : "+infoVO);
		
	    warehouseService.stockApprovalProcess(infoVO);
	    
	    return "redirect:/warehouse/stockInfo?page="+page;
	}
	
	@PostMapping(value = "/cancelStockInfo")
	public String cancelStockInfo(@RequestParam("chk") String[] identifyCode,
								  @RequestParam(name="page", required = false) String page) {
		logger.debug("C - stockInfoPOST()");
		logger.debug("identifyCode"+identifyCode);
		
		warehouseService.stockCancelProcess(identifyCode);
		
		return "redirect:/warehouse/stockInfo?page="+page;
	}
	
////////////////////////////////////////// 재고 페이지 끝 //////////////////////////////////////////////
	
	
	
}

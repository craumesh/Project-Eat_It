package com.eatit.productionController;

import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessService.OrdersService;
import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.machineService.machineservice;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionVO;
import com.eatit.productionDomain.production_warehouseVO;
import com.eatit.productionDomain.productionhistoryVO;
import com.eatit.productionService.productionservice;
import com.eatit.warehouseDomain.StockInfoVO;
import com.eatit.warehouseDomain.StockVO;
import com.eatit.warehousePersistence.WarehouseDAO;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/production/*")
public class productioncontroller {

	
	private static final Logger logger = LoggerFactory.getLogger(productioncontroller.class);
	
	@Inject
	private productionservice pdService;
	
	@Inject
	private machineservice mcService;
	
	@Inject
	private OrdersService oService;
	
	@Inject
	private WarehouseDAO dao;
	
	// http://localhost:8088/production/production
	@RequestMapping(value = "/production", method = RequestMethod.GET)
	public void productionGET(Model model, Criteria cri) {
		logger.debug("pdService.machinelistall() : " + pdService.machinelistall(cri));
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(pdService.machinetotalCount());
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("listUrl", "production");
		model.addAttribute("machinelist",pdService.machinelistall(cri));
		
		
	}
	
	// 자재 요청
	@RequestMapping(value = "/request", method = RequestMethod.GET)
	public void requestGET() {
		logger.debug("request() 페이지 이동");
	}
	
	@RequestMapping(value = "/request", method = RequestMethod.POST)
	public String requestPOST(@RequestParam(name = "materialGroup", required = false) String[] materialGroup,
							  @RequestParam(name = "requiredGroup", required = false) int[] requiredGroup,
							  StockInfoVO vo) {

		
		if(Arrays.toString(materialGroup)!= null && Arrays.toString(requiredGroup) != null) {
			for(int i=0; i<materialGroup.length; i++) {
				logger.debug(" :"+materialGroup[i]);
				logger.debug(" :"+requiredGroup[i]);
				logger.debug("조회한 데이터 : "+pdService.nameproduct_no(materialGroup[i]));
				logger.debug("창고 데이터" + pdService.stockname(materialGroup[i]));
				
				// StockInfoVO 객체 생성
				StockInfoVO setStockVO = new StockInfoVO();
				StockVO stockVO = pdService.stockname(materialGroup[i]);
				masterdata_informationVO infoVO = pdService.nameproduct_no(materialGroup[i]);
				
				// 현재 날짜와 시간을 가져옴
		        LocalDate currentDate = LocalDate.now();
		        LocalDateTime now = LocalDateTime.now();
		        Timestamp timestamp = Timestamp.valueOf(now);
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		        
				
				// 식별 코드 생성
				int companyNo = infoVO.getProduct_no();
				String formatCompanyNo = String.format("%03d", companyNo);
				/* SimpleDateFormat prodateFormat = new SimpleDateFormat("yyyyMMdd"); */
				String orderDate = currentDate.format(formatter);
				String formatorderId = String.format("%04d", companyNo);
				
				String identify_code = formatCompanyNo+ stockVO.getProduct_code() + "-O" + orderDate + formatorderId;
				
				logger.debug("생성된 식별코드 : "+identify_code);
				
				// siVO에 정보 담기
				setStockVO.setIdentify_code(identify_code);
				setStockVO.setWarehouse_no(stockVO.getWarehouse_no());
				setStockVO.setIo_classification("출고");
				setStockVO.setCategory(stockVO.getCategory());
				setStockVO.setName(materialGroup[i]);
				setStockVO.setIo_quantities(requiredGroup[i]);
				setStockVO.setUnit(stockVO.getProduct_unit());
				setStockVO.setPrice((infoVO.getPrice()*requiredGroup[i])/10000);
				setStockVO.setExpiry_date(stockVO.getExpiry_date());
				setStockVO.setIo_date(timestamp);

				pdService.nameproduct_no(materialGroup[i]); // 자재 이름으로 조회한 마스터데이터
				pdService.stockname(materialGroup[i]); // 이름으로 조회한 창고 정보
				
				dao.insertStockInfoList(setStockVO);
			}
		}
		
		 return "redirect:/warehouse/registClose";
	}
	
	@RequestMapping(value = "/getrequest", method = RequestMethod.GET)
	@ResponseBody
	public List<masterdata_informationVO> requrstGET() {
		
		logger.debug("requestGET() 페이지 이동");
		logger.debug("category() : " +pdService.category());
		
		return pdService.category();
		}
	
	
	@RequestMapping(value = "/status", method = RequestMethod.GET)
	public void statusGET(@RequestParam("code") int code, Model model) {
		logger.debug("code : " +code);
		logger.debug("mcService.productstatus(code) : " + mcService.productstatus(code));
		logger.debug("mcService.machineinfo(code) : " + mcService.machineinfo(code));
		
		model.addAttribute("infolist",mcService.machineinfo(code));
		model.addAttribute("status",mcService.productstatus(code));
		
		logger.debug("statusGET() 페이지 이동");
	}
	
	@RequestMapping(value = "/productioninfo", method = RequestMethod.GET)
	public void productioninfo(@RequestParam("machine_code") int machineCode, Model model) {
	    machineVO status = mcService.productstatus(machineCode);
	    logger.debug("status : " +status);
	    model.addAttribute("status", status);

	}
	
	@RequestMapping(value = "/production", method = RequestMethod.POST)
	public String productioninfo(productionhistoryVO vo, @RequestParam("EXP_intervar") Integer EXP_intervar) {
		
		logger.debug("생산완료");
		logger.debug("EXP_intervar : " + EXP_intervar);
		logger.debug("productionhistoryVO : " + vo);
		
		vo.setEXP_intervar(EXP_intervar);
		pdService.productionhistory(vo);
		
		int machine_code = vo.getMachine_code();
		
		pdService.update_machine(machine_code);
		pdService.update_machinehistory(machine_code);
			
		return "redirect:/warehouse/registClose";
	}
	
	
	// 발주 내역 조회 - GET
		@RequestMapping(value = "/orderform", method = RequestMethod.GET)
		public void orderListGET(Model model, Criteria cri) {

			List<OrdersVO> ordersVOList;
			PageVO pageVO = new PageVO();
			pageVO.setCri(cri);
			pageVO.setTotalCount(oService.selectproductcount());
			
			ordersVOList = oService.selectproduct(cri);

			// 데이터 전달
			model.addAttribute(pageVO);
			model.addAttribute("productionUrl", "orderform");
			model.addAttribute(ordersVOList);
			
		}
	
		@RequestMapping(value = "/getorderform", method = RequestMethod.GET )
		@ResponseBody
		public Map<String, Object> getorderform(@RequestParam("order_id")Integer order_id,
									 @RequestParam("product_no")Integer product_no) throws Exception {
			Map<String, Object> pram = new HashMap<String, Object>();
			
			logger.debug("pdService.recipe(product_no) : " +pdService.recipe(product_no));

			
			String recipe = pdService.recipe(product_no);
			
			Gson gson = new Gson();
			
			Map<String, Map<String, Integer>> outerMap = gson.fromJson(recipe, Map.class);
			
			String key = String.valueOf(product_no);
			Map<String, Integer> innerMap = outerMap.get(key);
			
			logger.debug("innerMap"+innerMap);
			
			Map<String, Object> material = new HashMap<String, Object>();
			
			
			for(String innerMapkey : innerMap.keySet()) {
				logger.debug(innerMapkey + "/" + innerMap.get(innerMapkey));
				
				material.put(innerMapkey, pdService.production_warehouse(innerMapkey).getTotal());
				
			}
			
			logger.debug("material : "+material);
			
			pram.put("recipe", pdService.recipe(product_no));
			pram.put("machine", mcService.machinecategory());
			pram.put("Detail", oService.getOrderDetail(order_id));
			pram.put("house", material);
			
			return pram;
			
		}
		
		@RequestMapping(value = "/orderform", method = RequestMethod.POST)
		public String registerEquipment(productionVO pvo, machinehistoryVO hvo, machineVO mvo,
										
										@RequestBody Map<String, Object> requestData, 
										@RequestParam("orderId") Integer order_id, 
										@RequestParam("machineCode") Integer machine_code,
										@RequestParam("quantity") Integer quantity) {
		    List<Map<String, String>> recipeDataList = (List<Map<String, String>>) requestData.get("recipeData");
		    
		  
		    
		    
		    pvo.setMachine_code(machine_code);
		    hvo.setMachine_code(machine_code);
		    mvo.setMachine_code(machine_code);
		    mvo.setOrder_id(order_id);
		    
		    
		    for (Map<String, String> recipeData : recipeDataList) {
		        String materialGroup = (String) recipeData.get("materialGroup");
		        String requiredGroup = recipeData.get("requiredGroup");

		    if (materialGroup != null && !materialGroup.isEmpty() && !requiredGroup.isEmpty()) {
		        logger.debug("materialGroup: " + materialGroup);
		        logger.debug("requiredGroup: " + Integer.valueOf(requiredGroup));
		        
		        production_warehouseVO vo = new production_warehouseVO();
		        vo.setProduct_name(materialGroup);
		        vo.setTotal(Integer.valueOf(requiredGroup));
		        
		        
		        logger.debug("vo : " + vo);
		        pdService.updatehouse(vo);
		    }
		   }
		    pdService.start(pvo);
		    pdService.startproduction(hvo);
		    pdService.start_machine(mvo);
		    oService.startProduction(order_id);
		    
		    return "redirect:/warehouse/registClose";
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}

package com.eatit.productionController;

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
import com.eatit.machineService.machineservice;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionhistoryVO;
import com.eatit.productionService.productionservice;

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
	public void request() {
		logger.debug("request() 페이지 이동");
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
			
			
			pram.put("recipe", pdService.recipe(product_no));
			pram.put("machine", mcService.machinecategory());
			pram.put("Detail", oService.getOrderDetail(order_id));
			
			return pram;
			
		}
}

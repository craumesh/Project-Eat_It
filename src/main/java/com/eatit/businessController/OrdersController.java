package com.eatit.businessController;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessDomain.ProductVO;
import com.eatit.businessService.OrdersService;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;
import com.eatit.masterdataDomain.CompanyVO;
import com.eatit.memberDomain.MemberVO;

@Controller
@RequestMapping(value = "/orders/*")
public class OrdersController {
	
	private static final Logger logger = LoggerFactory.getLogger(OrdersController.class);
	
	@Inject
	private OrdersService oService;
	
	// 발주 내역 조회 - GET
	@RequestMapping(value = "/lists", method = RequestMethod.GET)
	public void orderListGET(Model model, Criteria cri, 
							 @RequestParam(name = "query", required = false) String query, 
							 @RequestParam(name = "filter", required = false) String filter, 
							 Map<String, Object> params) {

		List<OrdersVO> ordersVOList;
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(query == null && filter == null) {
			logger.debug("Controller: /orders/lists/orderListGET(model)");
			pageVO.setTotalCount(oService.getTotalCount());
			ordersVOList = oService.getOrderList(cri);
		}else {
			logger.debug("Controller: /orders/lists/orderListGET(model, query, filter)");
			params.put("cri", cri);
			params.put("query", query);
			params.put("filter", filter);
			pageVO.setTotalCount(oService.getFindCount(params));
			ordersVOList = oService.findOrderList(params);
		}

		// 데이터 전달
		model.addAttribute(pageVO);
		model.addAttribute("pageUrl", "lists");
		model.addAttribute(ordersVOList);
	}
	
	// 주문 신청 - GET
	@RequestMapping(value = "/forms", method = RequestMethod.GET)
	public void orderAddGET(Model model, HttpSession session) {
		
		logger.debug("Controller: /orders/forms/orderAddGET(model, session)");
	
		// 로그인 정보 
		String id = (String)session.getAttribute("id");
		
		// 서비스 - 회원정보 조회
		MemberVO memberVO = oService.getMemberInfo(id);
		
		// 데이터 전달
		model.addAttribute(memberVO);	
	}
	
	// 주문 신청 - POST
	@RequestMapping(value = "/forms", method = RequestMethod.POST)
	public String orderAddPOST(OrdersVO ovo, RedirectAttributes rttr) {
		
		logger.debug("Controller: /orders/forms/orderAddPOST(ovo) 호출");
		
		// 서비스 - 신청서 작성 동작 호출(INSERT)
		oService.addOrder(ovo);
		
		rttr.addFlashAttribute("result", "CREATEOK");
		
		// 페이지 이동
		return "redirect:/orders/lists";
	}
	
	// 주문  상세 - GET
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	@ResponseBody
	public OrdersVO orderDetailGET(@RequestParam("order_id")Integer order_id) {
		
		logger.debug("Controller: /orders/orderDetailGET(order_id)");
		
		return oService.getOrderDetail(order_id);
	}
	
	// 거래처 검색 - GET
	@RequestMapping(value = "/companys", method = RequestMethod.GET)
	public void companyFindGET(Model model, Criteria cri,
							   @RequestParam(name = "query", required = false) String query, 
							   @RequestParam(name = "filter", required = false) String filter, 
							   Map<String, Object> params) throws Exception {
		
		List<CompanyVO> companyVOList;
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(query == null && filter == null) {
			// 검색어가 입력되지 않았을 때, 새로 창을 열었을 때
			logger.debug("Controller: /orders/companys/companyFindGET(model)");
			pageVO.setTotalCount(oService.getTotalCompanyCount());
			companyVOList = oService.getCompanyList(cri);
		}else {
			// 검색어가 입력되었을 때, 필터가 설정 되었을 때
			logger.debug("Controller: /orders/companys/companyFindGET(model, query, filter)");
			params.put("cri", cri);
			params.put("query", query);
			params.put("filter", filter);
			pageVO.setTotalCount(oService.getMatchingCompanyCount(params));
			companyVOList = oService.findCompany(params);
		}
		
		// 데이터 전달
		model.addAttribute(pageVO);
		model.addAttribute("pageUrl", "companys");
		model.addAttribute(companyVOList);
	}
	
	// 거래처 선택 - POST
	@RequestMapping(value = "/companySelect", method = RequestMethod.POST)
	@ResponseBody
	public CompanyVO companySelectPOST(@RequestParam(name = "company_no") Integer company_no) {
		
		logger.debug("Controller: /orders/selectCompany(company_no)");
		
		// 데이터 저장
		CompanyVO companyVO = oService.selectCompany(company_no);
		
		return companyVO;
	}
	
	// 상품 검색 - GET
	@RequestMapping(value = "/products", method = RequestMethod.GET)
	public void productFindGET(Model model, Criteria cri,
							   @RequestParam(name = "query", required = false) String query,
							   @RequestParam(name = "filter", required = false) String filter, 
							   Map<String, Object> params) {
		
		List<ProductVO> productVOList;
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(query == null && filter == null) {
			// 검색어가 입력되지 않았을 때, 새로 창을 열었을 때
			logger.debug("Controller: /orders/products/productFindGET(model)");
			pageVO.setTotalCount(oService.getTotalProductCount());
			productVOList = oService.getProductList(cri);
		}else {
			// 검색어가 입력되었을 때
			logger.debug("Controller: /orders/products/productFindGET(model, query)");
			params.put("cri", cri);
			params.put("query", query);
			params.put("filter", filter);
			pageVO.setTotalCount(oService.getMatchingProductCount(params));
			productVOList = oService.findProduct(params);
		}
		
		logger.debug("productVOList: " + productVOList.size());
		// 데이터 전달
		model.addAttribute(pageVO);
		model.addAttribute("pageUrl", "products");
		model.addAttribute(productVOList);
	} 
	
	// 상품 선택 - POST
	@RequestMapping(value = "/productSelect", method = RequestMethod.POST)
	@ResponseBody
	public ProductVO productSelectPOST(@RequestParam(name = "product_no") Integer product_no) {
		
		logger.debug("Controller: /orders/productSelectPOST(product_no)");
		
		// 서비스
		ProductVO productVO = oService.selectProduct(product_no);
		
		logger.debug("productVO: " + productVO);
		
		return productVO;
	} 
	
	// 발주서 수정 - POST
	@RequestMapping(value = "/editForm", method = RequestMethod.POST)
	public String editFormPOST(OrdersVO ovo, RedirectAttributes rttr) {
		
		logger.debug("/orders/editFormPOST() 호출");
		
		// 수정할 정보 확인
		logger.debug("ovo: " + ovo);
		
		// 서비스 - 신청서 수정 동작 호출(UPDATE)
		oService.editForm(ovo);
		rttr.addFlashAttribute("result", "modifyOK");
		
		return "redirect:/orders/orderList";
	}
	
	// 발주서 삭제 - POST
	@RequestMapping(value = "/cancelForm", method = RequestMethod.POST)
	public String cancelFormPOST(@RequestParam("order_id")int order_id) {
		
		logger.debug("/orders/cancelFormPOST() 호출");
		
		// 서비스 - 발주서 삭제 동작 호출(DELETE)
		oService.cancelForm(order_id);
		
		return "redirect:/orders/orderList";
	}
}

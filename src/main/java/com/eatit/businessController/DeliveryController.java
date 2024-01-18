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

import com.eatit.businessDomain.DeliveryVO;
import com.eatit.businessDomain.OrdersVO;
import com.eatit.businessService.DeliveryService;
import com.eatit.businessService.OrdersService;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;
import com.eatit.memberDomain.MemberVO;

@Controller
@RequestMapping(value = "/deliverys/*")
public class DeliveryController {

	private static final Logger logger = LoggerFactory.getLogger(DeliveryController.class);	
	
	@Inject
	private DeliveryService dService;
	
	@Inject
	private OrdersService oService;
	
	// 배송 목록 조회 - GET
	@RequestMapping(value = "/lists", method = RequestMethod.GET)
	public void deliveryListGET(Model model, Criteria cri, 
							 @RequestParam(name = "query", required = false) String query, 
							 @RequestParam(name = "filter", required = false) String filter, 
							 Map<String, Object> params) {

		List<DeliveryVO> deliveryVOList;
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		
		if(query == null && filter == null) {
			logger.debug("Controller: /deliverys/lists/deliveryListGET(model)");
			pageVO.setTotalCount(dService.getTotalDeliveryCount());
			deliveryVOList = dService.getDeliveryList(cri);
		}else {
			logger.debug("Controller: /deliverys/lists/deliveryListGET(model, query, filter)");
			params.put("cri", cri);
			params.put("query", query);
			params.put("filter", filter);
			pageVO.setTotalCount(dService.getMatchingDeliveryCount(params));
			deliveryVOList = dService.getMatchingDeliveryList(params);
		}

		// 데이터 전달
		model.addAttribute(pageVO);
		model.addAttribute("pageUrl", "lists");
		model.addAttribute(deliveryVOList);
	}	

	// 출고 요청 - GET
	@RequestMapping(value = "/forms", method = RequestMethod.GET)
	public void releaseRequestGET(Model model, HttpSession session,
								   @RequestParam(name = "order_id") Integer order_id) {
		
		logger.debug("Controller: /deliverys/forms/releaseRequestGET(model, order_id)");
		
		String id = (String)session.getAttribute("id");
		MemberVO memberVO = dService.getMemberInfo(id);
		OrdersVO ordersVO = oService.getOrderDetail(order_id);
	
		logger.debug("ordersVO: " + ordersVO);
		
		model.addAttribute(memberVO);
		model.addAttribute(ordersVO);
	}
	
	// 출고 요청 - POST
	@RequestMapping(value = "/forms", method = RequestMethod.POST)
	public String releaseRequestPOST(DeliveryVO dvo, RedirectAttributes rttr,
									@RequestParam(name = "order_id") Integer order_id) {
		
		logger.debug("Controller: /deliverys/forms/deliveryRequestPOST()");
		
		dService.requestDelivery(dvo);
		dService.requestRelease(order_id);
		oService.changeOrderStatusToShippingPreparation(order_id);
		
		rttr.addFlashAttribute("result", "CREATEOK");
		
		return "redirect:/warehouse/registClose";
	}
	
	// 배송 요청 - GET 
	@RequestMapping(value = "/ships", method = RequestMethod.GET)
	public void deliveryRequestGET(Model model, HttpSession session,
			   					   @RequestParam(name = "delivery_id") Integer delivery_id) {
		
		logger.debug("Controller: /deliverys/forms/deliveryRequestGET(model, delivery_id)");
		
		String id = (String)session.getAttribute("id");
		MemberVO memberVO = dService.getMemberInfo(id);
		DeliveryVO deliveryVO = dService.getDeliveryDetail(delivery_id);
		
		model.addAttribute(memberVO);
		model.addAttribute(deliveryVO);
	}
	
	// 배송 요청 - POST
	@RequestMapping(value = "/ships", method = RequestMethod.POST)
	public String deliveryRequestPOST(RedirectAttributes rttr, 
			                          @RequestParam(name = "delivery_id") Integer delivery_id,
			                          @RequestParam(name = "employee_no") Integer employee_no,
			                          Map<String, Object> params) {
		
		logger.debug("Controller: /deliverys/forms/deliveryRequestPOST(dvo, rttr)");
		
		params.put("delivery_id", delivery_id);
		params.put("employee_no", employee_no);
		dService.startDelivery(params);
		oService.updateOrderStatusToDelivering(delivery_id);
		
		return "redirect:/warehouse/registClose";
	}
	
	// 배송완료 - POST
	@RequestMapping(value = "/success", method = RequestMethod.POST)
	@ResponseBody
	public void deliveryCompletePost(@RequestParam(name = "delivery_id") Integer delivery_id) {
		
		logger.debug("Controller: /deliverys/deliveryCompletePost(delivery_id)");
		
		dService.completeDelivery(delivery_id);
		oService.completeOrder(delivery_id);	
	}
	
}

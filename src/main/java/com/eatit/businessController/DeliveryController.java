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
	@RequestMapping(value = "forms", method = RequestMethod.GET)
	public void deliveryRequestGET(Model model, HttpSession session,
								   @RequestParam(name = "order_id") Integer order_id) {
		
		logger.debug("deliveryRequestGET(model, session)");
		
		String id = (String)session.getAttribute("id");
		MemberVO memberVO = dService.getMemberInfo(id);
		OrdersVO ordersVO = oService.getOrderDetail(order_id);
	
		logger.debug("ordersVO: " + ordersVO);
		
		model.addAttribute(memberVO);
		model.addAttribute(ordersVO);
	}
	
}

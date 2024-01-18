package com.eatit.warehouseController;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.WarehouseVO;
import com.eatit.warehouseService.WarehouseService;

@RestController
public class WarehouseAjaxController {

	private static final Logger logger = LoggerFactory.getLogger(WarehouseController.class);
	
	@Inject
	private WarehouseService warehouseService;
	
	@RequestMapping(value = "/warehouseContent", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public WarehouseVO wareContentGET(WarehouseVO vo) {
		logger.debug("C - wareContentGET() 실행 ");
//		logger.debug("vo : "+vo);
		
		// 창고 상세 정보
		return warehouseService.warehouseInfo(vo);
	}
	
	@GetMapping(value = "/wareUpdateDetailInfo", produces = "application/json;charset=UTF-8")
	public List<String> wareUpdateDetailInfo(@RequestParam("position_name") String position_name) {
		logger.debug("C - wareUpdateDetailInfo()");
		logger.debug("position_name :"+position_name);
		
		// 직책에 맞는 회원이름 리스트 가져오기
		return warehouseService.getMembersOfposition(position_name);
	}
	
	@RequestMapping(value = "/updateDetailInfoByName", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<MemberVO> memberInfo(@RequestParam("info") String name){
		logger.debug("name : "+name);
		
		// 이름에 해당하는 맴버 정보 가져오기
		return warehouseService.getMemberInfoByName(name);
	}
}

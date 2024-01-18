package com.eatit.MaterialController;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eatit.MaterialDomain.materialaddVO;
import com.eatit.MaterialDomain.MaterialOrderVO;
import com.eatit.MaterialDomain.MaterialVO;
import com.eatit.MaterialService.MaterialService;
import com.eatit.mainDomain.Criteria;
import com.eatit.mainDomain.PageVO;

@Controller
@RequestMapping(value = "/Material/*")
public class MaterialController {

	private static final Logger logger = LoggerFactory.getLogger(MaterialController.class);

	@Inject
	private MaterialService MaterialService;

	// 원자재 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String materialListGET(Model model, Criteria cri) {
		logger.debug("/Material/list 호출 -> materialListGET() 실행");
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(MaterialService.getTotalCount());

		model.addAttribute("listUrl", "list");
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("Material", MaterialService.findAllMaterials());
		return "/Material/MaterialList";
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String materialListPost(MaterialVO vo, @ModelAttribute("searchword") String searchword) {
		logger.debug("/Material/list 호출 -> materialListPOST() 실행");		
		MaterialService.editMaterialContent(vo);
		if(!searchword.isEmpty()) {
			return "redirect:/Material/searchlist";
		}
		return "redirect:/Material/MaterialList";
	}
	
	@RequestMapping(value = "/content", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MaterialVO MaterialContentGET(MaterialVO vo) {
		logger.debug("/Material/content 호출 -> MaterialContentGET() 실행");
		return MaterialService.getMaterialContent(vo);
	}

	@RequestMapping(value = "/searchlist", method = RequestMethod.GET)
	public String searchListGET(Model model, Map<String, Object> params, Criteria cri, @ModelAttribute("searchword") String searchword) {
		logger.debug("/Material/searchlist 호출 -> searchListGET() 실행");
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(MaterialService.getSearchCount(searchword));
		
		params.put("cri", cri);
		params.put("searchword", searchword);
		
		model.addAttribute("searchword",searchword);
		model.addAttribute("listUrl", "searchlist");
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("list",MaterialService.getSearchList(params,cri, searchword));		
		return "/Material/MaterialList";
	}

	// 입고 목록 조회
	@RequestMapping(value = "/materialadd", method = RequestMethod.GET)
	public void materialaddListGET(Model model, Criteria cri) {
		logger.debug("/Material/add 호출 -> materialaddListGET() 실행");
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(MaterialService.getTotalCount());

		model.addAttribute("listUrl", "add");
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("materialaddList", MaterialService.getmaterialaddList());
		

	}

	@RequestMapping(value = "/Material", method = RequestMethod.GET)
	public void MaterialGET() {

	}

	// 입고등록
	@RequestMapping(value = "/Material", method = RequestMethod.POST)
	public String materialaddPOST(materialaddVO vo, @RequestParam("expiry_date") Date expiry_date,
			RedirectAttributes rttr) {
		// 로직 처리

		logger.debug("C - materialaddPOST()");
		logger.debug("vo : " + vo);
		System.out.println("expiry_date" + expiry_date);

		// 서비스 - 입고 등록
		MaterialService.insertmaterialadd(vo);

		return "redirect:/Material/MaterialClose";
	}

	// 등록 후 창닫기 전용 페이지
	@GetMapping(value = "/MaterialClose")
	public void MaterialClose() {
		logger.debug("C - MaterialClose()");
	}

	// AJAX로 자재 목록을 반환하는 메서드
	@GetMapping(value = "/api/materials")
	@ResponseBody
	public List<MaterialVO> getMaterialList() {
		logger.debug("AJAX 요청 - getMaterialList() 실행");
		return MaterialService.findAllMaterials();
	}

	// AJAX로 특정 자재 정보를 반환하는 메서드
	@GetMapping(value = "/api/materials/{id}")
	@ResponseBody
	public MaterialVO getMaterial(@PathVariable("id") int materialId) {
		logger.debug("AJAX 요청 - getMaterial() 실행, materialId: " + materialId);
		return MaterialService.findMaterialById(materialId);
	}

	// 발주 신청 - GET
	@RequestMapping(value = "/MaterialwriteForm", method = RequestMethod.GET)
	public void materialWriteFormGET(Model model) throws Exception {

		logger.debug("Controller: /Material/MaterialwriteForm/materialWriteFormGET() 호출");
		logger.debug("/Material/MaterialwriteForm.jsp 페이지 이동");

	}

	// 발주 신청 - POST
	@RequestMapping(value = "/MatereialwriteForm", method = RequestMethod.POST)
	public String matereialWriteFormPOST(MaterialOrderVO pvo) throws Exception {

		logger.debug("Controller: /Material/MatereialwriteForm/matereialWriteFormPOST() 호출");

		// 전달 정보 저장, 확인
		logger.debug("pvo: " + pvo);

		// 서비스 - 신청서 작성 동작 호출(INSERT)
		MaterialService.createMatereialOrder(pvo);
		logger.debug("신청서 작성 완료");

		// 페이지 이동
		logger.debug("/Matereial/MaterialOrderList 페이지 이동");
		return "redirect:/Material/MaterialOrderList";
	}

	// 발주 목록 조회
	@RequestMapping(value = "/MaterialOrderList", method = RequestMethod.GET)
	public void materialorderListGET(Model model, Criteria cri) {
		logger.debug("/Material/MaterialOrderList 호출 -> materialorderListGET() 실행");
		
		PageVO pageVO = new PageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(MaterialService.getTotalCount());

		model.addAttribute("listUrl", "MaterialOrderList");
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("MaterialOrderList", MaterialService.Materialorder());
		
	}

	
//	// 발주 내역 상세 조회 - GET
//	@RequestMapping(value = "/MaterialorderDetail", method = RequestMethod.GET)
//	@ResponseBody
//	public MaterialOrderVO MaterialorderDetailGET(@RequestParam("materialod_id")Integer materialod_id) throws Exception{
//		
//		logger.debug("Controller: /Material/MaterialorderDetailGET(materialod_id)");
//		
//		return MaterialService.getMaterialorderDetail(materialod_id);
//	}
	
	// 발주 내역 상세 조회 - GET
	@RequestMapping(value = "/api/MaterialorderDetail", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MaterialOrderVO MaterialorderDetailGET(@RequestParam("materialod_id") Integer materialod_id) throws Exception {
	    logger.debug("Controller: /Material/api/MaterialorderDetailGET(materialod_id)");
	    // 발주 내역 상세 정보
	    return MaterialService.getMaterialorderDetail(materialod_id);
	}


	
	

	// 발주서 수정 - POST
	@RequestMapping(value = "/updateDetailInfo", method = RequestMethod.POST)
	public String updateDetailInfo(MaterialOrderVO vo) {
		logger.debug("/Material/updateDetailInfo 호출 -> updateDetailInfo() 실행");

		// 서비스 - 신청서 수정 동작 호출(UPDATE)
		MaterialService.Materialupdate(vo);
		
		return "redirect:/Material/MaterialOrderList";
	}
	
	// 발주서 삭제 - POST
	@RequestMapping(value = "/deleteMaterial", method = RequestMethod.POST)
	public String deleteMateialPOST(@RequestParam("chk") int[] materialod_id) {
		logger.debug("C - deleteMateialPOST()");
		logger.debug("vo : "+materialod_id);
		
		// 서비스 - 창고 삭제
		MaterialService.deleteMaterial(materialod_id);
		
		return "redirect:/Material/MaterialOrderList";
	}	

}

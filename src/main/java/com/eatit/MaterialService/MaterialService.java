package com.eatit.MaterialService;

import com.eatit.MaterialDomain.materialaddVO;
import com.eatit.MaterialDomain.MaterialOrderVO;
import com.eatit.MaterialDomain.MaterialVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.warehouseDomain.WarehouseVO;

import java.util.List;
import java.util.Map;

public interface MaterialService {

	// 모든 재료의 목록을 검색합니다.
	public List<MaterialVO> findAllMaterials();

	// 추가된 재료의 목록을 검색합니다.
	public List<materialaddVO> getmaterialaddList();

	// 모든 재료 주문의 목록을 검색합니다.
	public List<MaterialOrderVO> Materialorder();

	// 새로운 재료 추가를 등록합니다.
	public void insertmaterialadd(materialaddVO vo);

	// 기존 재료 정보를 업데이트합니다.
	public void updateMaterial(MaterialVO vo);

	// 특정 재료를 삭제합니다.
	public void deleteMaterial(String string);

	// ID를 기준으로 특정 재료 정보를 검색합니다.
	public MaterialVO findMaterialById(int materialId);

	// 모든 재료의 총 수를 반환합니다.
	public int getTotalCount();

	// 재료의 상세 정보를 수정합니다.
	public void editMaterialContent(MaterialVO vo);

	// 검색 조건에 맞는 재료 목록을 검색합니다.
	public List<MaterialVO> getSearchList(Map<String, Object> params, Criteria cri, String searchword);

	// 검색 조건에 맞는 재료의 총 개수를 반환합니다.
	public int getSearchCount(String searchword);

	// 등록된 재료의 총 개수를 반환합니다.
	public int getRegCount();

	// 발주 삭제
	public void deleteMaterial(int[] materialod_id);
	
	// 창고 수정
	public void Materialupdate(MaterialOrderVO vo);

	// 특정 조건에 맞는 재료 목록을 검색합니다.
	public List<MaterialVO> getMaterialList(Criteria cri);

	// 재료 주문을 생성합니다.
	public void createMatereialOrder(MaterialOrderVO pvo) throws Exception;

	// 재료 주문 목록을 검색합니다.
	public List<MaterialOrderVO> getMaterialorderList() throws Exception;

	// 특정 재료 주문의 세부 정보를 검색합니다.
	public MaterialOrderVO getMaterialorderDetail(int materialod_id) throws Exception;


	public MaterialVO getMaterialContent(MaterialVO vo);

}

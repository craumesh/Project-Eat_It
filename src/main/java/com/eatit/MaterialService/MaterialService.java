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
	
	// 새로운 발주 추가를 등록합니다.
	public void insertMaterialOrder(MaterialOrderVO pvo);
	
	// 기존 재료 정보를 업데이트합니다.
	public void updateMaterial(MaterialVO vo);

	// 특정 재료를 삭제합니다.
	public void deleteMaterial(String string);

	// 모든 재료의 총 수를 반환합니다.
	public int getTotalCount();

	// 재료의 상세 정보를 수정합니다.
	public void editMaterialContent(MaterialVO vo);

	// 검색 조건에 맞는 재료 목록을 검색합니다.
	public List<MaterialVO> getSearchList(Map<String, Object> params, Criteria cri, String searchword);

	public List<materialaddVO> getMaterialaddList(Map<String, Object> params, Criteria cri, String searchword);

	public List<MaterialOrderVO> getMaterialorderList(Map<String, Object> params, Criteria cri, String searchword);

	// 검색 조건에 맞는 재료의 총 개수를 반환합니다.
	public int getSearchCount(Map<String, Object> params);

	// 등록된 재료의 총 개수를 반환합니다.
	public int getRegCount();

	// 발주 삭제
	public void deleteMaterial(int[] materialod_id);
	
	// ID를 기준으로 특정 재료 정보를 검색합니다.
	public MaterialVO findMaterialById(int materialId);

	// 발주 수정
	public void Materialupdate(MaterialOrderVO vo);

	// 특정 조건에 맞는 재료 목록을 검색합니다.
	public List<MaterialVO> getMaterialList(Criteria cri);

	// 재료 주문 목록을 검색합니다.
	public List<MaterialOrderVO> getMaterialorderList() throws Exception;

	public MaterialVO getMaterialContent(MaterialVO vo);

	public List<MaterialVO> getTotalCount(Criteria cri);

	public int getFindMaterialListCount(Map<String, Object> params);

	public List<MaterialVO> findMaterialList(Map<String, Object> params);

	public int getSearchCount(String searchword);

}

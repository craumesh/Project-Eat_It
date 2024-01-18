package com.eatit.MaterialPersistence;

import com.eatit.MaterialDomain.MaterialOrderVO;
import com.eatit.MaterialDomain.MaterialVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.warehouseDomain.WarehouseVO;

import java.util.List;
import java.util.Map;
import com.eatit.MaterialDomain.materialaddVO;

public interface MaterialDAO {
    
    // 원자재 전체 목록을 조회합니다.
    public List<MaterialVO> findAllMaterials();
    
    // 입고 목록을 조회합니다.
    public List<materialaddVO> getmaterialaddList();
     
    // 원자재 상세 정보를 조회합니다.
    public MaterialVO selectContent(MaterialVO vo);
    
    // 전체 원자재의 수를 반환합니다.
    public int getTotalCount();
    
    // 등록된 원자재의 총 개수를 반환합니다.
    public int getRegCount();    
    
    // 원자재의 상세 정보를 업데이트합니다.
    public void updateMaterialContent(MaterialVO vo);
    
    // 특정 조건에 맞는 등록된 원자재 목록을 조회합니다.
 	public List<MaterialVO> selecMaterialList(Criteria cri);
        
    // 검색 조건에 맞는 원자재 목록을 조회합니다.
    public List<MaterialVO> selectSearchList(Map<String, Object> params, Criteria cri, String searchword);
    
    // 검색된 원자재의 총 개수를 반환합니다.
    public int getSearchCount(String searchword);

	public MaterialVO selectMaterialContent(MaterialVO vo);
       
	// 입고 등록
	public void insertmaterialadd(materialaddVO vo);

    // 특정 조건을 만족하는 원자재 목록을 조회합니다.
    public List<MaterialVO> selectMaterialList(Criteria cri);
    
    // 특정 원자재의 정보를 업데이트합니다.
    public void updateMaterial(MaterialVO vo);

    public List<MaterialOrderVO> Materialorder();
    
    // 특정 원자재를 삭제합니다.
    public void deleteMaterial(Long id);

	public void insertMaterialOrder(MaterialOrderVO pvo) throws Exception;
	

	public MaterialOrderVO getMaterialOrderDetail(int materialod_id) throws Exception;

	public void updateDetailInfo(MaterialOrderVO vo);

	public void deleteMaterial(int[] materialod_id);


	
}


package com.eatit.MaterialPersistence;

import com.eatit.MaterialDomain.MaterialListVO;
import com.eatit.MaterialDomain.MaterialVO;

import java.util.List;

public interface MaterialListDAO {
    // 원자재 목록 조회 메서드
    public List<MaterialListVO> findAllMaterials();

	public MaterialListVO findMaterialById(Long id);
}
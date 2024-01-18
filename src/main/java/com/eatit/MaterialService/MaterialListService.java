package com.eatit.MaterialService;

import java.util.List;

import com.eatit.MaterialDomain.MaterialListVO;

public interface MaterialListService {

    // 원자재 목록 조회 메서드
    public List<MaterialListVO> findAllMaterials();

    // 원자재 상세 조회 메서드
    public MaterialListVO findMaterialById(Long id);
}

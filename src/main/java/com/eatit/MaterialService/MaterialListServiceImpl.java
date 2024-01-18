package com.eatit.MaterialService;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.MaterialDomain.MaterialListVO;
import com.eatit.MaterialPersistence.MaterialListDAO;

import java.util.List;


@Service
public class MaterialListServiceImpl implements MaterialListService {

    private static final Logger logger = LoggerFactory.getLogger(MaterialListServiceImpl.class);

    @Inject
    private MaterialListDAO materialListDAO; // MaterialListDAO 객체 주입

    @Override
    public List<MaterialListVO> findAllMaterials() {
        logger.debug("Service - 원자재 목록 조회");
        // MaterialListDAO의 findAllMaterials 메서드를 호출하여 모든 원자재 정보를 가져옴
        return materialListDAO.findAllMaterials();
    }

    @Override
    public MaterialListVO findMaterialById(Long id) {
        logger.debug("Service - 원자재 상세 조회");
        // MaterialListDAO의 findMaterialById 메서드를 호출하여 특정 id의 원자재 정보를 가져옴
        return materialListDAO.findMaterialById(id);
    }

    // 필요한 경우, 추가적인 서비스 메소드들을 여기에 구현할 수 있습니다.
    // 예: 입력 데이터 검증, 관련 비즈니스 로직 처리 등
}

package com.eatit.MaterialService;

import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

import com.eatit.MaterialDomain.materialaddVO;
import com.eatit.MaterialDomain.MaterialOrderVO;
import com.eatit.MaterialDomain.MaterialVO;
import com.eatit.MaterialPersistence.MaterialDAO; // MaterialDAO를 사용
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.WarehouseVO;

@Service
public class MaterialServiceImpl implements MaterialService {

	private static final Logger logger = LoggerFactory.getLogger(MaterialServiceImpl.class);

	@Inject
	private MaterialDAO materialDAO; // MaterialDAO 객체 주입

	@Override
	public List<MaterialVO> findAllMaterials() {
		logger.debug("Service - 원자재 목록 조회");
		return materialDAO.findAllMaterials();
	}

	@Override
	// 입고 등록
	public void insertmaterialadd(materialaddVO vo) {
		logger.debug("S - insertmaterialadd(materialaddVO vo)");
		materialDAO.insertmaterialadd(vo);
	}
	
	@Override
	public void updateMaterial(MaterialVO vo) {
		logger.debug("Service - 원자재 정보 수정");
		materialDAO.updateMaterial(vo);
	}

	@Override
	public List<MaterialVO> getMaterialList(Criteria cri) {
		logger.debug("Service(getHrList) -> DAO 호출");
		return materialDAO.selectMaterialList(cri);
	}

	@Override
	public int getTotalCount() {
		logger.debug("Service(getTotalCount) -> DAO 호출");
		return materialDAO.getTotalCount();
	}

	@Override
	public int getSearchCount(String searchword) {
		logger.debug("Service(getSearchCount) -> DAO 호출");
		return materialDAO.getSearchCount(searchword);
	}

	@Override
	public List<MaterialVO> getSearchList(Map<String, Object> params, Criteria cri, String searchword) {
		logger.debug("Service(getSearchList) -> DAO 호출");
		return materialDAO.selectSearchList(params, cri, searchword);
	}

	@Override
	public void deleteMaterial(String string) {
		// TODO Auto-generated method stub

	}

	@Override
	public MaterialVO findMaterialById(int materialId) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int getRegCount() {
		// TODO Auto-generated method stub
		return 0;
	}

//	@Override
//	public void setHrRegActive(MaterialVO vo) {
//		// TODO Auto-generated method stub
//
//	}

	@Override
	public List<materialaddVO> getmaterialaddList() {
		logger.debug("Service - 입고 목록 조회");
		return materialDAO.getmaterialaddList();
	}

	@Override
	public void editMaterialContent(MaterialVO vo) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public void createMatereialOrder(MaterialOrderVO pvo) throws Exception {
		logger.debug("Service: createMatereialOrder(MaterialOrderVO pvo)");
		materialDAO.insertMaterialOrder(pvo);
	}

	@Override
	public MaterialOrderVO getMaterialorderDetail(int materialod_id) throws Exception {
		logger.debug("Service: getMaterialOrderDetail(String materialod_id)");
		return materialDAO.getMaterialOrderDetail(materialod_id);
	}
	
	@Override
	// 창고 수정
	public void Materialupdate(MaterialOrderVO vo) {
		materialDAO.updateDetailInfo(vo);
	}
	
	@Override
	// 발주 삭제
	public void deleteMaterial(int[] materialod_id) {
		logger.debug("S - deleteMaterial(int[] materialod_id)");
		materialDAO.deleteMaterial(materialod_id);
	}
	

	
    @Override
    public List<MaterialOrderVO> Materialorder() {
        logger.debug("Service: Materialorder()");
        return materialDAO.Materialorder();
    }

	@Override
	public List<MaterialOrderVO> getMaterialorderList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MaterialVO getMaterialContent(MaterialVO vo) {
		logger.debug("Service(getMaterialContent) -> DAO 호출");
		return materialDAO.selectMaterialContent(vo);
	}


}

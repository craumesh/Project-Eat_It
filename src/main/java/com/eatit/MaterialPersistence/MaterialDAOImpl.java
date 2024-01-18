package com.eatit.MaterialPersistence;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.eatit.MaterialDomain.materialaddVO;
import com.eatit.MaterialDomain.MaterialOrderVO;
import com.eatit.MaterialDomain.MaterialVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.memberDomain.MemberVO;
import com.eatit.warehouseDomain.WarehouseVO;

@Repository
public class MaterialDAOImpl implements MaterialDAO {

    private static final Logger logger = LoggerFactory.getLogger(MaterialDAOImpl.class);
    
    private static final String NAMESPACE = "com.eatit.mapper.MaterialMapper.";
    
    @Inject
    private SqlSession sqlSession;

    // 전체 원자재 목록을 조회합니다.
    @Override
    public List<MaterialVO> findAllMaterials() {
        logger.debug("DAO - 원자재 목록 조회");
        return sqlSession.selectList(NAMESPACE + "findAll");
    }

	@Override
	// 입고 목록 모두 가져오기
	public List<materialaddVO> getmaterialaddList() {
		logger.debug("DAO - getmaterialaddList() 호출");
		List<materialaddVO> resultList = sqlSession.selectList(NAMESPACE+"find");
		return resultList;
	}
    
    // 새로운 원자재 입고 정보를 데이터베이스에 등록합니다.
    @Override
    public void insertmaterialadd(materialaddVO vo) {
        logger.debug("DAO - insertmaterialadd(materialaddVO vo)");
        sqlSession.insert(NAMESPACE + "insertmaterialadd", vo);
    }
    
    // 기존 원자재 정보를 업데이트합니다.
    @Override
    public void updateMaterial(MaterialVO vo) {
        logger.debug("DAO - 원자재 정보 수정");
        sqlSession.update(NAMESPACE + "updateMaterial", vo);
    }

    // 특정 원자재를 데이터베이스에서 삭제합니다.
    @Override
    public void deleteMaterial(Long id) {
        logger.debug("DAO - 원자재 삭제");
        sqlSession.delete(NAMESPACE + "deleteMaterial", id);
    }

    // 전체 원자재의 수를 반환합니다.
    @Override
    public int getTotalCount() {
        logger.debug("DAO(getTotalCount) -> Mapper 호출");
        return sqlSession.selectOne(NAMESPACE + "totalCount");
    }

    // 특정 조건에 맞는 원자재 목록을 조회합니다.
    @Override
    public List<MaterialVO> selecMaterialList(Criteria cri) {
        logger.debug("DAO(selecMaterialList) -> Mapper 호출");
        return sqlSession.selectList(NAMESPACE + "selecMaterialList", cri);
    }

    // 검색 조건에 맞는 원자재의 총 개수를 반환합니다.
    @Override
    public int getSearchCount(String searchword) {
        logger.debug("DAO(getSearchCount) -> Mapper 호출");
        return sqlSession.selectOne(NAMESPACE + "searchCount", searchword);
    }

    // 검색어와 기타 조건에 맞는 원자재 목록을 조회합니다.
    @Override
    public List<MaterialVO> selectSearchList(Map<String, Object> params, Criteria cri, String searchword) {
        logger.debug("DAO(selectSearchList) -> Mapper 호출");
        return sqlSession.selectList(NAMESPACE + "selectSearchList", params);
    }

 // 발주 목록 모두 가져오기
	@Override
	public List<MaterialOrderVO> Materialorder() {
		logger.debug("DAO - materialorderListGET() 호출");
		List<MaterialOrderVO> resultList = sqlSession.selectList(NAMESPACE+"Materialorder");
		return resultList;
	}
	
	@Override
	public int getRegCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MaterialVO> selectMaterialList(Criteria cri) {
		logger.debug("DAO(selectMaterialList) -> Mapper 호출");
		return sqlSession.selectList(NAMESPACE+".selectMaterialList", cri);
	}
	
	@Override
	public void insertMaterialOrder(MaterialOrderVO pvo) throws Exception {
		logger.debug("DAO: insertMaterialOrder(MaterialOrderVO pvo)");
		sqlSession.insert(NAMESPACE + ".insertForm", pvo);
	}

//	@Override
//	public MaterialOrderVO getMaterialOrderDetail(int materialod_id) throws Exception {
//		logger.debug("DAO: getMaterialOrderDetail(String materialod_id)");
//		return sqlSession.selectOne(NAMESPACE + ".MaterialorderDetail", materialod_id);
//	}
	
	@Override
	public MaterialOrderVO getMaterialOrderDetail(int materialod_id) throws Exception {
	    try {
	        logger.debug("DAO: getMaterialOrderDetail 호출, materialod_id: " + materialod_id);
	        return sqlSession.selectOne(NAMESPACE + ".MaterialorderDetail", materialod_id);
	    } catch (Exception e) {
	        logger.error("getMaterialOrderDetail에서 오류 발생: " + e.getMessage());
	        e.printStackTrace(); // 오류의 스택 트레이스를 콘솔에 출력
	        throw e; // 예외를 다시 throw하여 호출자에게 전파
	    }
	}

	
	// 발주 삭제
	@Override
	public void deleteMaterial(int[] materialod_id) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("materialod_id", materialod_id);
		sqlSession.delete(NAMESPACE+"deleteMaterial",paramMap);
	}
	
	@Override
	// 창고 수정
	public void updateDetailInfo(MaterialOrderVO vo) {
		sqlSession.update(NAMESPACE+"updateDetailInfo", vo);
	}

	@Override
	public MaterialVO selectContent(MaterialVO vo) {
		logger.debug("DAO(selectContent) -> Mapper 호출");
		return sqlSession.selectOne(NAMESPACE+".selectContent", vo);
	}

	@Override
	public void updateMaterialContent(MaterialVO vo) {
		logger.debug("DAO(updateMaterialContent) -> Mapper 호출");
		sqlSession.update(NAMESPACE+".updateMaterialContent", vo);
	}

	@Override
	public MaterialVO selectMaterialContent(MaterialVO vo) {
		logger.debug("DAO(selectMaterialContent) -> Mapper 호출");
		return sqlSession.selectOne(NAMESPACE+".selectMaterialContent", vo);
		
	}
	
	

}

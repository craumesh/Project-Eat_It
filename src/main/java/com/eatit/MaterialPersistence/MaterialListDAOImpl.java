package com.eatit.MaterialPersistence;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import java.util.List;

import com.eatit.MaterialDomain.MaterialListVO;
import com.eatit.MaterialDomain.MaterialVO;

@Repository
public class MaterialListDAOImpl implements MaterialListDAO {
    
    private static final Logger logger = LoggerFactory.getLogger(MaterialListDAOImpl.class);
    
    @Inject
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.eatit.mapper.MaterialMapper";
    
    @Override
    public List<MaterialListVO> findAllMaterials() {
        logger.debug("DAO - 원자재 목록 조회");
        return sqlSession.selectList(NAMESPACE + ".findAll");
    }

	@Override
	public MaterialListVO findMaterialById(Long id) {
		// TODO Auto-generated method stub
		return null;
	}
}
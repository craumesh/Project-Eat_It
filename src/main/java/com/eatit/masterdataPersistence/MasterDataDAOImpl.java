package com.eatit.masterdataPersistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.MasterdataVO;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
public class MasterDataDAOImpl implements MasterDataDAO {

	private static final Logger logger = LoggerFactory.getLogger(MasterDataDAOImpl.class);

	@Inject
	private SqlSession sqlSession;

	private static final String NAMESPACE = "com.eatit.mapper.masterDataMapper";

	@Override
	public List<MasterdataVO> getProductList() {

		return sqlSession.selectList(NAMESPACE + ".getProductList");
	}

	@Override
	public void productInsert(MasterdataVO pvo) {
		logger.debug(" mapper(DB) ��� ó�� ���� ���� - ����");
		sqlSession.insert(NAMESPACE + ".insertProduct", pvo);

		sqlSession.insert(NAMESPACE + ".insertRecipe", pvo);
		logger.debug(" mapper(DB) ��� ó�� ���� ���� - ��");

	}

	@Override
	public void QIMInsert(MasterdataVO pvo) {
		sqlSession.insert(NAMESPACE + ".insertQIM", pvo);

	}

	@Override
	public void QIMTestInsert(MasterdataVO pvo) {
		sqlSession.insert(NAMESPACE + ".insertQIMTest", pvo);

	}

	@Override
	public int productUpdate(MasterdataVO pvo) throws Exception {
		logger.debug("DAO:updateProduct(ProductVO vo)");
		int updatedProduct = sqlSession.update(NAMESPACE + ".updateProduct", pvo);

		// recipe ���̺� ������Ʈ
		int updatedRecipe = sqlSession.update(NAMESPACE + ".updateRecipe", pvo);

		// �� ������ ����� �ջ��Ͽ� ��ȯ�ϰų� �ʿ��� ó�� ����
		// ���� ���, �� ���� ��� �����ؾ߸� �������� �����ϴ� ��쿡�� ������ ���� ó�� ����
		if (updatedProduct > 0 && updatedRecipe > 0) {
			return updatedProduct + updatedRecipe;
		} else {
			// ���� ó�� �Ǵ� ���� �� ����
			return -1;
		}

	}

	@Override
	public void deleteProduct(int product_no, String product_code) throws Exception {

		// recipe ���̺����� product_code�� �����ϴ� ���� ���� ����
		sqlSession.delete(NAMESPACE + ".deleteRecipeByProductCode", product_code);

		sqlSession.delete(NAMESPACE + ".deleteProduct", product_no);

	}

	@Override
	public void deleteQIM(int quality_no, String product_code) {
		sqlSession.delete(NAMESPACE + ".deleteRPC", product_code);
		sqlSession.delete(NAMESPACE + ".deletePC", product_code);
		sqlSession.delete(NAMESPACE + ".deleteQuality", quality_no);

	}

	@Override
	public void deleteFIM(int machine_code) {
		sqlSession.delete(NAMESPACE + ".deleteFIM", machine_code);

	}

	@Override
	public void deleteAllProduct(int product_no, String product_code) {

		sqlSession.delete(NAMESPACE + ".deleteAllRecipeByProductCode", product_code);

		sqlSession.delete(NAMESPACE + ".deleteAllProduct", product_no);
	}

	@Override
	public List<MasterdataVO> getProductListPage(int page) throws Exception {
		page = (page - 1) * 10;
		return sqlSession.selectList(NAMESPACE + ".MdListPage", page);
	}

	@Override
	public List<MasterdataVO> getProductListPage(Criteria cri) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".MdListPage", cri);
	}

	@Override
	public List<MasterdataVO> getMIMListPage(Criteria cri) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getMIMList", cri);
	}

	@Override
	public List<MasterdataVO> getMIMListPage(int page) throws Exception {
		page = (page - 1) * 10;
		return sqlSession.selectList(NAMESPACE + ".getMIMList", page);
	}

	@Override
	public List<MasterdataVO> getFIMListPage(Criteria cri) {

		return sqlSession.selectList(NAMESPACE + ".getFIMList", cri);
	}

	@Override
	public List<MasterdataVO> getFIMListPage(int page) throws Exception {
		page = (page - 1) * 10;
		return sqlSession.selectList(NAMESPACE + ".getFIMList", page);
	}

	@Override
	public List<MasterdataVO> getQIMListPage(int page) throws Exception {
		page = (page - 1) * 10;
		return sqlSession.selectList(NAMESPACE + ".getQIMList", page);
	}

	@Override
	public List<MasterdataVO> getQIMListPage(Criteria cri) {

		return sqlSession.selectList(NAMESPACE + ".getQIMList", cri);
	}

	@Override
	public List<MasterdataVO> getCIMListPage(Criteria cri) {

		return sqlSession.selectList(NAMESPACE + ".selectCIMList",cri);
	}

	@Override
	public int getProductCount() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".countProduct");
	}

	@Override
	public int getMIMCount() throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".mtotalCount");
	}

	@Override
	public int getFIMCount() {

		return sqlSession.selectOne(NAMESPACE + ".ftotalCount");
	}

	@Override
	public int getQIMCount() {

		return sqlSession.selectOne(NAMESPACE + ".qtotalCount");
	}

	@Override
	public List<MasterdataVO> searchProducts(String keyword) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("keyword", keyword);

		return sqlSession.selectList(NAMESPACE + ".searchProducts", paramMap);
	}

	@Override
	public List<MasterdataVO> searchMIM(String keyword) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".searchMIM", paramMap);
	}

	@Override
	public List<MasterdataVO> searchFIM(String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".searchFIM", paramMap);

	}

	@Override
	public List<MasterdataVO> searchQIM(String keyword) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".searchQIM", paramMap);
	}

	@Override
	public void MIMInsert(MasterdataVO pvo) throws Exception {

		sqlSession.insert(NAMESPACE + ".insertMIM", pvo);
	}

	@Override
	public void FIMInsert(machineVO mvo) {
		sqlSession.insert(NAMESPACE + ".insertFIM", mvo);

	}

	@Override
	public int MIMUpdate(MasterdataVO pvo) throws Exception {

		return sqlSession.update(NAMESPACE + ".updateMIM", pvo);
	}

	@Override
	public int FIMUpdate(machineVO mvo) {

		return sqlSession.update(NAMESPACE + ".updateFIM", mvo);
	}

	@Override
	public void deleteMIM(int product_no) throws Exception {

		sqlSession.delete(NAMESPACE + ".deleteMIM", product_no);
	}

	@Override
	public int getPIMSearchCount() {

		return sqlSession.selectOne(NAMESPACE + ".getPIMSearchCount");
	}

	@Override
	public int getMIMSearchCount() {

		return sqlSession.selectOne(NAMESPACE + ".getMIMSearchCount");
	}

	@Override
	public int getFIMSearchCount() {

		return sqlSession.selectOne(NAMESPACE + ".getFIMSearchCount");
	}

	@Override
	public int getQIMSearchCount() {

		return sqlSession.selectOne(NAMESPACE + ".getQIMSearchCount");
	}

	@Override
	public List<MasterdataVO> getCategoryList() {

		return sqlSession.selectList(NAMESPACE + ".getCategoryList");
	}

	@Override
	public List<MasterdataVO> dataList() {

		return sqlSession.selectList(NAMESPACE + ".dataList");
	}

	@Override
	public MasterdataVO selectMDContent(MasterdataVO pvo) {

		return sqlSession.selectOne(NAMESPACE + ".selectMDContent", pvo);
	}

	@Override
	public MasterdataVO selectRecipeContent(MasterdataVO pvo) {

		return sqlSession.selectOne(NAMESPACE + ".selectRecipeContent", pvo);
	}
	
	
	public List<MasterdataVO> selectSearchCIMList(Map<String, Object> params) {
		logger.debug("Service(selectCIMCount) 호출");
		return sqlSession.selectList(NAMESPACE + ".selectSearchCIMList",params);
	}

	@Override
	public int selectCIMCount() {
		logger.debug("Service(selectCIMCount) 호출");
		return sqlSession.selectOne(NAMESPACE + ".selectCIMCount");
	}

	@Override
	public int selectSearchCount(Map<String, Object> params) {
		logger.debug("Service(selectSearchCount) 호출");
		return sqlSession.selectOne(NAMESPACE + ".selectSearchCount",params);
	}

	@Override
	public MasterdataVO selectCIMContent(MasterdataVO vo) {
		logger.debug("Service(selectCIMContent) 호출");
		return sqlSession.selectOne(NAMESPACE + ".selectCIMContent", vo);
	}

	@Override
	public List<String> selectMaterialNames() {
		logger.debug("Service(selectMaterialNames) 호출");
		return sqlSession.selectList(NAMESPACE + ".selectMaterialNames");
	}

	@Override
	public void updateRequires(MasterdataVO vo) {
		logger.debug("Service(updateRequires) 호출");
		sqlSession.update(NAMESPACE + ".updateRequires",vo);
	}

	@Override
	public void deleteRequires(MasterdataVO vo) {
		logger.debug("Service(deleteRequires) 호출");
		sqlSession.update(NAMESPACE + ".deleteRequires",vo);
	}
	
}

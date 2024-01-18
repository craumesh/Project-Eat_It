package com.eatit.masterdataService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.MasterdataVO;
import com.eatit.masterdataPersistence.MasterDataDAO;
import com.eatit.masterdataService.MasterDataService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

@Service
public class MasterDataServiceImpl implements MasterDataService {

	private static final Logger logger = LoggerFactory.getLogger(MasterDataServiceImpl.class);

	@Inject
	private MasterDataDAO mddao;

	@Override
	public List<MasterdataVO> ProductList() throws Exception {
		logger.debug("ProductList()");
		return mddao.getProductList();
	}

	@Override
	public void productInsert(MasterdataVO pvo) {

		mddao.productInsert(pvo);

	}

	@Override
	public void FIMInsert(machineVO mvo) {
		mddao.FIMInsert(mvo);

	}

	@Override
	public int productUpdate(MasterdataVO pvo) throws Exception {
		logger.debug("S:productUpdate(ProductVO pvo)");
		return mddao.productUpdate(pvo);

	}

	@Override
	public int FIMUpdate(machineVO mvo) {

		return mddao.FIMUpdate(mvo);
	}

	@Override
	public void productDelete(int product_no, String product_code) throws Exception {
		mddao.deleteProduct(product_no, product_code);

	}

	@Override
	public void productAllDelete(int product_no, String product_code) {
		mddao.deleteAllProduct(product_no, product_code);

	}

	@Override
	public List<MasterdataVO> productListPage(Criteria cri) throws Exception {

		return mddao.getProductListPage(cri);
	}

	@Override
	public List<MasterdataVO> MIMListPage(Criteria cri) throws Exception {

		return mddao.getMIMListPage(cri);
	}

	@Override
	public List<MasterdataVO> CIMListPage(Criteria cri) {

		return mddao.getCIMListPage(cri);
	}

	@Override
	public List<MasterdataVO> FIMListPage(Criteria cri) {

		return mddao.getFIMListPage(cri);
	}

	@Override
	public List<MasterdataVO> QIMListPage(Criteria cri) {

		return mddao.getQIMListPage(cri);
	}

	@Override
	public int totalProductCount() throws Exception {

		return mddao.getProductCount();
	}

	@Override
	public int getMIMCount() throws Exception {

		return mddao.getMIMCount();
	}

	@Override
	public int totalFIMCount() {

		return mddao.getFIMCount();
	}

	@Override
	public int totalQIMCount() {

		return mddao.getQIMCount();
	}

	@Override
	public List<MasterdataVO> searchProducts(String keyword) throws Exception {
		logger.debug("searchProducts(String keyword)");
		return mddao.searchProducts(keyword);
	}

	@Override
	public List<MasterdataVO> searchMIM(String keyword) throws Exception {

		return mddao.searchMIM(keyword);
	}

	@Override
	public List<MasterdataVO> searchFIM(String keyword) {

		return mddao.searchFIM(keyword);
	}

	@Override
	public List<MasterdataVO> searchQIM(String keyword) {

		return mddao.searchQIM(keyword);
	}

	@Override
	public void MIMInsert(MasterdataVO pvo) throws Exception {

		mddao.MIMInsert(pvo);
	}

	@Override
	public int MIMUpdate(MasterdataVO pvo) throws Exception {

		return mddao.MIMUpdate(pvo);
	}

	@Override
	public void MIMDelete(int product_no) throws Exception {
		mddao.deleteMIM(product_no);

	}

	@Override
	public void FIMDelete(int machine_code) {
		mddao.deleteFIM(machine_code);

	}

	@Override
	public int searchProductCount() {

		return mddao.getPIMSearchCount();
	}

	@Override
	public int searchMIMCount() {

		return mddao.getMIMSearchCount();
	}

	@Override
	public int searchFIMCount() {

		return mddao.getFIMSearchCount();
	}

	@Override
	public int searchQIMCount() {

		return mddao.getQIMSearchCount();
	}

	@Override
	public List<MasterdataVO> categoryList() {

		return mddao.getCategoryList();
	}

	@Override
	public void QIMInsert(MasterdataVO pvo) {
		mddao.QIMInsert(pvo);

	}

	@Override
	public void QIMTestInsert(MasterdataVO pvo) {
		mddao.QIMTestInsert(pvo);

	}

	@Override
	public void QIMDelete(int quality_no, String product_code) {
		mddao.deleteQIM(quality_no, product_code);

	}

	@Override
	public List<MasterdataVO> dataList() {

		return mddao.dataList();
	}

	@Override
	public MasterdataVO getMDContent(MasterdataVO pvo) {

		return mddao.selectMDContent(pvo);
	}

	@Override
	public MasterdataVO getRecipeContent(MasterdataVO pvo) {

		return mddao.selectRecipeContent(pvo);
	}

	@Override
	public int getCIMCount() {
		logger.debug("Service(getCIMCount) 호출");
		return mddao.selectCIMCount();
	}
	
	public List<MasterdataVO> getSearchCIMList(Map<String, Object> params) {
		logger.debug("Service(getSearchCIMList) 호출");
		return mddao.selectSearchCIMList(params);
	}

	@Override
	public int getSearchCount(Map<String, Object> params) {
		logger.debug("Service(getSearchCount) 호출");
		return mddao.selectSearchCount(params);
	}

	@Override
	public MasterdataVO getCIMContent(MasterdataVO vo) {
		logger.debug("Service(getCIMContent) 호출");
		return mddao.selectCIMContent(vo);
	}

	@Override
	public List<String> getMaterialNames() {
		logger.debug("Service(getMaterialNames) 호출");
		return mddao.selectMaterialNames();
	}

	@Override
	public void editRequires(MasterdataVO vo) {
		logger.debug("Service(editRequires) 호출");
		mddao.updateRequires(vo);
	}

	@Override
	public void delRequires(MasterdataVO vo) {
		logger.debug("Service(delRequires) 호출");
		mddao.deleteRequires(vo);
	}
}

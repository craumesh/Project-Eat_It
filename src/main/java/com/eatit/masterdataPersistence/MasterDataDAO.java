package com.eatit.masterdataPersistence;

import java.util.List;
import java.util.Map;

import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.MasterdataVO;

public interface MasterDataDAO {

	public List<MasterdataVO> getProductList() throws Exception;

	public List<MasterdataVO> getProductListPage(Criteria cri) throws Exception;

	public List<MasterdataVO> getMIMListPage(Criteria cri) throws Exception;

	public List<MasterdataVO> getCIMListPage(Criteria cri);

	public List<MasterdataVO> getFIMListPage(Criteria cri);

	public List<MasterdataVO> getQIMListPage(Criteria cri);

	List<MasterdataVO> getFIMListPage(int page) throws Exception;

	List<MasterdataVO> getProductListPage(int page) throws Exception;

	List<MasterdataVO> getMIMListPage(int page) throws Exception;

	List<MasterdataVO> getQIMListPage(int page) throws Exception;

	public List<MasterdataVO> searchProducts(String keyword) throws Exception;

	public List<MasterdataVO> searchMIM(String keyword) throws Exception;

	public List<MasterdataVO> searchFIM(String keyword);

	public List<MasterdataVO> searchQIM(String keyword);

	public void productInsert(MasterdataVO pvo);

	public int productUpdate(MasterdataVO pvo) throws Exception;

	public void deleteProduct(int product_no, String product_code) throws Exception;

	public int getProductCount() throws Exception;

	public int getMIMCount() throws Exception;

	public int getFIMCount();

	public int getQIMCount();

	public void MIMInsert(MasterdataVO pvo) throws Exception;

	public void FIMInsert(machineVO mvo);

	public int MIMUpdate(MasterdataVO pvo) throws Exception;

	public int FIMUpdate(machineVO mvo);

	public void deleteMIM(int product_no) throws Exception;

	public void deleteFIM(int machine_code);

	public int getPIMSearchCount();

	public int getMIMSearchCount();

	public int getFIMSearchCount();

	public int getQIMSearchCount();

	public void deleteAllProduct(int product_no, String product_code);

	public List<MasterdataVO> getCategoryList();

	public void QIMInsert(MasterdataVO pvo);

	public void QIMTestInsert(MasterdataVO pvo);

	public void deleteQIM(int quality_no, String product_code);

	public List<MasterdataVO> dataList();
	
	public int selectCIMCount();
	
	public List<MasterdataVO> selectSearchCIMList(Map<String, Object> params);
	
	public int selectSearchCount(Map<String, Object> params);

	public MasterdataVO selectMDContent(MasterdataVO pvo);

	public MasterdataVO selectRecipeContent(MasterdataVO pvo);
	
	public MasterdataVO selectCIMContent(MasterdataVO vo);
	
	public List<String> selectMaterialNames();

	public void updateRequires(MasterdataVO vo);
	
	public void deleteRequires(MasterdataVO vo);
}

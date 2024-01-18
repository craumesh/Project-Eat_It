package com.eatit.masterdataService;

import java.util.List;
import java.util.Map;

import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.masterdataDomain.MasterdataVO;

public interface MasterDataService {

	public List<MasterdataVO> ProductList() throws Exception;

	public List<MasterdataVO> productListPage(Criteria cri) throws Exception;

	public List<MasterdataVO> MIMListPage(Criteria cri) throws Exception;

	public List<MasterdataVO> FIMListPage(Criteria cri);

	public List<MasterdataVO> CIMListPage(Criteria cri);

	public List<MasterdataVO> QIMListPage(Criteria cri);

	public List<MasterdataVO> searchProducts(String keyword) throws Exception;

	public List<MasterdataVO> searchMIM(String keyword) throws Exception;

	public List<MasterdataVO> searchFIM(String keyword);

	public List<MasterdataVO> searchQIM(String keyword);

	public void productInsert(MasterdataVO pvo);

	public int productUpdate(MasterdataVO pvo) throws Exception;

	public int FIMUpdate(machineVO mvo);

	public int MIMUpdate(MasterdataVO pvo) throws Exception;

	public void productDelete(int product_no, String product_code) throws Exception;

	public void QIMDelete(int quality_no, String product_code);

	public int totalProductCount() throws Exception;

	public int totalFIMCount();

	public int totalQIMCount();

	public int getMIMCount() throws Exception;

	public void MIMInsert(MasterdataVO pvo) throws Exception;

	public void FIMInsert(machineVO mvo);

	public void MIMDelete(int product_no) throws Exception;

	public void FIMDelete(int machine_code);

	public int searchProductCount();

	public int searchMIMCount();

	public int searchFIMCount();

	public int searchQIMCount();

	public void productAllDelete(int product_no, String product_code);

	public List<MasterdataVO> categoryList();

	public void QIMInsert(MasterdataVO pvo);

	public void QIMTestInsert(MasterdataVO pvo);

	public List<MasterdataVO> dataList();
	
	public int getCIMCount();
	
	public List<MasterdataVO> getSearchCIMList(Map<String, Object> params);
	
	public int getSearchCount(Map<String, Object> params);	

	public MasterdataVO getMDContent(MasterdataVO pvo);

	public MasterdataVO getRecipeContent(MasterdataVO pvo);

	public MasterdataVO getCIMContent(MasterdataVO vo);
	
	public List<String> getMaterialNames();
	
	public void editRequires(MasterdataVO vo);
	
	public void delRequires(MasterdataVO vo);
}

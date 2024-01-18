package com.eatit.productionPersistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionVO;
import com.eatit.productionDomain.production_warehouseVO;
import com.eatit.productionDomain.productionhistoryVO;
import com.eatit.warehouseDomain.StockVO;

@Repository
public class productionDAOImpl implements productionDAO{

	
	private static final Logger logger = LoggerFactory.getLogger(productionDAOImpl.class);
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String NAMESPACE="com.eatit.mapper.productionMapper";
	private static final String NAMESPACE_machine="com.eatit.mapper.machineMapper";



	@Override
	public int machinetotalCount() {
		logger.debug("machinetotalCount()");
		return sqlSession.selectOne(NAMESPACE+".machinetotalCount");
	}


	@Override
	public List<machineVO> machinelistall(Criteria cri) {
		logger.debug("machinlist()");
		return sqlSession.selectList(NAMESPACE_machine + ".machinelistall", cri);
	}
	
	
	
	
	@Override
	public void productionhistory(productionhistoryVO vo) {
		
	  sqlSession.insert(NAMESPACE+ ".productionhistory", vo);
	}


	@Override
	public List<OrdersVO> selectOrderList(Criteria cri) {
		
		return sqlSession.selectList(NAMESPACE + ".selectOrderlist", cri);
	}


	@Override
	public String recipe(Integer product_no) {
	 logger.debug("DAO : recipe");
		return sqlSession.selectOne(NAMESPACE+ ".recipe", product_no);
	}


	@Override
	public List<masterdata_informationVO> category() {
		logger.debug("DAO : category");
		return sqlSession.selectList(NAMESPACE+ ".category");
	}


	@Override
	public masterdata_informationVO nameproduct_no(String name) {
		logger.debug("DAO : nameproduct_no");
		return sqlSession.selectOne(NAMESPACE+ ".nameproduct_no", name);
	}


	@Override
	public StockVO stockname(String name) {
		logger.debug("DAO : stockname");
		return sqlSession.selectOne(NAMESPACE + ".stockname", name);
	}


	@Override
	public production_warehouseVO production_warehouse(String product_name) {
		logger.debug("DAO : production_warehouse");
		return sqlSession.selectOne(NAMESPACE+".production_warehouse", product_name);
	}


	@Override
	public void updatehouse(production_warehouseVO vo) {
		logger.debug("DAO : updatehouse");
		sqlSession.update(NAMESPACE+".updatehouse",vo);
		
	}


	@Override
	public void start(productionVO vo) {
		logger.debug("DAO : start");
		sqlSession.insert(NAMESPACE+".start", vo);
		
		
	}


	@Override
	public int orderid(int order_id) {
		
				
		return sqlSession.selectOne(NAMESPACE + ".orderid" ,order_id); 
	}


	@Override
	public void startproduction(machinehistoryVO vo) {
		sqlSession.update(NAMESPACE+".startproduction",vo);
		
	}


	@Override
	public void update_machine(int machine_code) {
		sqlSession.update(NAMESPACE+ ".update_machine",machine_code);
		
	}


	@Override
	public void update_machinehistory(int machine_code) {
		sqlSession.update(NAMESPACE+ ".update_machinehistory", machine_code);
		
	}


	@Override
	public void start_machine(machineVO vo) {
		sqlSession.update(NAMESPACE + ".start_machine", vo);
		
	}

	
	
}

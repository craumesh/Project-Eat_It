package com.eatit.productionService;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.businessDomain.OrdersVO;
import com.eatit.machineDomain.machineVO;
import com.eatit.mainDomain.Criteria;
import com.eatit.productionDomain.masterdata_informationVO;
import com.eatit.productionDomain.productionVO;
import com.eatit.productionDomain.productionhistoryVO;
import com.eatit.productionPersistence.productionDAO;

@Service
public class productionserviceImpl implements productionservice {

	
	private static final Logger logger = LoggerFactory.getLogger(productionserviceImpl.class);
	
	@Inject
	private productionDAO pddao;


	@Override
	public int machinetotalCount() {
	logger.debug("service : totalCount()");
		return pddao.machinetotalCount();
	}


	@Override
	public List<machineVO> machinelistall(Criteria cri) {
		logger.debug("service : machinelistall()");
		return pddao.machinelistall(cri);
	}


	@Override
	public void productionhistory(productionhistoryVO vo) {
		logger.debug("service : productionhistory");
		pddao.productionhistory(vo);
	}


	@Override
	public List<OrdersVO> getOrderList(Criteria cri) {
		
		return pddao.selectOrderList(cri);
	}


	@Override
	public String recipe(Integer product_no) {
		logger.debug("Service : recipe");
		return pddao.recipe(product_no);
	}


	@Override
	public List<masterdata_informationVO> category() {
		logger.debug("Service : category");
		return pddao.category();
	}
	
	
	
	
	
	
	
}

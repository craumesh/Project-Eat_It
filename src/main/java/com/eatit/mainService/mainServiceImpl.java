package com.eatit.mainService;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.eatit.mainDomain.mainVO;
import com.eatit.mainPersistence.mainDAO;

@Service
public class mainServiceImpl implements mainService {
	private static final Logger logger = LoggerFactory.getLogger(mainServiceImpl.class);
	
	@Inject
	private mainDAO mdao;

	@Override
	public Map<String, Object> selectOrderChart() {
		logger.debug("Service : selectOrderChart");
		
		List<mainVO> yearsList = mdao.selectChartYear();
		List<mainVO> monthList = mdao.selectChartMonth();
		
		logger.debug("yearsList : "+yearsList);
		logger.debug("monthList : "+monthList);
		
		LocalDate today = LocalDate.now();

        // 월과 년도 추출
        String month = String.valueOf(today.getMonthValue());
        logger.debug("month : "+month);
        String year = String.valueOf(today.getYear());
		
		Map<String, Integer> yearsOrdersMap = new HashMap<String, Integer>();
		
		for(mainVO mvo: yearsList) {
			int sumQuantity = 0;
			List<mainVO> yearsOrdersList = mdao.selectYearsOrder(mvo);
			for(int i = 0; i<yearsOrdersList.size(); i++) {
				sumQuantity += yearsOrdersList.get(i).getQuantity();
			}
			yearsOrdersMap.put(mvo.getOrder_year(),sumQuantity);
		}	
		
		Map<String, Integer> monthOrdersQuantityMap = new LinkedHashMap<String, Integer>();
		Map<String, Float> monthOrdersPriceMap = new LinkedHashMap<String, Float>();
		
		for(mainVO mvo: monthList) {
			logger.debug("mvo : "+mvo);
			monthOrdersQuantityMap.put(mvo.getOrder_year()+"-"+mvo.getOrder_month(), mdao.selectMonthOrders(mvo).getQuantity());
			monthOrdersPriceMap.put(mvo.getOrder_year()+"-"+mvo.getOrder_month(), mdao.selectMonthOrders(mvo).getPrice());
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("yearsOrdersMap",yearsOrdersMap);
		resultMap.put("monthOrdersQuantityMap", monthOrdersQuantityMap);
		resultMap.put("monthOrdersPriceMap", monthOrdersPriceMap);
		resultMap.put("nowMonthOrdersPrice", monthOrdersPriceMap.get(year+"-"+month));
		resultMap.put("nowmonthOrdersQuantity", monthOrdersQuantityMap.get(year+"-"+month));
		resultMap.put("nowYearOrdersQuantity", yearsOrdersMap.get(year));
		resultMap.put("nowYearOrdersPrice", mdao.selectNowYearPrice());
		resultMap.put("recentUpdate", mdao.selectRecentUpdate());
		logger.debug("resultMap : "+resultMap);
		
		return resultMap;
	}
}

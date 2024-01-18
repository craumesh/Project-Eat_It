package com.eatit.mainPersistence;

import java.util.List;

import com.eatit.mainDomain.mainVO;

public interface mainDAO {	
	public List<mainVO> selectOrderChart();
	
	public List<mainVO> selectChartYear();
	
	public List<mainVO> selectChartMonth();
	
	public List<mainVO> selectYearsOrder(mainVO vo);
	
	public mainVO selectMonthOrders(mainVO vo);
	
	public mainVO selectNowYearPrice();
	
	public mainVO selectRecentUpdate();
}

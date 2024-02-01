package com.eatit.mainController;

import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eatit.mainService.mainService;

@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Inject
	private mainService mService;
	
	//http://localhost:8088
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		logger.debug("/main Get 호출  => mainPage()실행");
		
		return "main";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> orderChart(){
		logger.debug("/main Post 호출  => orderChart()실행");
		return mService.selectOrderChart();
	}
	
	@RequestMapping(value="/login",method=RequestMethod.GET)
	public void logintest() {
		logger.debug("/login 호출  => logintest()실행");
	}
	
}

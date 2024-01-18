package com.eatit.memberController;

import java.util.Arrays;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.eatit.memberDomain.MemberVO;
import com.eatit.memberService.MemberService;

@Controller
@RequestMapping(value = "/members/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	// 서비스 객체 주입
	@Inject
	private MemberService mService;
	
	// 로그인 - 정보 입력(GET)
	// http://localhost:8088/members/memberLogin
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public void memberLoginGET() throws Exception{
		logger.debug("/members/memberLogin 호출 -> memberLoginGET() 실행");
	}
	
	// 로그인 - 정보 처리(POST)
	@RequestMapping(value="memberLogin", method = RequestMethod.POST)
	public String memberLoginPOST(MemberVO vo, HttpSession session, RedirectAttributes rttr) {
		logger.debug("/members/login.jsp post방식 호출 ");
		
		// 전달정보 저장
		logger.debug("전달정보 : "+vo);
		
		// 디비 접근
		MemberVO resultVO = mService.memberLogin(vo);
		
		if(resultVO != null && resultVO.getId() != null) {
			// O => 메인페이지 호출(리다이렉트), 세션 아이디 정보 저장
			if ("대기".equals(resultVO.getActive())) {
		        logger.debug("승인 대기중");
		        rttr.addFlashAttribute("result", "WAIT");
		        return "redirect:/members/memberLogin";
		    } else {
		        logger.debug("아이디 있음");
		        session.setAttribute("no", resultVO.getEmployee_no());
		        session.setAttribute("id", resultVO.getId());
		        session.setAttribute("name", resultVO.getName());
		        session.setAttribute("photo", resultVO.getPhoto_paths());
		        session.setAttribute("depart_name", resultVO.getDepart_name());
		        rttr.addFlashAttribute("result", "LOGIN");
		        return "redirect:/";
		    }
		}
		else {
			// X => /members/memberLogin 페이지 호출
			rttr.addFlashAttribute("result","FAILLOGIN");
			return "redirect:/members/memberLogin";
		}
	}
	
	// http://localhost:8088/members/memberJoin
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public void memberJoinGET() throws Exception{
		logger.debug("/members/memberJoin 호출 -> memberJoinGET() 실행");
	}
	
	//회원가입(정보처리)
	@RequestMapping(value="/memberJoin", method = RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo , RedirectAttributes rttr){
		logger.debug("memberJoinPOST() 호출");
		
		logger.debug("vo : "+vo);
		
		
		mService.memberJoin(vo);
		
		rttr.addFlashAttribute("result","JOIN");
		
		return "redirect:/members/memberLogin";
	}
	
	// 로그아웃
	@RequestMapping(value="/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGET(HttpSession session, RedirectAttributes rttr){
		
		session.invalidate();
		logger.debug("로그아웃");
		
		rttr.addFlashAttribute("result", "LOGOUT");
		
		return "redirect:/";
		
	}
	
	@RequestMapping(value="/profile", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public MemberVO memberProfile(HttpSession session) {
		logger.debug("내 정보 출력");
		
		MemberVO vo = new MemberVO();
		vo.setId((String) session.getAttribute("id"));
	
		
		return mService.memberProfile(vo);
	}
	
   @RequestMapping(value = "/profile", method = RequestMethod.POST)
   public String profilePost(MemberVO vo, @RequestParam("prev-url") String prev_url) {
      logger.debug("/profile 호출 -> profilePOST() 실행");
      mService.memberUpdateProfile(vo); 
      
      return "redirect:/"+prev_url.substring(22);
   }
}

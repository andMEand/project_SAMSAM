package com.project.samsam.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class JJMemberController {

	@Autowired
	private MemberSV  memberSV;
	@Autowired
	private MailSendService mss;
	

	
	@RequestMapping("/home.me")
	public String mainPage() throws Exception {
		return "/main";
	}
	
	@RequestMapping(value = "/loginForm.me")
	public String login_Form() {

		return "jj/loginForm";
	}
	
	//email overlap check
		@RequestMapping(value="/idcheckajax.do",
				produces="application/json;charset=utf-8")
		@ResponseBody
		public  Map<String , Object> idcheck(@RequestBody   Map<String , Object> map) throws Exception{
			System.out.println("join id ajax check");
			String email =(String) map.get("email");
			int checkid = memberSV.idCheck(email);	
			if(checkid == 0 ) {
			System.out.println("checkres=" + checkid);
			map.put("email", "ZERO");
			return map;
			}
			else {
				System.out.println("checkres=" + checkid);
				map.put("email", "A");
				return map;
				}
			}
		//nick overlap check
		@RequestMapping(value="/nickcheckajax.do",
				produces="application/json;charset=utf-8")
		@ResponseBody
		public  Map<String , Object> nickcheck(@RequestBody   Map<String , Object> map) throws Exception{
			String nick =(String) map.get("nick");
			int checked = memberSV.nickCheck(nick);	
			if(checked == 0 ) {
			System.out.println("checkres=" + checked);
			map.put("nick", "ZERO");
			return map;
			}
			else {
				System.out.println("checkres=" + checked);
				map.put("nick", "A");
				return map;
				}
			}
		
	@RequestMapping(value = "/kkoLogin.me")
	public String kko_Join(MemberVO mvo, Model model, RedirectAttributes redi_attr) {
		System.out.println("이메일: " + mvo.getEmail() + "닉네임 : " + mvo.getNick());
		
		MemberVO vo = memberSV.selectMember(mvo.getEmail());
		if(vo != null && !(vo.getGrade().equals("카카오"))){
			
			return "jj/loginForm";
		}
		if(memberSV.selectMember(mvo.getEmail()) == null) {
			mvo.setGrade("카카오");
			model.addAttribute("MemberVO", mvo);
			return "jj/k_joinForm";
		}
		else {
			redi_attr.addAttribute("email", mvo.getEmail());
			return "redirect:/login.me";
			}
	}
	
	//네이버 콜백
		@RequestMapping(value = "/callback.me")
		public String nid_callback(MemberVO mvo, Model model, RedirectAttributes redi_attr) {
			
			return "jj/callBack";
		}
		
	//네이버
	@RequestMapping(value = "/nidLogin.me")
	public String nid_Join(MemberVO mvo, Model model, RedirectAttributes redi_attr) {
		System.out.println("네이버이메일: " + mvo.getEmail() + "닉네임 : " + mvo.getNick());
		
		MemberVO vo = memberSV.selectMember(mvo.getEmail());
		if(vo != null && !(vo.getGrade().equals("네이버"))){
			return "jj/loginForm";
		}
		if(memberSV.selectMember(mvo.getEmail()) == null) {
			mvo.setGrade("네이버");
			model.addAttribute("MemberVO", mvo);
			return "jj/k_joinForm";
		} 
		else {
			redi_attr.addAttribute("email", mvo.getEmail());
			System.out.println("nidLogin else");
			return "redirect:/login.me";
		}
			
	}
	
	//소셜계정 회원가입
	@RequestMapping(value = "/kkoJoin.me")
	public String kko_joinProcess(MemberVO mvo) {
		if(mvo.getGrade().equals("카카오")) {
			mvo.setAuthkey("kkoAuth");
			mvo.setStatus("1");
			System.out.println("카카오회원가입" + mvo.getGrade());
		}
		else if(mvo.getGrade().equals("네이버")) {
			mvo.setAuthkey("nidAuth");
			mvo.setStatus("1");
			System.out.println("네이버회원가입" + mvo.getGrade());
		}
		int res = memberSV.k_joinMember(mvo);
		if(res == 1) {
			return "jj/loginForm";
		}
		else {
			return "jj/k_joinform";
		}
	}

	
	@RequestMapping(value = "/login.me")
	public String userCheck(@RequestParam("email") String email, MemberVO vo, HttpSession session) throws Exception {
		System.out.println("로그인 이메일 "+vo.getEmail());
		System.out.println("로그인 비밀번호 "+vo.getPw());
		
		//어드민
		if(vo.getEmail().equals("admin")) {
			session.setAttribute("id", vo.getEmail());
			session.setAttribute("email", vo.getEmail());
			
			return "redirect:/admin_main.me";  //어드민 페이지로 변경 필요
		}
		//카카오
		MemberVO res = memberSV.selectMember(vo.getEmail());
		if(res.getGrade().equals("카카오")) {
			session.setAttribute("email", res.getEmail());
			Biz_memberVO bo = memberSV.selectBizMember(vo.getEmail());
			if(bo != null) {
				if(bo.getStatus() == 0) {
					return "redirect:/cominfo_main.do";//사업자 마이페이지로 변경 필요
				}
			}
			return "redirect:/myinfo_check.me";//마이페이지로 변경 필요
		}
		//네이버
		if(res.getGrade().equals("네이버")) {
			session.setAttribute("email", res.getEmail());
			Biz_memberVO bo = memberSV.selectBizMember(vo.getEmail());
			if(bo != null) {
				if(bo.getStatus() == 0) {
					return "redirect:/cominfo_main.do";//사업자 마이페이지로 변경 필요
				}
			}
			return "redirect:/myinfo_check.me";//마이페이지로 변경 필요
		}
		//일반	
		if(res.getPw().equals(vo.getPw())) {
			
			session.setAttribute("id", res.getEmail());
			session.setAttribute("email", res.getEmail());
			System.out.println("session id :" +session.getAttribute("id"));
			System.out.println("session email :" +session.getAttribute("email"));
			//사업자회원인지 확인
			Biz_memberVO bo = memberSV.selectBizMember(vo.getEmail());
			if(bo != null) {
				if(bo.getStatus() == 0) {
					return "redirect:/cominfo_main.do";  //사업자 마이페이지로 변경 필요
				}
			}
			return "redirect:/myinfo_check.me";  
		}else {
			return "redirect:/loginForm.me";
		}
	}
	//join
	@RequestMapping("/joinform.me")
	public String joinForm() throws Exception {
		return "jj/joinForm";
	}
///////////////////////////////////
	
	@RequestMapping("/signUp.me")
	public String signUp(@ModelAttribute MemberVO memberVO) {
		System.out.println(memberVO.getNick());
		 // DB에 기본정보 insert
		int res= memberSV.joinMember(memberVO);
		System.out.println("insert compl"+res);
		//random authKey create & email send
		String authkey = mss.sendAuthMail(memberVO.getEmail());
		memberVO.setAuthkey(authkey);
		System.out.println("authkey send : " + authkey);
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", memberVO.getEmail());
		map.put("authkey", memberVO.getAuthkey());
		System.out.println("map" + map.get("email") + "suthkey  " + map.get("authkey"));
		
		//DB에 authKey업데이트
		memberSV.updateAuthkey(map);
		return "jj/email_check";
	}
	
	 @GetMapping("/signUpConfirm.me")
	 public ModelAndView signUpConfirm(@RequestParam HashMap<String, Integer> map, ModelAndView mav){
		//email, authKey 가 일치할경우 authStatus 업데이트
		System.out.println("connection  email :" + map.get("email"));
	    memberSV.updateAuthStatus(map);
	    System.out.println("connection  email2 :" + map.get("email"));
	    mav.addObject("display", "/jj/loginForm.jsp");
	    mav.setViewName("/jj/loginForm");
	    return mav;
	}

	//로그아웃
	@RequestMapping(value = "/logout.me")
	public String logout(HttpSession session)throws IOException {
	   System.out.println("logout");
	   System.out.println("세션 : "+ (String)session.getAttribute("email"));
	   session.removeAttribute("email");
	   System.out.println("세션삭제후 : "+ (String)session.getAttribute("email"));
		              
	   return "redirect:/home.me";
	}
}
package com.spring.javaProjectS.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS.service.MemberService;
import com.spring.javaProjectS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 로그인 폼 보여주기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인 체크하기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "hkd1234", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave) {
		
		MemberVO vo = memberService.getMemberidCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 1.세션처리
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			
			// 2.쿠키저장/삭제
			//System.out.println("아이디 저장 : "+idSave);
			
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				//cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}

	// 로그아웃 처리하기
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	// 회원메인폼 보여주기
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet() {
		return "member/memberMain";
	}

	// 회원가입폼 보여주기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	// 회원가입처리하기
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo) {
		// 아이디 중복체크
		if(memberService.getMemberidCheck(vo.getMid())!=null) return "redirect:/message/idCheckNo";
		if(memberService.getMemberNickCheck(vo.getNickName())!=null) return "redirect:/message/nickCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd())); 
		
		// 회원사진 처리(service객체에서 처리 후 DB에 저장하기)
		int res = memberService.setMemberJoinOk(vo);
		
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberidCheck(mid);

		if(vo != null) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDeleteGet(HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		
		int res = memberService.setMemberDeleteUpdate(mid);
		
		if(res == 1) return "redirect:/message/memberDeleteOk";
		else return "redirect:/message/memberDeleteNo";
	}
	
	@RequestMapping(value = "/memberpwdCheck", method = RequestMethod.GET)
	public String memberpwdCheckGet() {
		return "member/memberPwdUpdate";
	}

	@ResponseBody
	@RequestMapping(value = "/memberpwdCheck", method = RequestMethod.POST)
	public String memberpwdCheckPost(HttpSession session, HttpServletRequest request, String pwd) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberidCheck(mid);
		if(passwordEncoder.matches(pwd, vo.getPwd())) return "1";
		else return "0";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberNewPwdUpdate", method = RequestMethod.POST)
	public int memberNewPwdUpdatePost(HttpSession session, HttpServletRequest request, String newPwd) {
		String mid = (String) session.getAttribute("sMid");
		
		String pwd = passwordEncoder.encode(newPwd);
		
		int res = memberService.setNewPwd(pwd, mid);
		
		return res;
	}
	
	@RequestMapping(value = "/memberInforUpdate", method = RequestMethod.GET)
	public String memberInforUpdateGet(Model model, HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		
		MemberVO vo = memberService.getMemberidCheck(mid);
		
		// 전화번호 분리(-)
		String[] tel = vo.getTel().split("-");
		if(tel[1].equals(" ")) tel[1] = "";
		if(tel[2].equals(" ")) tel[2] = "";
		model.addAttribute("tel1", tel[0]);
		model.addAttribute("tel2", tel[1]);
		model.addAttribute("tel3", tel[2]);
		
		// 주소분리(/)
		String[] address = vo.getAddress().split("/");
		if(address[0].equals(" ")) address[0] = "";
		if(address[1].equals(" ")) address[1] = "";
		if(address[2].equals(" ")) address[2] = "";
		if(address[3].equals(" ")) address[3] = "";
		model.addAttribute("postcode", address[0]);
		model.addAttribute("roadAddress", address[1]);
		model.addAttribute("detailAddress", address[2]);
		model.addAttribute("extraAddress", address[3]);
		
		// 취미는 통째로 넘겨서 JSTL에서 처리하기로 한다.
		model.addAttribute("hobby", vo.getHobby());
		
		model.addAttribute("vo", vo);
		
		return "member/memberInforUpdate";
	}

	@RequestMapping(value = "/memberInforUpdate", method = RequestMethod.POST)
	public String memberInforUpdatePost(MemberVO vo, HttpSession session, HttpServletRequest request
			) {
		String mid = (String) session.getAttribute("sMid");
		
		int res = memberService.setMemberInforUpdate(vo);
		
		if(res == 1) return "redirect:/message/memberInforUpdateOk";
		else return "redirect:/message/memberInforUpdateNo";
	}
	
}

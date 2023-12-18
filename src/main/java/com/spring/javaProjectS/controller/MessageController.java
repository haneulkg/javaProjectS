package com.spring.javaProjectS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, String mid, Model model) {
		
		if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "선택한 회원이 삭제되었습니다.");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "회원 삭제 실패, 다시 시도해주세요.");
			model.addAttribute("url", "user/userList");
		}
		else if(msgFlag.equals("user2DeleteOk")) {
			model.addAttribute("msg", "선택한 회원이 삭제되었습니다.");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2DeleteNo")) {
			model.addAttribute("msg", "회원 삭제 실패, 다시 시도해주세요.");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2InputOk")) {
			model.addAttribute("msg", "회원 가입 성공");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2InputNo")) {
			model.addAttribute("msg", "회원 가입 실패");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2UpdateOk")) {
			model.addAttribute("msg", "회원 수정 성공");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("user2UpdateNo")) {
			model.addAttribute("msg", "회원 수정 실패");
			model.addAttribute("url", "user2/user2List");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록 등록 성공");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 등록 실패");
			model.addAttribute("url", "guest/guestInput");
		}
		else if(msgFlag.equals("adminLoginOk")) {
			model.addAttribute("msg", "관리자 인증 성공");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("adminLoginNo")) {
			model.addAttribute("msg", "관리자 인증 실패");
			model.addAttribute("url", "guest/adminLogin");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("msg", "선택한 글 삭제 완료");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("msg", "선택한 글 삭제 실패");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("msg", "관리자 로그아웃됨");
			model.addAttribute("url", "guest/guestList");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일전송완료");
			model.addAttribute("url", "study/mail/mail");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃 되셨습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
//		else if(msgFlag.equals("idCheckNo")) {
//			model.addAttribute("msg", "이미 존재하는 아이디가 있습니다, 다른 아이디를 사용해주세요.");
//			model.addAttribute("url", "member/memberJoin");
//		}
//		else if(msgFlag.equals("nickCheckNo")) {
//			model.addAttribute("msg", "이미 존재하는 닉네임이 있습니다, 다른 닉네임을 사용해주세요.");
//			model.addAttribute("url", "member/memberJoin");
//		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입완료");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입실패");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "회원탈퇴신청 완료");
			model.addAttribute("url", "member/memberLogout");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "회원탈퇴신청 실패");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberInforUpdateOk")) {
			model.addAttribute("msg", "회원정보수정 성공");
			model.addAttribute("url", "member/memberMain");
		}
		else if(msgFlag.equals("memberInforUpdateOk")) {
			model.addAttribute("msg", "회원정보수정 실패");
			model.addAttribute("url", "member/memberInforUpdate");
		}
		
		return "include/message";
	}
}

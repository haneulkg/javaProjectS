package com.spring.javaProjectS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaProjectS.service.UserService;
import com.spring.javaProjectS.vo.UserVO;

@Controller
@RequestMapping("/user2")
public class User2Controller {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/user2List", method = RequestMethod.GET)
	public String user2ListGet(Model model) {
		
		List<UserVO> vos = userService.getUser2List();
		
		model.addAttribute("vos", vos);
		
		return "study/user/user2List";
	}

	@RequestMapping(value = "/user2List", method = RequestMethod.POST)
	public String user2ListPost(UserVO vo) {
		
		int res = userService.setUser2Input(vo);
		
		if(res != 0) return "redirect:/message/user2InputOk";
		else return "redirect:/message/user2InputNo";
	}
	
	@RequestMapping(value = "/user2Search", method = RequestMethod.GET)
	public String user2SearchGet(String name,Model model) {
		
		List<UserVO> vos = userService.getUser2Search(name);
		
		model.addAttribute("vos", vos);
		model.addAttribute("name", name);
		
		return "study/user/user2List";
		
	}
	
	@RequestMapping(value = "/user2Delete", method = RequestMethod.GET)
	public String user2DeleteGet(int idx) {
		
		int res = userService.setUser2Delete(idx);
		
		if(res != 0) return "redirect:/message/user2DeleteOk";
		else return "redirect:/message/user2DeleteNo";
	}
	
	@RequestMapping(value = "/user2Update", method = RequestMethod.POST)
	public String user2UpdatePost(int idx, String name, int age, String address) {
		
		int res = userService.setUser2Update(idx, name, age, address);
		
		if(res != 0) return "redirect:/message/user2UpdateOk";
		else return "redirect:/message/user2UpdateNo";
	}
	
}

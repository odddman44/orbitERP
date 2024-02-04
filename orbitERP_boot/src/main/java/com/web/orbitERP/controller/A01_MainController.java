package com.web.orbitERP.controller;






import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.orbitERP.service.A01_MainService;
import com.web.orbitERP.vo.Erpmem;

import jakarta.servlet.http.HttpSession;




@Controller
public class A01_MainController {
	@Autowired(required = false)
	private A01_MainService service;
	
	/* 1. 로그인 창 */
	//  http://localhost:4444/login
	//  http://211.63.89.67:4444/orbitERP/login.do
	@GetMapping("login")
	public String login1() {
		return "a01_main\\a83_login";
	}
	@PostMapping("login")
	public String login(Erpmem mem, HttpSession session) {
		Erpmem emem = service.login(mem);
		if(emem!=null) {
			session.setAttribute("emem", emem);
		}
		return "a01_main\\a83_login";
	}
	
	@GetMapping("logout")
	public String logout(HttpSession session) {    
		session.invalidate();
	    return "redirect:/login";
	}
	
	/* 2. 메인 홈페이지 이동*/
	// http://localhost:4444/main
	// http://211.63.89.67:4444/orbitERP/main.do
	@RequestMapping("main")
	public String mainIndex() {
		return "a01_main\\a01_index";
	}
	
	
}

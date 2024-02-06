package com.web.orbitERP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A01_MainService;
import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.Erpmem;

import jakarta.servlet.http.HttpSession;

@Controller
public class A01_MainController {
	@Autowired(required = false)
	private A01_MainService service;

	@Autowired(required = false)
	private A02_HRService hrService;

	/* 1. 로그인 창 */
	// http://localhost:4444/login
	// http://211.63.89.67:4444/login
	@GetMapping("login")
	public String login1() {
		return "a01_main\\a83_login";
	}

	@PostMapping("login")
	public String login(Erpmem mem, HttpSession session) {
		Erpmem emem = service.login(mem);
		if (emem != null) {
			session.setAttribute("emem", emem);
		}
		return "a01_main\\a83_login";
	}

	@GetMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	/* 2. 메인 홈페이지 이동 */
	// http://localhost:4444/main
	// http://211.63.89.67:4444/main
	@RequestMapping("main")
	public String mainIndex() {
		return "a01_main\\a01_index";
	}

	// http://localhost:4444/mypage
	@RequestMapping("mypage")
	public String mypage(@RequestParam("empno") String empno, Model d) {
		if (hrService.empDetail(empno) != null) {
			d.addAttribute("employee", hrService.empDetail(empno));
			if(hrService.getEmpProfie(empno)!=null) {
				d.addAttribute("fname", hrService.getEmpProfie(empno).getFname());
			}

		}
		return "a02_humanResource\\a08_myPage";

	}
	
	public String updateMyInfo(Employee upt, Model d) {
		return "a02_humanResource\\a08_myPage";
	}
}

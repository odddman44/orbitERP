package com.web.orbitERP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A01_MainService;
import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.A03_PRService;
import com.web.orbitERP.vo.AttendanceSch;
import com.web.orbitERP.vo.Erpmem;

import jakarta.servlet.http.HttpSession;

@Controller
public class A01_MainController {
	@Autowired(required = false)
	private A01_MainService service;

	@Autowired(required = false)
	private A02_HRService hrService;
	
	@Autowired(required = false)
	private A03_PRService prService;

	/* 1. 로그인 창 */
	// http://localhost:4444/login
	// http://211.63.89.67:4444/login
	@GetMapping("login")
	public String login1() {
		return "a01_main\\a83_login";
	}

	@PostMapping("login")
	public String login(Erpmem mem, HttpSession session,Model d) {
		Erpmem emem = service.login(mem);
		if (emem != null) {
			session.setAttribute("emem", emem);
		}
		d.addAttribute("alList",prService.alList(emem.getEmpno()));
		return "a01_main\\a83_login";
	}
	
	@GetMapping("multiLang")
    public String changeLanguage(HttpSession session) {
        return "redirect:/login"; 
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
	//알람정보 보내기
	@RequestMapping("topAlram")
	public String topAlram(String receiver,Model d) {
		d.addAttribute("alList",prService.alList(receiver));
		return "pageJsonReport";
	}
//	@RequestMapping("topAlram")
//	public ResponseEntity<?> topAlram(String receiver) {
//		return ResponseEntity.ok(prService.alList(receiver));
//	}

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
	
	// http://localhost:4444/myattList
	@RequestMapping("myattList")
	public String myattList(AttendanceSch sch, Model d) {
		d.addAttribute("attendanceList", hrService.getAttMine(sch));
		return "a02_humanResource\\a09_myAttendanceList";
	}
	
}

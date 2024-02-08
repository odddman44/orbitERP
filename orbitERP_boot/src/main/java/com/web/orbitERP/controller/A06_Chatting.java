package com.web.orbitERP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.orbitERP.service.A01_MainService;
import com.web.orbitERP.vo.Erpmem;

import jakarta.servlet.http.HttpSession;

@Controller
public class A06_Chatting {
	// http://localhost:4444/chatting
	// http://211.63.89.67:4444/orbitERP/chatting
	@GetMapping("chatting")
	public String chatting() {

		return "a06_chatting\\a01_chatting";
	}

}

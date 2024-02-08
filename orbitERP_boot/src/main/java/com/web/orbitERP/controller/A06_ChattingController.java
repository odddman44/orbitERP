package com.web.orbitERP.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class A06_ChattingController {
	// http://localhost:4444/chatting
	// http://211.63.89.67:4444/orbitERP/chatting
	@GetMapping("chatting")
	public String chatting() {

		return "a06_chatting\\a01_chatting";
	}
	
}

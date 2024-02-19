package com.web.orbitERP.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class A13_MsgController {
	// http://localhost:4444/message
	@GetMapping("message") //메시지 페이지 열기
	public String chatting() {
		return "a03_planResource\\a22_msg";
	}		
	
    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public String greeting(String message) {
    	System.out.println("# 메시지 전송 #"+message);
    	//DB저장용임
    	
        return message;
    }
}

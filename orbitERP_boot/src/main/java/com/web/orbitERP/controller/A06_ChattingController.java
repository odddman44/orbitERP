package com.web.orbitERP.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A08_ChatService;
import com.web.orbitERP.vo.ChRoomInfo;


@Controller
public class A06_ChattingController {
	
	@Value("${socketServer}")
	private String socketServer;
	
	// http://localhost:4444/chatting
	// http://211.63.89.67:4444/orbitERP/chatting
	@GetMapping("chatting")
	public String chatting(Model d) {
		d.addAttribute("socketServer", socketServer);
		return "a06_chatting\\\\a01_chatting";
	}	
	@Autowired
	private A08_ChatService service;
	// enterChRoom
	@PostMapping("enterChRoom")
	public String enterChRoom(ChRoomInfo croom, Model d) {
		d.addAttribute("result", service.insChatRoom(croom));
		d.addAttribute("conIds", service.getChRoomIds(croom.getId()));
		d.addAttribute("conRooms", service.getChRooms());
		
		return "pageJsonReport";
	}
	@GetMapping("conRooms")
	public String conRooms(Model d) {
		d.addAttribute("conRooms", service.getChRooms());
		
		return "pageJsonReport";
	}	
	@GetMapping("conIds")
	public String conIds(@RequestParam("chroom") String chroom, Model d) {
		d.addAttribute("conIds", service.getIdsByRoom(chroom));
		
		return "pageJsonReport";
	}		
	@PostMapping("exitChRoom")	
	public String delChatRoom(ChRoomInfo croom, Model d) {
		d.addAttribute("result", service.delChatRoom(croom));
		return "pageJsonReport";
	}
	
}

package com.web.orbitERP.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A08_ChatDao;
import com.web.orbitERP.vo.ChRoomInfo;


@Service
public class A08_ChatService {
	@Autowired
	private A08_ChatDao dao;
	public String insChatRoom(ChRoomInfo ins) {
		return dao.insChatRoom(ins)>0?"입장성공":"입장실패";
	}
	
	public String delChatRoom(ChRoomInfo del) {
		return dao.delChatRoom(del)>0?"퇴장성공":"퇴장실패";
	}

	public List<String> getChRooms(){
		return dao.getChRooms();
	}
	public List<String> getChRoomIds(String id){
		return dao.getChRoomIds(id);
	}	
	public List<String> getIdsByRoom(String chroom){
		return dao.getIdsByRoom(chroom);
	}		
	/*
	@Autowired(required=false)
	private ChattingHandler chatHandler;
	public boolean getCurIds(String id) {
		boolean hasIds=false;
		if(chatHandler.getCurLoginIds()!=null) {
			for(String sessId : chatHandler.getCurLoginIds()) {
					if(id.equals(sessId)) hasIds=true;
			}
		}
		return hasIds;
	}
	*/
}

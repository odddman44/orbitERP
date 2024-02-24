package com.web.orbitERP.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.web.orbitERP.dao.A08_ChatDao;




//컨테이너에서 handler이름 chatHandler와  front단에서 ${path}/chat-ws.do
//연동할 수 있게 선언된다.
@Component("chatHandler")
public class ChattingHandler extends TextWebSocketHandler{
	// 접속한 계정을 저장하는 필드 선언.
	private Map<String, WebSocketSession> users = new ConcurrentHashMap();
	
	// himan:접속했습니다.
	// himan-소켓세션저장
	private Map<String, WebSocketSession> userIds = new ConcurrentHashMap();
	private Map<String, String> ser_cli = new ConcurrentHashMap();

	// var wsocket = new WebSocket() js로 선언 후
	// 1. 소켓 서버에 접속시 처리 메서드(onopen())
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		users.put(session.getId(), session);
		log(session.getId()+"님 접속합니다!! 현재 접속자 수:"+users.size());
		
		
	}
	@Autowired(required=false)
	private A08_ChatDao dao;
	// 2. 소켓 서버에 메시지 전송시 처리 메서드
	///   하나의 클라이언트가 메서지를 넘겨줄 때 : wsocket.send("msg:"+$("#id").val()+":메시지 전달");
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 1) 특정한 client를 통해 전달해온 메시지를 출력
		//    himan:안녕하세요
		log(session.getId()+"에서 온 메시지:"+message.getPayload());
		String clid = (String)(message.getPayload()).split(":")[0];
		String msg = (String)(message.getPayload()).split(":")[1];
		if(msg.equals("접속하셨습니다!")) {
			System.out.println("세션 등록 처리");
			userIds.put(clid, session);
			ser_cli.put(session.getId(), clid);
		}
		/*
		if(msg.equals("접속종료하셨습니다!")) {
			System.out.println("세션 삭제 처리");
			userIds.remove(clid);
			ser_cli.remove(session.getId());
		}
		*/		
		
		
		List<String> sendClints = dao.getChRoomIds(clid);
		List< WebSocketSession> sndusers= new ArrayList<WebSocketSession>();
		System.out.println("# 전송할 계정 #");
		for(String cid : sendClints) {
			
			sndusers.add( userIds.get(cid) );
			System.out.println(cid+":"+userIds.get(cid));
		}
		for(WebSocketSession ws:sndusers) {
			ws.sendMessage(message);
			
		}		
		// 2) 현재 접속한 모든 계정에 메시지 전달
		/*
		for(WebSocketSession ws:users.values()) {
			// 1. 각 접속한 클라이언트에게 메시지 전달
			ws.sendMessage(message);
			//     클라이언트에서 push방식으로 메시지를 받는 부분.
			// 	wsocket.onmessage=function(evt){
			// 2. 각 전달할 사용자 및 메시지 확인
			log(ws.getId()+"에게 전달 메시지:"+message.getPayload());
		}
		*/
	}
	// 3. 소켓 서버 종료시 처리 메서드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		//String delCliId = ser_cli.get( session.getId() );
		//dao.delChatRoom(delCliId);
		// 1) 기능 등록자에서 제거 처리
		
		users.remove(session.getId());
		String delId = ser_cli.get(session.getId());
		log(delId+" 님 접속 종료합니다");
		userIds.remove(delId);
		dao.delChatId(delId);
		log(session.getId()+" 접속 종료합니다.");
	}
	// 4. 에러발생시 처리 메서드 
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		 log(session.getId()+"에러 발생! 에러내용"+exception.getMessage());
		 //session.sendMessage( "에러 발생! 에러내용"+exception.getMessage());
	}
	// # 기본 로그 처리
	private void log(String logMsg) {
		System.out.println(new Date()+":"+logMsg);
	}
}
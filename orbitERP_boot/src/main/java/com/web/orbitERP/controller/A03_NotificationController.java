package com.web.orbitERP.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.web.orbitERP.service.A03_NotificationService;


@RestController
public class A03_NotificationController {

	private A03_NotificationService notificationService;
	
	public A03_NotificationController(A03_NotificationService notificationService) {
		this.notificationService = notificationService;
	}
	
	// @title 로그인 한 유저 sse연결
	@GetMapping(value="/subscribe/{id}",produces="text/event-stream")
	// Last-Event-ID 는 클라이언트가 마지막으로 수신한 데이터의 id값을 의미한다.
	// 연결이 끓어져도 이를 이용하여 유실된 데이터를 다시 보내줄 수 있다.
	public SseEmitter subscribe(@PathVariable long id,
								@RequestHeader(value = "Last-Event-ID",required = false, defaultValue = "")
								String lastEventId) {
		return notificationService.subscribe(id,lastEventId);
	}
	
}

package com.web.orbitERP.service;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Repository
public class EmitterRepository {
	// 모든 Emitters를 저장하는 ConcurrentHashMap
	private final Map<String, SseEmitter> emitters = new ConcurrentHashMap<>();
	
	// 주어진 아이디와 이미터를 저장
	//@Param id - 사용자 아이디
	//@Param emitter - 이벤트 Emitter
	
	public SseEmitter save(String id, SseEmitter emitter) {
		return emitters.put(id, emitter);
	}
	
	//주어진 아이디와 이미터를 제거
	public void deleteById(String id) {
		emitters.remove(id);
	}
	
	//주어진 아이디의 Emitter를 가져옴
	public SseEmitter get(String id) {
		return emitters.get(id);
	}

	public Map<String, Object> findAllEventCacheStartWithId(String valueOf) {
		// TODO Auto-generated method stub
		return null;
	}
	

}

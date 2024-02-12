package com.web.orbitERP.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class A07_MultiLangController {
	// 컨테이너에 선언한 지역 언어선택 객체 호출
		@Autowired(required=false)
		private SessionLocaleResolver localeResolver;
		// 화면호출
		// http://localhost:4444/multiLang
		@GetMapping("multiLang")
		public String multiLang(@RequestParam(value="lang", defaultValue = "ko")
								String lang,
								HttpServletRequest request,
								HttpServletResponse response
								) {
			System.out.println("선택한 언어:"+lang);
			// 화면에 지역에 따른 언어선택을 전송 처리..
			Locale locale = new Locale(lang);
			localeResolver.setLocale(request, response, locale);
			
			return "a01_main\\a83_login";
		}
}

package com.web.orbitERP.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.orbitERP.service.A02_HRService;
import com.web.orbitERP.service.MailSenderService;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.MailSender;



@Controller
public class A06_MailSenderController {
	@Autowired(required = false)
	private MailSenderService service;
	
	@Autowired(required = false)
	private A02_HRService hservice;
	
	@ModelAttribute("empListModel")
	public List<Employee> getEmpListModel(){
		return hservice.getEmpListModel();
	}
	
//	http://localhost:4444/mailSend
	@RequestMapping("mailSend")
	public String mailSend(MailSender mailVo, Model d) {
		if(mailVo.getTitle()!=null) {
			d.addAttribute("msg", service.sendMail(mailVo));
		}
		return "a02_humanResource\\a10_sendEmail";
	}
	
	@RequestMapping("mailToPasswordFrm")
	public String mailToPasswordFrm() {
	    return "a01_main\\z01_forgot-password";
	}
	
	@RequestMapping("mailToPassword")
	public ResponseEntity<String> sendMailtoPassword(@RequestParam("empno") String empno, Model d) {
	    return ResponseEntity.ok(service.sendMailtoPassword(empno));
	   
	}
	
	
	

}

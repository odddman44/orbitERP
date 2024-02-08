package com.web.orbitERP.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.web.orbitERP.vo.MailSender;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;






@Service
public class MailSenderService {
	// container에서 메일을 발송하는 객체 로딩..
	@Autowired(required = false)
	private JavaMailSender sender;
	
	// 메일발송 메서드
	public String sendMail(MailSender email) {
		String msg="";
		// 1. 메일 발송 데이터 전송을 위한 객체 생성.
		MimeMessage mmsg = sender.createMimeMessage();
		// 2. 해당 객체로 화면단에 입력된 내용 할당
		try {
		//	1) 제목	
			mmsg.setSubject(email.getTitle());
		//  2) 수신자
			mmsg.setRecipient(RecipientType.TO, 
					new InternetAddress(email.getReceiver()));
		//  3) 내용
			mmsg.setText(email.getContent());

		//  4) 발송처리..	
			sender.send(mmsg);
			msg = "메일발송 성공";
		
		} catch (MessagingException e) {
			System.out.println("메시지 전송 에러 발송:"+e.getMessage());
			msg = "메일 발송 에러 발생:"+e.getMessage();
		} catch(Exception e) {
			System.out.println("기타 에러 :"+e.getMessage());
			msg = "기타 에러 발생:"+e.getMessage();			
		}
		return msg;
	}
	
}

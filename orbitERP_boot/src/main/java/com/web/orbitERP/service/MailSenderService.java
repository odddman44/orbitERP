package com.web.orbitERP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A02_HRDao;
import com.web.orbitERP.vo.Employee;
import com.web.orbitERP.vo.Erpmem;
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
	@Autowired(required = false)
	private A02_HRDao hdao;

	// 메일발송 메서드
	public String sendMail(MailSender email) {
		String msg = "";
		// 1. 메일 발송 데이터 전송을 위한 객체 생성.
		MimeMessage mmsg = sender.createMimeMessage();
		// 2. 해당 객체로 화면단에 입력된 내용 할당
		try {
			// 1) 제목
			mmsg.setSubject(email.getTitle());
			// 2) 수신자
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(email.getReceiver()));
			// 3) 내용
			mmsg.setText(email.getContent());

			// 4) 발송처리..
			sender.send(mmsg);
			msg = "메일발송 성공";

		} catch (MessagingException e) {
			System.out.println("메시지 전송 에러 발송:" + e.getMessage());
			msg = "메일 발송 에러 발생:" + e.getMessage();
		} catch (Exception e) {
			System.out.println("기타 에러 :" + e.getMessage());
			msg = "기타 에러 발생:" + e.getMessage();
		}
		return msg;
	}

	// 메일을 입력받는다.

	// 메일발송 메서드
	public String sendMailtoPassword(String empno) {
		String msg = "";
		String result = "";
		// 비밀번호 지정
		String pwd = new String(makeRandomPass());
		// 사원정보 가져오기
		Employee emp = hdao.empDetail(empno);
		// 1. 메일 발송 데이터 전송을 위한 객체 생성.
		MimeMessage mmsg = sender.createMimeMessage();
		
		msg = "사원번호 "+emp.getEmpno()+" "+ emp.getEname()+"님의 임시 비밀번호는 \n [" +pwd +"]입니다. \n 비밀번호 변경은 임시 비밀번호로 로그인 후 마이페이지에서 변경 가능합니다.";
		// 비밀번호 변경
		Erpmem erpmem = new Erpmem(empno, pwd);
		hdao.updateErpmem(erpmem);
		try {
			// 제목
			mmsg.setSubject("사원번호 "+emp.getEmpno()+"님 [Orbit ERP] 임시비밀번호 발송 전달 메일");
			// 수신자
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(emp.getEmail()));
			// 내용
			mmsg.setText(msg);
			
			// 발송
			sender.send(mmsg);
			
			result="등록된 이메일 "+emp.getEmail()+"로 임시 비밀번호 전달 완료했습니다.";
			
			
		} catch (MessagingException e) {
			result = "메일 발송 에러 발생" + e.getMessage();
		}catch (Exception e) {
			result = "기타 에러 발생: "+e.getMessage();
		}
		

		return result;

	}
	
	// 임시 비밀번호 생성 함수
	
	static byte [] makeRandomPass() { // 배열의 크기를 매개변수로 전달해 대소문자 아스키코드값을 가지고 있는 byte 배열을 만드는 함수

		byte [] rByte = new byte[10]; // 대소문자의 아스키코드를 저장할 byte 배열

		for(int i=0;i<rByte.length;i++) { // rByte의 크기만큼 반복문을 돈다.

		int r = (int)(Math.random()*2); //대문자로 할지 소문자로 할지 정하기

		if(r==0) { // r이 0이면 대문자 생성

		rByte[i] = (byte)(Math.random()*26+65);

		}else { //r이 1이면 소문자 

		rByte[i] = (byte)(Math.random()*26+97);

		}

		}

		return rByte; // 만든 배열을 리턴한다.

		}
	
	
}
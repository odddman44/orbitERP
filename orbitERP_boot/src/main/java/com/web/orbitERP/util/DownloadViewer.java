package com.web.orbitERP.util;

import java.io.File;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

// 컨테이너에 등록하지 않더라도 자동등록 처리
@Component("downloadViewer")
public class DownloadViewer extends AbstractView {
	// 다운로드 할 경로 설정(공통)
	// @Value("${file.upload}")
	private String path = "C:/a01_springbt/workspace2/orbitERP/orbitERP_boot/src/main/resources/static/z02_bulletinUploads/";
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, 
			HttpServletRequest req, HttpServletResponse res)
			throws Exception {
		// 1. 파일명 가져오기(controller에서 모델명으로 전달)
		String fileName = (String)model.get("downloadFile");
		// 2. File객체 만들기(경로와 파일명)
		File file = new File(path+fileName);
		// 3. client에 이 파일을 전달해줄 response객체 속성 선언.
		// 웹 프로그램은 html코드를 ==> client 전달(response)
		// 	1) 파일 전송용 contentType설정
		res.setContentType("application/download;charset=utf-8");
		//	2) 파일 길이 설정
		res.setContentLengthLong(file.length());
		//	3) 파일명이 한글인 경우를 대비해서 한글 encoding 처리
		//		공백부분이 +로 나와서 이것을 ""으로 다시 변경 처리
		fileName=URLEncoder.encode(fileName, "utf-8").replaceAll("\\+"," ");
		
		//	4) 파일전송을 위한 response객체의 Header속성 설정
		//		파일명지정(Content-Disposition),
		res.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\"");
		//	attachment;filename="aaa.txt"로 처리하기 위하여 설정
		//		binary데이터처리(Content-Transfer_Encoding)
		res.setHeader("Content-Transfer-Encoding", "binary");
		//	5) 파일을 Stream으로 보내기 위하여
		//		FileInputStream에 탑재
		//	File ==> FileInputStream ==> response의 OutStream으로 전달
		//	최종적으로 브라우저에 전달
		FileInputStream fis = new FileInputStream(file);
		OutputStream out = res.getOutputStream();
		//	6) FileInputStream(파일지정)을 OutputStream(전송)으로 복사
		FileCopyUtils.copy(fis, out);
		// 	7) response의 buffer를 flush해서 전송완료
		out.flush();
		//	8) outstream 자원해제/fileinputstream 자원해제
		out.close();
		fis.close();
		
		
	}

}

package com.web.orbitERP.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.web.orbitERP.service.A01_MainService;
import com.web.orbitERP.service.A05_BulletinService;
import com.web.orbitERP.vo.Bulletin;
import com.web.orbitERP.vo.BulletinSch;
import com.web.orbitERP.vo.Erpmem;

import jakarta.servlet.http.HttpSession;

@Controller

public class A05_BulletinController {

	@Autowired(required = false)
	   private A05_BulletinService service;
	   // 리스트 출력
	      // http://localhost:4444/bulList
	      // http://211.63.89.67:4444/orbitERP/bulList
		@RequestMapping("bulList")
	      public String bulList(@ModelAttribute("sch") BulletinSch sch, Model d) {
	         d.addAttribute("bulList", service.bulList(sch));
	         return "a05_Bulletin\\a01_bulletin";
	      }
		
		@RequestMapping(value = "bulletinList", produces = MediaType.TEXT_HTML_VALUE)
		@ResponseBody
		public String bulletinList(BulletinSch search) {
		    List<Bulletin> bulletinList = service.bulList(search);
		    StringBuilder html = new StringBuilder();	  
		    for (Bulletin bul : bulletinList) {
		        html.append("<tr ondblclick=\"goDetail(").append(bul.getNo()).append(")\">");	       
		       
		        html.append("<td>").append(bul.getTitle()).append("</td>");
		        html.append("<td>").append(new SimpleDateFormat("yyyy-MM-dd").format(bul.getRegdte())).append("</td>");
		        html.append("<td>").append(bul.getReadcnt()).append("</td>");
		        html.append("</tr>");
		    }	  
		    return html.toString();
		}
	      
	      // 상세화면 조회
	      @RequestMapping("bulletinDetail")
	      public String getBulletin(@RequestParam("no") int no, Model d) {
	         d.addAttribute("bulletin", service.getDetailBulletin(no));
	         return "a05_Bulletin\\a02_bulletinDetail";
	      }
	      // 게시물 등록
	      @RequestMapping("insertBulletinFrm")
	      public String insertBulletinFrm() {
	         return "a05_Bulletin\\a03_bulletinInsert";
	      }
	      @RequestMapping("insertBulletin")
	      public String insertBul(Bulletin ins, Model d) {
	         d.addAttribute("msg", service.insertBulletin(ins));
	         return "a05_Bulletin\\a03_bulletinInsert";
	      }
	      
	      // 게시물 수정
	      @PostMapping("updateBulletin")
	      public String updateBoard(Bulletin upt, Model d) {
	         d.addAttribute("proc","upt");
	         d.addAttribute("msg", service.updateBulletin(upt));
	         d.addAttribute("board", service.getBulletin(upt.getNo()));
	         return "a05_Bulletin\\a02_bulletinDetail";
	      }
	      
	      // 게시물 삭제
	      @GetMapping("deleteBulletin")
	      public String deleteBulletin(@RequestParam("no") int no, Model d) {
	         d.addAttribute("proc", "del");
	         d.addAttribute("msg", service.deleteBulletin(no));
	         return "a05_Bulletin\\a02_bulletinDetail";
	      }
	      
	      // 파일 업로드
	      @Value("${file.upload3}")
	      private String path;
	      
	      @GetMapping("fileupload01")
	      public String fileupload01Frm() {
	         return "a05_Bulletin\\z01_bulFileUpload";
	      }
	      
	      @PostMapping("fileupload01")
	         public String fileupload01(@RequestParam("report") MultipartFile[] GECK, Model d) {
	            if (GECK != null && GECK.length > 0) {
	               try {
	                  for (MultipartFile mf : GECK) {
	                     String fname = mf.getOriginalFilename();
	                     if (fname != null && !fname.equals("")) {
	                        mf.transferTo(new File(path + fname));
	                        d.addAttribute("msg", "파일등록 성공");
	                     }else {
	                        d.addAttribute("msg", "파일등록 실패");
	                     }
	                  }
	               } catch (IllegalStateException e) {
	                  d.addAttribute("msg", "파일등록 실패");
	               } catch (IOException e) {
	                  d.addAttribute("msg", "파일등록 실패");
	               }
	            } else {
	               d.addAttribute("msg", "파일등록 실패");
	            }
	         return "a05_Bulletin\\z01_bulFileUpload";
	      }

	   // 업로드 파일 다운로드
	  	@RequestMapping("download")
	  	public String download(@RequestParam("fname") String fname, Model d) {
	  		d.addAttribute("downloadFile", fname);
	  		return "downloadViewer";
	  	}
	      
	      // 권한에 따른 등록,수정,삭제 기능 부여
	      @Autowired(required=false)
	      private A01_MainService lg;
	      
	      @RequestMapping("login")
	      public String login(@ModelAttribute("emem") Erpmem mem, HttpSession session) {
	         Erpmem emem = lg.login(mem);
	         if(emem!=null) {
	            session.setAttribute("emem", emem);
	         }
	         return "a01_main\\a83_login";
	      }
}

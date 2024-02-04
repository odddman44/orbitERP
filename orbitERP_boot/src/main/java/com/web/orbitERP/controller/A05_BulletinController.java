package com.web.orbitERP.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	// http://localhost:4444/bulList.do
			// http://211.63.89.67:4444/orbitERP/bulList.do
			@RequestMapping("bulList.do")
			public String bulList(@ModelAttribute("sch") BulletinSch sch, Model d) {
				d.addAttribute("bulList", service.bulList(sch));
				return "a05_Bulletin\\a01_bulletin";
			}
			// 상세화면 조회
			@RequestMapping("bulletinDetail.do")
			public String getBulletin(@RequestParam("no") int no, Model d) {
				d.addAttribute("bulletin", service.getDetailBulletin(no));
				return "a05_Bulletin\\a02_bulletinDetail";
			}
			// 게시물 등록
			@RequestMapping("insertBulletin.do")
			public String insertBul(Bulletin ins, Model d) {
				d.addAttribute("msg", service.insertBulletin(ins));
				return "a05_Bulletin\\a03_bulletinInsert";
			}
			@RequestMapping("insertBulletinFrm.do")
			public String insertBulletinFrm(Bulletin d) {
				return "a05_Bulletin\\a03_bulletinInsert";
			}
			// 게시물 수정
			@PostMapping("updateBulletin.do")
			public String updateBoard(Bulletin upt, Model d) {
				d.addAttribute("proc","upt");
				d.addAttribute("msg", service.updateBulletin(upt));
				d.addAttribute("board", service.getBulletin(upt.getNo()));
				return "a05_Bulletin\\a02_bulletinDetail";
			}
			
			// 게시물 삭제
			@GetMapping("deleteBulletin.do")
			public String deleteBulletin(@RequestParam("no") int no, Model d) {
				d.addAttribute("proc", "del");
				d.addAttribute("msg", service.deleteBulletin(no));
				return "a05_Bulletin\\a02_bulletinDetail";
			}
			
			@Autowired(required=false)
			private A01_MainService lg;
			
			@RequestMapping("login.do")
			public String login(Erpmem mem, HttpSession session) {
				Erpmem emem = lg.login(mem);
				if(emem!=null) {
					session.setAttribute("emem", emem);
				}
				return "a01_main\\a83_login";
			}
}

package com.web.orbitERP.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.web.orbitERP.dao.A01_MainDao;
import com.web.orbitERP.vo.Erpmem;

@Service
public class A01_MainService {
	@Autowired(required = false)
	private A01_MainDao dao;
	
	public Erpmem login(Erpmem sch) {
		Erpmem emem = dao.login(sch);
        if (emem == null) {
            emem = new Erpmem();
        }
        return emem;
	}
}

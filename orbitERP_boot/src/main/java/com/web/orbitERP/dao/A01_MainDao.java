package com.web.orbitERP.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.orbitERP.vo.Erpmem;


// orbitERP.a03_dao.A01_MainDao
@Mapper
public interface A01_MainDao {
	@Select("SELECT m.*, e.ENAME \r\n"
			+ "FROM ERPMEM m \r\n"
			+ "JOIN EMPLOYEE e ON m.EMPNO = e.EMPNO\r\n"
			+ "WHERE e.EMPNO = #{empno}\r\n"
			+ "AND m.PWD = #{pwd}")
	Erpmem login(Erpmem sch);
	
}

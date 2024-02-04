package com.web.orbitERP.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.web.orbitERP.vo.Erpmem;


// orbitERP.a03_dao.A01_MainDao
@Mapper
public interface A01_MainDao {
	@Select("SELECT * FROM ERPMEM e \r\n"
			+ "WHERE empno=#{empno} AND pwd=#{pwd}")
	Erpmem login(Erpmem sch);
}

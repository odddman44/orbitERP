package com.web.orbitERP.dao;

import java.util.List;


import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.web.orbitERP.vo.ChRoomInfo;



@Mapper
public interface A08_ChatDao {
	@Insert("MERGE INTO chroominfo target\r\n"
			+ "USING (SELECT #{chroom} AS chRoom, #{id} AS id from dual) source\r\n"
			+ "ON (target.chRoom = source.chRoom AND target.id = source.id)\r\n"
			+ "WHEN NOT MATCHED THEN\r\n"
			+ "    INSERT (chRoom, id) VALUES (source.chRoom, source.id)")
	int insChatRoom(ChRoomInfo ins);
	
	@Delete("Delete from chroominfo where  id=#{id}  and chroom = #{chroom}	")
	int delChatRoom(ChRoomInfo del);

	@Delete("Delete from chroominfo where  id=#{id}")
	int delChatId(@Param("id") String id);	
	
	@Select("	SELECT DISTINCT chroom\r\n"
			+ "	FROM CHROOMINFO")
	List<String> getChRooms();
	
	@Select("	SELECT id\r\n"
			+ "	FROM CHROOMINFO\r\n"
			+ "	WHERE chroom = (\r\n"
			+ "		SELECT chroom\r\n"
			+ "		FROM CHROOMINFO\r\n"
			+ "		WHERE id=#{id} \r\n"
			+ "	)")
	List<String> getChRoomIds(@Param("id") String id);
	
	@Select("	SELECT id\r\n"
			+ "	FROM CHROOMINFO\r\n"
			+ "	WHERE  chroom = #{chroom} \r\n")
	List<String> getIdsByRoom(@Param("chroom") String chroom);
		

	
	
	
}

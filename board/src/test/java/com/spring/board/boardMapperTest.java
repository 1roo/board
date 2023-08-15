package com.spring.board;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.board.board.mapper.IBoardMapper;
import com.spring.board.command.BoardVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/config/db-config.xml"})
public class boardMapperTest {
	
	@Autowired
	private IBoardMapper mapper;
	
	@Test
	@DisplayName("글등록")
	void registTest() {
		for(int i=1; i< 500; i++) {
			BoardVO vo = new BoardVO();
			vo.setWriter("작성자<br>" + i);
			vo.setTitle("글제목&nbsp;&nbsp;" + i);
			vo.setPassword("aaa1111!");
			vo.setContent("글내용입니다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + i);
			mapper.regist(vo);
		}
	}

}

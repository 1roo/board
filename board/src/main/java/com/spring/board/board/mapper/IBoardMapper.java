package com.spring.board.board.mapper;

import java.util.List;


import com.spring.board.command.BoardVO;
import com.spring.board.util.PageVO;

public interface IBoardMapper {
	
	void regist(BoardVO vo);
	
	List<BoardVO> getList(PageVO vo);
	
	int getTotal(PageVO vo);
	
	BoardVO getContent(int bno);
	
	void update(BoardVO vo);
	
	void delete(int bno);
	
	void updateAndInsert(BoardVO vo);
	void replyUpdate(BoardVO vo);
	void replyInsert(BoardVO vo);


}


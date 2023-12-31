package com.spring.board.board.service;

import java.util.List;

import com.spring.board.command.BoardVO;
import com.spring.board.util.PageVO;

public interface IBoardService {
	
		//글 등록
		void regist(BoardVO vo);
		
		//글 목록
		List<BoardVO> getList(PageVO vo);
		
		//전체 글 개수
		int getTotal(PageVO vo);
		
		BoardVO getContent(int bno);
		
		//글 수정
		void update(BoardVO vo);
		
		//글 삭제
		void delete(BoardVO vo);

		void replyRegist(BoardVO vo);
		

}
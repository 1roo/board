package com.spring.board.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.board.command.BoardVO;
import com.spring.board.util.PageVO;

public interface IBoardMapper {
	
	void regist(BoardVO vo);
	
	List<BoardVO> getList(PageVO vo);
	
	int getTotal(PageVO vo);
	
	BoardVO getContent(int bno);
	
	void update(BoardVO vo);
	
	void delete(int bno);

	void replyInsert(BoardVO vo);
	
	Integer countByGroupNoAndDepth(@Param("groupNo") int groupNo, @Param("depth") int depth);
	
	Integer getMaxStep();
	
	void updateReplyGroupStep(@Param("step")int step);

}


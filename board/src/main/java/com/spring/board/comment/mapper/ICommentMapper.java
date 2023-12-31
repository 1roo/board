package com.spring.board.comment.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.board.command.CommentVO;

public interface ICommentMapper {

	void commentRegist(CommentVO vo);
	List<CommentVO> getList(Map<String, Object> data); //목록 요청
	int getTotal(int bno);
	CommentVO getContent(int cno);
	void update(CommentVO vo);
	void delete(int cno);
	String checkPassword(@Param("cno") int cno, @Param("commentPw") String commentPw);
	
}

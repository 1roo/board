package com.spring.board.comment.service;

import java.util.List;

import com.spring.board.command.CommentVO;

public interface ICommentService {

	void commentRegist(CommentVO vo);
	List<CommentVO> getList(int bno, int pageNum);
	int getTotal(int bno);
	String update(int cno, String newComment);
	String delete(int cno, String inputPw);
	String checkPassword(int cno, String inputPw);
}	

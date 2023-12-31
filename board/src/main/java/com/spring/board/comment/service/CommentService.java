package com.spring.board.comment.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.command.CommentVO;
import com.spring.board.comment.mapper.ICommentMapper;
import com.spring.board.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommentService implements ICommentService {
	
	@Autowired
	private ICommentMapper mapper;

	@Override
	public void commentRegist(CommentVO vo) {
		mapper.commentRegist(vo);
	}

	@Override
	public List<CommentVO> getList(int bno, int pageNum) {
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCpp(5);
		
		Map<String, Object> data = new HashMap<>();
		data.put("pageVO", vo);
		data.put("bno", bno);
		return mapper.getList(data);
	}

	@Override
	public int getTotal(int bno) {
		return mapper.getTotal(bno);
	}
	
	@Override
	public String checkPassword(int cno, String commentPw) {
		 return mapper.checkPassword(cno, commentPw);
    }
	
	@Override
	public String update(int cno, String newComment) {
        CommentVO vo = mapper.getContent(cno);
        if (vo != null) {
            vo.setComment(newComment);
            mapper.update(vo);
            return "modSuccess";
        } else {
            return "modFail";
        }
    }
	
	
	@Override
	public String delete(int cno, String inputPw) {
		log.info("inputPw : " + inputPw);
		CommentVO vo = mapper.getContent(cno);
		if(vo.getCommentPw().equals(inputPw)) {
			mapper.delete(cno);
			return "delSuccess";
		} else return "delFail";
	}


	

}

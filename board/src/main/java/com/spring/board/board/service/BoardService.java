package com.spring.board.board.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.board.mapper.IBoardMapper;
import com.spring.board.command.BoardVO;
import com.spring.board.util.PageVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service @Slf4j @AllArgsConstructor
public class BoardService implements IBoardService {
	
	@Autowired
	private IBoardMapper mapper;
	
	
	@Override
	public void regist(BoardVO vo) {
		try {
			mapper.regist(vo);
		} catch (Exception e) {
			log.error("게시물 등록 중 오류 발생: {}", e.getMessage());
			throw new RuntimeException("게시물 등록 실패");
		}
	}
	
	@Override
	public List<BoardVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}
	
	@Override
	public BoardVO getContent(int bno) {
		return mapper.getContent(bno);
	}

	@Override
	public void update(BoardVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(BoardVO vo) {
		if(vo.getBabyCount() == 0) {
			mapper.delete(vo.getBno());			
		} else {
			mapper.notice(vo);
		}
	}
	
	@Override
	public void replyRegist(BoardVO vo) {
		
		int getStep = mapper.findStep(vo);
		
		if(getStep != 0) {
			mapper.updateReply(vo.getGroupNo(), getStep);
		} else {
			getStep = mapper.getMaxStep(vo.getGroupNo());
		}
		
		BoardVO reply = new BoardVO();
		reply.setTitle(vo.getTitle());
		reply.setWriter(vo.getWriter());
		reply.setPassword(vo.getPassword());
		reply.setContent(vo.getContent());
		reply.setGroupNo(vo.getGroupNo());
		reply.setDepth(vo.getDepth()+1);
		reply.setStep(getStep);
		reply.setCommentCount(vo.getCommentCount());
		
		mapper.replyInsert(reply);
		mapper.countBabies(vo.getBno());
	}






}
package com.spring.board.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.board.mapper.IBoardMapper;
import com.spring.board.command.BoardVO;
import com.spring.board.util.PageVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@AllArgsConstructor
@Transactional
public class BoardService implements IBoardService {

	@Autowired
	private IBoardMapper mapper;

	@Override
	public void regist(BoardVO vo) {
		try {
			vo.setStep(mapper.getMaxStep() + 1);
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
	public void delete(int bno) {
		mapper.delete(bno);
	}

	@Override
	public void replyRegist(int bno, BoardVO vo) {

		BoardVO board = mapper.getContent(bno);
		if (board == null) {
			log.error("잘못된 접근입니다.");
		}
		
		// 부모 글과 같은 depth, groupNo의 개수 조회
		Integer boardGroupCnt = mapper.countByGroupNoAndDepth(board.getGroupNo(), board.getDepth());
		
		Integer depth = null;
		Integer step = null;
		
		// 부모 글이 1개라면 step은 MAX + 1
		if (boardGroupCnt == 1) {
			step = mapper.getMaxStep() + 1;
			depth = board.getDepth() + 1;
		// 부모 글이 여러개일 때
		} else if (boardGroupCnt > 1) {
			// 부모 글이 1개 이상일 때는 답글이 이미 존재하는지 여부 확인
			Integer replyGroupCnt = mapper.countByGroupNoAndDepth(board.getGroupNo(), board.getDepth() + 1);
			
			// 존재하지 않으면 step은 부모 + 1을 하면서 정렬을 위해 해당하는 글들만 step + 1
			if (replyGroupCnt == 0) {
				depth = board.getDepth() + 1;
				step = board.getStep() + 1;
				mapper.updateReplyGroupStep(step);
			} else if(replyGroupCnt > 0) {
				depth = board.getDepth() + 1;
				step = board.getStep() + replyGroupCnt;
				mapper.updateReplyGroupStep(board.getStep() + 1);
			}
		}
		
		log.info("depth : " + depth);
		log.info("step : " + step);

		// 답글 저장
		BoardVO insertBoardReply = BoardVO.builder()
			    .title(vo.getTitle())
			    .writer(vo.getWriter())
			    .password(vo.getPassword())
			    .content(vo.getContent())
			    .groupNo(board.getGroupNo())
			    .step(step)
			    .depth(depth)
			    .build();
		mapper.replyInsert(insertBoardReply);
	}

}

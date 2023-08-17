package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.board.command.CommentVO;
import com.spring.board.comment.service.ICommentService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/comment")
@Slf4j
public class CommentController {

	@Autowired
	private ICommentService service;
	
	//댓글 등록
	@PostMapping("/regist")
	public String commentRegist(@RequestBody CommentVO vo) {
		service.commentRegist(vo);
		return "regSuccess";
	}
		
	//목록 요청(페이징 포함)
	@GetMapping("/getList/{bno}/{pageNum}")
	public Map<String, Object> getList(@PathVariable int bno, @PathVariable int pageNum) {
		List<CommentVO> list = service.getList(bno, pageNum);
		int total = service.getTotal(bno);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}

	
	@GetMapping("/{cno}")
    public String checkPassword(@PathVariable int cno, @RequestParam String commentPw) {
        String checkResult = service.checkPassword(cno, commentPw);
        log.info(checkResult);
        if ("pwSuccess".equals(checkResult)) {
            return "pwSuccess";
        } else {
            return "pwFail";
        } 
    }

	
	@PutMapping("/{cno}")
    public String update(@PathVariable int cno, @RequestBody CommentVO vo) {
        String updateResult = service.update(cno, vo.getComment());
        return updateResult;
    }
		

	//댓글 삭제
	@DeleteMapping("/{cno}")
	public String delete(@PathVariable int cno, @RequestBody CommentVO vo) {
		return service.delete(cno, vo.getCommentPw());
	}
	
	
}

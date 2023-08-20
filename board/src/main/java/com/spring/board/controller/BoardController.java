package com.spring.board.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.board.board.service.IBoardService;
import com.spring.board.command.BoardVO;
import com.spring.board.util.PageCreator;
import com.spring.board.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping
@Slf4j
public class BoardController {

	@Autowired
	private IBoardService service;

	
	@GetMapping("/")
	public String boardList(PageVO vo, Model model) {
		int totalBoardCount = service.getTotal(vo);
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		model.addAttribute("list", service.getList(vo));
		model.addAttribute("pc", pc);
		model.addAttribute("totalBoardCount", service.getTotal(vo));
		model.addAttribute("startNumber", totalBoardCount - (pc.getPageVO().getPageNum() - 1) * pc.getPageVO().getCpp());
		return "/list";
	}
	
	@GetMapping("/regist")
	public String regist() {
		return "/regist";
	}
	
	@PostMapping("/regist")
	public String regist(BoardVO vo) {		
	    service.regist(vo);
	    return "redirect:/";
	}
	
	@GetMapping("/replyRegist/{bno}")
	public String replyRegist(@PathVariable int bno, Model model) {
		BoardVO parentArticle = service.getContent(bno);
		model.addAttribute("parentArticle", parentArticle);
		return "/reply";
	}
	
	@PostMapping("/replyRegist/{bno}")
	public String replyRegist(@PathVariable int bno, BoardVO vo) {
	    BoardVO parentArticle = service.getContent(bno);
	    
	    vo.setGroupNo(parentArticle.getGroupNo()); // 부모 글의 groupNo를 새 답글에 설정
	    
	    // 부모 글의 depth를 기반으로 답글의 depth 설정
	    vo.setDepth(parentArticle.getDepth() + 1);
	    
	    // step을 설정하기 위해 같은 group의 같은 depth의 step값 계산
	    int maxStep = service.getMaxStep(parentArticle.getGroupNo(), vo.getDepth());
	    vo.setStep(maxStep + 1);
	    
	    log.info("parentArticle의 groupNo: " + vo.getGroupNo());
	    log.info("새 답글의 step: " + vo.getStep());
	    log.info("새 답글의 depth: " + vo.getDepth());
	    
	    service.replyRegist(vo);
	    
	    return "redirect:/";
	}


	@GetMapping("/content/{bno}")
	public String getContent(@PathVariable int bno, @ModelAttribute("p") PageVO vo
			, Model model) {
		model.addAttribute("article", service.getContent(bno));
		return "/detail";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute("article") BoardVO vo) {
		return "update";
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo) {
	    service.update(vo);
	    return "redirect:/content/" + vo.getBno();
	}
	
	@PostMapping("/delete")
	public String delete(int bno) {
		service.delete(bno);
		return "redirect:/";
	}

}
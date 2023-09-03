package com.spring.board.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageCreator {

    private PageVO pageVO;
    private int totalBoardCount, endPage, beginPage;
    private boolean firstPage, lastPage;
    private boolean prev, next;
    private int totalPage;
    private final int buttonNum = 10;

    public PageCreator(PageVO pageVO, int totalBoardCount) {
        this.pageVO = pageVO;
        this.totalBoardCount = totalBoardCount;
        calcDataOfPage();
    }

    private void calcDataOfPage() {
        // 현재 페이지 번호에 따라 끝 페이지 계산
        endPage = (int) ((Math.ceil(pageVO.getPageNum() / (double) buttonNum) * buttonNum));

        // 시작 페이지 계산
        beginPage = endPage - buttonNum + 1;
        
        firstPage = (beginPage == 1) ? false : true;
        lastPage = (endPage * pageVO.getCpp() >= totalBoardCount ? false : true);
        totalPage = (int) Math.ceil(totalBoardCount / (double) pageVO.getCpp());

        // 이전 버튼 표시 여부
        prev = (beginPage == 1) ? false : true;

        // 다음 버튼 표시 여부
        next = totalBoardCount > endPage * pageVO.getCpp();

        // 다음 버튼이 표시되지 않는 경우 끝 페이지 재조정
        if (!next) {
            endPage = (int) (Math.ceil(totalBoardCount / (double) pageVO.getCpp()));
        }

    }
}
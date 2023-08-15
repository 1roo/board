<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ include file="./include/header.jsp"%>
<!-- 이전, 다음 버튼에 사용할 화살표 아이콘을 추가하기 위해 font-awesome CSS를 사용 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

	<!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">	
	
<section>
	<div class="container list-container">
		<a href="${pageContext.request.contextPath}"><p class="title">게시판 목록</p></a>
		<div class="top-container">
	        <form class="search-form" action="<c:url value='/list' />">
	            <div class="search-wrap">
	                <select name="condition" class="search-select form-select">
	                    <option value="title" ${pc.pageVO.condition == 'title' ? 'selected' : ''}>
	                        제목
	                    </option>
						<option value="content" ${pc.pageVO.condition == 'content' ? 'selected' : ''}>
	                        내용
	                    </option>
						<option value="writer" ${pc.pageVO.condition == 'writer' ? 'selected' : ''}>
	                        작성자
	                    </option>
						<option value="titleContent" ${pc.pageVO.condition == 'titleContent' ? 'selected' : ''}>
	                        제목+내용
	                    </option>
	                </select>
	                <input class="search-input form-control" type="text" name="searchWord" value="${pc.pageVO.searchWord}">
	                <button class="btn search-btn btn-outline-primary" type="submit">검색</button>
	            </div>
	        </form>
			<div class="text-center">
	            <button type="button" class="btn regist-btn btn-outline-primary" id="registBtn"
	                onclick="location.href='${pageContext.request.contextPath}/regist'">글쓰기</button>
	        </div>
        </div>
        <table class="table table-hover">
			<thead class="table-primary">
				<tr>
					<th>번호</th>
					<th class="board-title w-50">제목</th>
					<th>작성자</th>
					<th>게시일</th>
				</tr>
			</thead>
			<tbody>
			
				<c:forEach var="vo" items="${list}"  varStatus="loop">
					<tr>
						<td id=listBoardNo>
							${totalBoardCount - (pc.pageVO.getPageStart() + loop.index)}
						</td>
						<td id="title" class="titles">
                            <a href="${pageContext.request.contextPath}/content/${vo.bno}?pageNum=${fn:escapeXml(pc.pageVO.pageNum)}&cpp=${fn:escapeXml(pc.pageVO.cpp)}&searchWord=${fn:escapeXml(pc.pageVO.searchWord)}&condition=${fn:escapeXml(pc.pageVO.condition)}" class="preserve-whitespace">${fn:escapeXml(vo.title)}</a>
                        </td>
                        <td id="writer">
                            ${fn:escapeXml(vo.writer)}
                        </td>                        
						<td>
                            <fmt:parseDate
								value="${vo.updateDate == null ? vo.createDate : vo.updateDate}"
								pattern="yyyy-MM-dd" var="parsedDateTime" type="both" />
                            <fmt:formatDate value="${parsedDateTime}" pattern="yyyy-MM-dd" />
                        </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

        <!--페이지 네이션을 가져옴-->
		<form action="${pageContext.request.contextPath}" name="pageForm">
            <!-- 페이지네이션 출력 부분 -->
            <nav>
                <ul class="pagination">
                    <div class="flex-paging">
						<!-- 제일 처음 버튼 -->
					    <li class="page-item">
					        <a href="#" class="page-link first" data-pagenum="${pc.firstPage}">
					            <i class="fas fa-angle-double-left" data-pagenum="${pc.firstPage}"></i>
					        </a>
					    </li>
                        <!-- 이전 버튼 -->
                        <c:if test="${pc.prev}">
                            <li class="page-item">
                                <a href="#" class="page-link prev" data-pagenum="${pc.beginPage - 1}">
                                    <i class="fas fa-chevron-left" data-pagenum="${pc.beginPage - 1}"></i>
                                </a>
                            </li>
                        </c:if>
                
                        <!-- 페이지 버튼들 -->
                        <c:forEach var="num" begin="${pc.beginPage}" end="${pc.endPage}">
                            <li class="page-item ${pc.pageVO.pageNum == num ? 'active' : ''}">
                                <a href="#" class="page-link" data-pagenum="${num}">${num}</a>
                            </li>
                        </c:forEach>
                
                        <!-- 다음 버튼 -->
                        <c:if test="${pc.next}">
                            <li class="page-item">
                                <a href="#" class="page-link next" data-pagenum="${pc.endPage + 1}">
                                    <i class="fas fa-chevron-right" data-pagenum="${pc.endPage + 1}"></i>
                                </a>
                            </li>
                        </c:if>
                
                        <!-- 제일 끝 버튼 -->
                        <li class="page-item">
					        <a href="#" class="page-link last" data-pagenum="${pc.lastPage}">
					           <i class="fas fa-angle-double-right" data-pagenum="${pc.lastPage}"></i>
					        </a>
					    </li>
                    </div>
                </ul>                
            </nav>
			
            <input type="hidden" name="pageNum" value="${pc.pageVO.pageNum}">
            <input type="hidden" name="cpp" value="${pc.pageVO.cpp}"> 
            <input type="hidden" name="searchWord" value="${pc.pageVO.searchWord}"> 
            <input type="hidden" name="condition" value="${pc.pageVO.condition}">

        </form>
    </div>
</section>

<script>
	window.onload = function() {
	    document.querySelector('.pagination').addEventListener('click', e => {
	        e.preventDefault();
	        if (!e.target.matches('a') && !e.target.matches('i')) {
	            return;
	        }
	        const value = e.target.dataset.pagenum;
	        const firstPage = e.target.dataset.firstpage;
	        const lastPage = e.target.dataset.lastpage;
	
	        if (value === 'first') {
	            document.pageForm.pageNum.value = firstPage;
	        } else if (value === 'last') {
	            document.pageForm.pageNum.value = lastPage;
	        } else {
	            document.pageForm.pageNum.value = value;
	        }
	
	        document.pageForm.submit();
	    });
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<%@ include file="./include/footer.jsp"%>
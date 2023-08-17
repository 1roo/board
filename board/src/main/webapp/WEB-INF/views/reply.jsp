<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="./include/header.jsp" %>


<section>
  <div class="container regist-container">
    <p class="title">게시판 등록</p>
    <div class="form-box">
      <form action="${pageContext.request.contextPath}/replyRegist" method="post" name="replyRegistForm">
      
        
        <div class="writerPw">
          <div class="writer-box">
	        <div class="input-line writer-input">
        	  <label for="writer">작성자</label>
	          <input class="form-control" type="text" id="writer" name="writer" maxlength="10" placeholder='최대 10자'>
	        </div>
           </div>
          <div class="pw-box">
	        <div class="input-line pw-input">
              <label for="password">비밀번호</label>
              <input class="form-control" type="password" id="password" name="password" maxlength="15" placeholder="영문, 숫자, 특수문자(@$!%*?&) 포함 8자~15자">
            </div>
          </div>
        </div>
        <div class="input-line title-input">
          <label for="title">글제목</label>
          <input class="form-control" type="text" id="title" name="title" maxlength="50" placeholder="50자 이내">
          <span id="titleCheck" class="title-fail"></span>
        </div>
        <div class="input-line content-input">
          <label for="content">내용</label>
          <textarea class="form-control content" id="content" rows="10" name="content" maxlength="500" oninput=checkContentLength()></textarea>
          <span id="contentLength">0/500</span>
        </div>
        <div class="titlefoot">
          <button class="btn regist-btn btn-outline-primary" id="registBtn" type="button">등록</button>
          <button type="button" class="btn list-btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/'">목록</button>
        </div>
      </form>
    </div>   
  </div>
</section>


<script>
</script>

<%@ include file="./include/footer.jsp" %>
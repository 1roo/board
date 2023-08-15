<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="./include/header.jsp" %>


<section>
    <div class="container update-container">
        <p class="title">게시판 수정</p>
        <div class="form-box">
            <form action="${pageContext.request.contextPath}/modify" method="post" name="updateForm">
            	<input type="hidden" name="bno" value="${article.bno}" />
                <div class="namePw">
                    <div class="input-line writer-input">
                        <label>작성자</label>
                        <input class="form-control preserve-whitespace" id="writer" name="writer" maxlength="10" value="${fn:escapeXml(article.writer)}">
                    </div>
                </div>
                <div class="input-line title-input">
                    <label>글제목</label>
                    <input class="form-control preserve-whitespace" id="title" name="title" value="${fn:escapeXml(article.title)}"  maxlength="50" placeholder="50자 이내">
                </div>

                <div class="input-line content-input">
                    <label>내용</label>
                	<textarea class="form-control content" id="content" rows="10" name="content" maxlength="500" oninput=checkContentLength()>${fn:escapeXml(article.content)}</textarea>
          			<span id="contentLength">0/500</span>
                </div>
                <div class="titlefoot">
                    <button type="button" id="updateBtn" class="btn update-btn btn-outline-primary">수정</button>
                    <button type="button" class="btn cancle-btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/'">취소</button>
                </div>
            </form>
        </div>
    </div>
</section>


<script>


  const $updateForm = document.updateForm;
  const $writer = document.getElementById('writer');
  const $title = document.getElementById('title');
  const $content = document.getElementById('content');

  //작성자 검증
  $writer.addEventListener("keyup", function(event) {
    const inputValue = $writer.value;
    // HTML 태그를 제거하고 공백을 포함한 총 10자리까지만 유지
    const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
    if (sanitizedValue.length >= 10 && !event.ctrlKey && !event.Backspace ) {
      alert("작성자는 10자까지만 입력 가능합니다.");
    }
  });

  //제목 검증
  $title.addEventListener("keyup", function(event) {
    const inputValue = $title.value;
    // HTML 태그를 제거하고 공백을 포함한 총 50자리까지만 유지
    const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
    if (sanitizedValue.length >= 50 && !event.ctrlKey && !event.Backspace ) {
      alert("제목은 50자까지만 입력 가능합니다.");
    }
  });

  //내용검증
  $content.addEventListener("input", function(event) {
    const maxLength = 500;
    const inputValue = $content.value;
    // HTML 태그를 제거하고 정제된 값의 길이를 체크
    const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
    if (sanitizedValue.length >= 500) {
      event.preventDefault();
      $content.value = sanitizedValue.substring(0, 500);
      alert("글자 수는 500자까지만 입력 가능합니다.");
    }
  });
  $content.addEventListener('keyup', function(event) {
	  if ($content.value.length >= 500 && !event.ctrlKey && !event.Backspace) {
		  event.preventDefault();
	    $content.value = $content.value.slice(0, 500);
	    checkContentLength();
	    alert('내용은 최대 500자입니다.');
	    
	  } else {
	    checkContentLength();
	  }
	});

 //내용 글자수
  function checkContentLength() {
    const contentInput = document.getElementById('content');
	const contentInputValue = contentInput.value;
    const contentValue = $content.value; 
    const contentLength = contentValue.length;
 	document.getElementById('contentLength').textContent = $content.value.length + '/500';
  } 
 
  window.onload = function() {
    checkContentLength();
 }
 
	
  //수정 버튼 이벤트 처리
  document.getElementById('updateBtn').onclick = function() {
	  if ($updateForm.title.value.trim() == '') {
		  alert('제목은 필수 항목입니다.');
		  $updateForm.title.focus();
		  return;
	  } else if ($updateForm.content.value.trim() == '') {
		  alert('내용은 필수 항목입니다.');
		  $updateForm.content.focus();
		  return;
	  }  else if ($updateForm.writer.value.trim() == '') {
		  alert('작성자는 필수 항목입니다.');
		  $updateForm.writer.focus();
		  return;
	  } else {
		  $updateForm.submit();
	  }
	}

</script>


<%@ include file="./include/footer.jsp" %>
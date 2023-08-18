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
          <button class="btn regist-btn btn-outline-primary" id="replyRegistBtn" type="button">등록</button>
          <button type="button" class="btn list-btn btn-outline-primary" onclick="location.href='${pageContext.request.contextPath}/'">목록</button>
        </div>
      </form>
    </div>   
  </div>
</section>


<script>
const $writer = document.getElementById('writer');
const $password = document.getElementById('password');
const $title = document.getElementById('title');
const $content = document.getElementById('content');

//작성자 검증
$writer.addEventListener("input", function() {
const inputValue = $writer.value;
// HTML 태그를 제거하고 공백을 포함한 총 10자리까지만 유지
const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
if (sanitizedValue.length >= 10) {
  $writer.value = sanitizedValue.substring(0, 10);
  $writer.removeEventListener("input", inputHandler);
  alert("작성자는 최대 10자까지만 입력 가능합니다.");
}
});

function inputHandler() {
const inputValue = $writer.value;
// HTML 태그를 제거하고 공백을 포함한 총 10자리까지만 유지
const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
if (sanitizedValue.length >= 10) {
  $writer.value = sanitizedValue.substring(0, 10);
  $writer.removeEventListener("input", inputHandler);
  alert("작성자는 최대 10자까지만 입력 가능합니다.");
}
}

$writer.addEventListener("input", inputHandler);


//비밀번호 검증
let isValidPassword = true;
let isPasswordAlertShown = false;

$password.addEventListener('input', function(event) {
const passwordRegex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,15}$/;
isValidPassword = passwordRegex.test($password.value);
isPasswordAlertShown = false;
});

$password.addEventListener('blur', function(event) {
if (!isValidPassword && !isPasswordAlertShown) {
  alert('비밀번호는 8자 이상 15자 이하의 영문, 숫자, 특수문자를 모두 포함해야 합니다.');
  $password.value = '';
  $password.focus();
  isPasswordAlertShown = true;
}
});


//제목 검증
$title.addEventListener("input", function() {
const inputValue = $title.value;
// HTML 태그를 제거하고 공백을 포함한 총 10자리까지만 유지
const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
if (sanitizedValue.length >= 50) {
  $title.value = sanitizedValue.substring(0, 50);
  $title.removeEventListener("input", inputHandler);
    alert("작성자는 50자까지만 입력 가능합니다.");
}
});

function inputHandler() {
const inputValue = $title.value;
// HTML 태그를 제거하고 공백을 포함한 총 50자리까지만 유지
const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
if (sanitizedValue.length >= 50) {
  $title.value = sanitizedValue.substring(0, 50);
  $title.removeEventListener("input", inputHandler);
    alert("제목은 50자까지만 입력 가능합니다.");
}
}

$title.addEventListener("input", inputHandler);


//내용 검증  
$content.addEventListener("input", function(event) {
const inputValue = $content.value;
// HTML 태그를 제거하고 정제된 값의 길이를 체크
const sanitizedValue = inputValue.replace(/<\/?[^>]+(>|$)/g, "");
if (sanitizedValue.length >= 500) {
  $content.value = sanitizedValue.substring(0, 500);
  event.preventDefault();
  alert("내용은 최대 500자입니다.");
}
});

$content.addEventListener('keyup', function(event) {
if ($content.value.length >= 500 && !event.ctrlKey) {
  $content.value = $content.value.slice(0, 500);
  checkContentLength();
  alert('내용은 최대 500자입니다.');
} else {
  checkContentLength();
}
}); 

//내용 글자수
function checkContentLength() {
const contentLength = $content.value.length;
document.getElementById('contentLength').textContent = $content.value.length + '/500';
} 


document.getElementById('replyRegistBtn').addEventListener('click', function() {
	const form = document.forms['replyRegistForm'];
    if (form.writer.value.trim() == '') {
      alert('작성자를 입력하세요.');
      form.writer.focus();
    } else if(form.password.value.trim() =='') {
      alert('비밀번호를 입력하세요.');
   form.password.focus();
    } else if (form.title.value.trim() ==''){
      alert('제목을 입력하세요.');
      form.title.focus();
    } else if (form.content.value.trim() ==''){
      alert('글 내용을 입력하세요.');
      form.content.focus();
    } else {
      form.submit();
    }
});

</script>

<%@ include file="./include/footer.jsp" %>
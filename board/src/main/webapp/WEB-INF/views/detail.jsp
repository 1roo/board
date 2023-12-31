<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<section>
	<div class="container detail-container">
		<p class="title">상세보기</p>
		<div class="form-box">
			<form action="${pageContext.request.contextPath}/update"
				method="post" name="updateForm">
				<div class="createDate">
					<label>게시일</label>
					<c:if test="${article.updateDate == null}">
						<p class="form-control">
							<fmt:parseDate value="${article.createDate}" pattern="yyyy-MM-dd"
								var="parsedDateTime" type="both" />
							<fmt:formatDate value="${parsedDateTime}" pattern="yyyy-MM-dd" />
						</p>
					</c:if>
					<c:if test="${article.updateDate != null}">
						<p class="form-control">
							<fmt:parseDate value="${article.updateDate}" pattern="yyyy-MM-dd"
								var="parsedDateTime" type="both" />
							<fmt:formatDate value="${parsedDateTime}" pattern="yyyy-MM-dd" />
						</p>
					</c:if>
				</div>
				<div class="bno">
					<input type="hidden" class="form-control" name="bno"
						value="${article.bno}" readonly>
					<input type="hidden" class="form-control" name="groupNo"
						value="${article.groupNo}" readonly>
					<input type="hidden" class="form-control" name="step"
						value="${article.step}" readonly>
					<input type="hidden" class="form-control" name="depth"
						value="${article.depth}" readonly>
				</div>
				<div class="input-line writer-input">
					<label>작성자</label> <input class="form-control" name="writer"
						value="${fn:escapeXml(article.writer)}" readonly>
				</div>
				<div class="input-line title-input">
					<label>제목</label> <input class="form-control" name="title"
						value="${fn:escapeXml(article.title)}" readonly>
				</div>
				<div class="input-line content-input maltiline-label">
					<label>내용</label>
					<textarea class="form-control content preserve-whitespace"
						name="content" id="content">${fn:escapeXml(article.content)}</textarea>
				</div>
				<div class="btns">
					<button type="button" class="btn update-btn btn-outline-primary"
						onclick="toUpdate()">수정</button>
					<button type="button" id="delBtn"
						class="btn delete-btn btn-outline-primary" onclick="toDelete()">삭제</button>
					<button type="button" class="btn list-btn btn-outline-primary"
						onclick="location.href='${pageContext.request.contextPath}/'">목록</button>
						<button type="button" class="btn replyBtn btn-outline-primary"
						onclick="location.href='${pageContext.request.contextPath}/replyRegist/${bno}'">답글달기</button>
				</div>
				<p style="display: none" id="realPw">${fn:escapeXml(article.password)}</p>
			
				<input type="hidden" name="bno" value="${article.bno}">
				<input type="hidden" name="groupNo" value="${article.groupNo}">
				<input type="hidden" name="step" value="${article.step}">
				<input type="hidden" name="depth" value="${article.depth}">
				<input type="hidden" name="commentCount" value="${article.commentCount}">
				<input type="hidden" name="babyCount" value="${article.babyCount}">
			</form>
		</div>
	</div>

</section>

<!-- 댓글 -->
<section style="margin-top: 80px;">
	<div class="comment-container container">
		<div class="row">

			<form class="comment-wrap">
				<div class="comment-content">
					<div class="comment-input">
						<input type="text" class="commentWriter form-control"
							id="commentWriter" placeholder="닉네임(10자 이내)"> <input
							type="password" class="commentPw form-control" id="commentPw"
							placeholder="비밀번호(영문,숫자,특수문자 8~15자리)">
					</div>
					<div class="content-regist">
						<textarea class="form-control" rows="3" id="comment"
							placeholder="300자 이내"></textarea>
						<button type="button" id="commentRegist"
							class="btn btn-outline-primary">등록</button>
					</div>
				</div>
			</form>

			<div id="commentList">
				<!-- 자바스크립트 단에서 반복문 이용해서 반복 표현 -->
			</div>
			<button type="button" class="form-control" id="moreList"
				style="display: none;">더보기</button>

		</div>
	</div>
</section>


<div class="modal fade" id="commentModal" role="dialog">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">댓글 수정</h4>
				<button type="button" id="closeModal" class="btn btn-default pull-right"
					data-dismiss="modal" onclick="hideModal()">닫기</button>
			</div>
			<div class="modal-body">
				<div class="comment-content">
					<textarea class="form-control" rows="4" id="modalComment"
						placeholder="내용입력"></textarea>
					<div class="comment-group">
						<div class="comment-input">
							<input type="hidden" id="modalCno">
						</div>
						<button class="right btn btn-info" id="modalModBtn">수정하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<script>

	//모달닫기
	function hideModal() {
		$('#commentModal').modal('hide');
	}

	const $content = document.getElementById('content');
	$content.style.height = 'auto';
	$content.style.height = ($content.scrollHeight) + 'px';
			
	const $comment = document.getElementById('comment');
	$comment.addEventListener('input', () => {
	    $comment.style.height = 'auto'; // 높이 초기화
	    $comment.style.height = ($comment.scrollHeight) + 'px'; // 스크롤 높이만큼 설정
	});

	const $commentWriter = document.getElementById('commentWriter');
	const $commentPw = document.getElementById('commentPw');
		
	
	
	const $updateForm = document.updateForm;
	const realPw = document.getElementById('realPw').textContent;
		
	function toUpdate() {
		while (true) {
			let passwordInput = prompt('비밀번호를 입력하세요.');
			        
			if (passwordInput === null) {
			    break;
			} else if (passwordInput.trim() === '') {
			    alert('비밀번호를 입력하세요.');
			} else if (passwordInput === realPw) {
			    $updateForm.submit();
			    break;
			} else {
			    alert('비밀번호가 틀립니다.');
			}
		}
	}
			
	function toDelete() {
	    while (true) {
	        let passwordInput = prompt('비밀번호를 입력하세요.');
			        
	        if (passwordInput === null) {
	            break;
	        } else if (passwordInput.trim() === '') {
	            alert('비밀번호를 입력하세요.');
	        } else if (passwordInput === realPw) {
	            if (confirm('정말 삭제하시겠습니까?')) {
	                $updateForm.setAttribute('action', '${pageContext.request.contextPath}/delete');
	                $updateForm.submit();
	                break;
	            }
		        else {
			        alert('비밀번호가 틀립니다.');
			    }
			}
		}
	}
		 
		 
	window.onload = function () {
				 
		document.getElementById('commentRegist').onclick = () => {
			console.log("댓글 등록 이벤트");
			 
			const bno = '${article.bno}'
			let comment = document.getElementById('comment').value;
			let commentWriter = document.getElementById('commentWriter').value;
			let commentPw = document.getElementById('commentPw').value;
			 
			if(commentWriter === '') {
				alert('닉네임을 입력하세요');
				document.getElementById('commentWriter').focus();
				return;
			} else if(commentPw === '') {
				alert('비밀번호를 입력하세요');
				document.getElementById('commentPw').focus;
				return;
			} else if(comment === '') {
				alsert('내용을 입력하세요');
				document.getElementById('comment').focus;
				return;
			}
			 
		//요청에 관견된 정보 객체
		const reqObj = {
			method: 'post',
			headers: {
				'Content-Type': 'application/json'
				},
			body: JSON.stringify({
				'bno': bno,
				'comment': comment,
				'commentWriter': commentWriter,
				'commentPw': commentPw
			})
		};
			 
		fetch('${pageContext.request.contextPath}/comment/regist/', reqObj)
			.then(res => res.text())
			.then(data => {
				console.log('통신성공: ', data);
				document.getElementById('comment').value = '';
				document.getElementById('commentWriter').value = '';
				document.getElementById('commentPw').value = '';
				//등록완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현
				getList(1, true);
			});			 
			 
		}
		 
		//더보기 버튼 처리
		document.getElementById('moreList').onclick = () => {
			getList(++page, false);
		}
		 
		let page = 1;
		let strAdd = '';
		const $commentList = document.getElementById('commentList');
		 
		getList(1, true);
		 
		function getList(pageNum, reset) {
			strAdd = '';
			const bno = '${article.bno}';
			 
			fetch('${pageContext.request.contextPath}/comment/getList/' + bno + '/' + pageNum)
			 	.then(res => res.json())
			 	.then(data => {
			 		console.log(data);
			 		
			 		let total = data.total; //총 댓글수
			 		let commentList = data.list;
			 		
			 		if(reset) {
			 			while ($commentList.firstChild) {
			 				$commentList.firstChild.remove();
			 			}
			 			page = 1;
			 		}
			 		
			 		if(commentList.length <= 0) return;
			 	
			 		console.log('현재페이지: ' + page);
			 		if(total <= page * 5) {
			 			document.getElementById('moreList').style.display = 'none';
                    } else {
                        document.getElementById('moreList').style.display = 'block';
                    }
			 		
			 	
                    for(let i=0; i<commentList.length; i++) {
                    	strAdd += `
                            <div class="comment-wrap">
                            <div class="comment-content">
                                <div class="comment-group">
                                    <strong class="left commentWriter">` + commentList[i].commentWriter + ` </strong>
                                    <div class="commentBtns">
	                                    <small class="left">` + (commentList[i].updateDate != null ? parseTime(commentList[i].updateDate) + ' (수정됨)' : parseTime(commentList[i].createDate)) + `</small>
	                                    <a href='` + commentList[i].cno + `' class='commentModify'>수정</a>
	                                    <a href='` + commentList[i].cno + `' class='commentDelete'>삭제</a>       
                                	</div>
                                    </div>
                                <p id="pComment" class="comment clearfix">` + commentList[i].comment + `</p>
                            </div>
                        	</div>`;
                    }
			 		
                    if (!reset) {
                        document.getElementById('commentList').insertAdjacentHTML('beforeend', strAdd);
                    
                    } else {
                        document.getElementById('commentList').insertAdjacentHTML('afterbegin', strAdd);
                    }

			 	});
		}

		let isPasswordInputActive = false; // 비밀번호 입력 상태를 나타내는 변수

		//댓글 삭제 및 수정
		document.getElementById('commentList').addEventListener('click', async e => {
    		e.preventDefault();

    		if (e.target.matches('.commentDelete')) {
    			console.log('Delete 버튼이 클릭되었습니다.');
	    		const cno = e.target.getAttribute('href');
	
	    		async function getPassword() {
	        		while (true) {
	            		const inputPw = prompt('비밀번호를 입력하세요');
	            		if (inputPw === null) {
	                		break; 
	            		} else if (inputPw.trim() === '') {
	                		alert('비밀번호를 입력하세요');
	                		continue;
	            		} else {
	                		const data = { 'commentPw': inputPw };
	
	                		try {
	                    		const response = await fetch('${pageContext.request.contextPath}/comment/' + cno, {
	                        		method: 'DELETE',
	                       			headers: {
	                            		'Content-Type': 'application/json'
	                        		},
	                        		body: JSON.stringify(data)
	                    		});
	
	                    		const result = await response.text();
	                    		if (result === "delSuccess") {
	                        		if (confirm('정말 삭제하시겠습니까?')) {
	                            		getList(1, true);
	                        		}
	                        		break; 
	                    		} else if (result === "delFail") {
	                        		alert('비밀번호가 틀렸습니다');
	                    		}
	                		} catch (error) {
	                    		console.error('Error:', error);
	                    		break; 
	                		}
	            		}
	        		}
	    		}
	    		await getPassword();
    		} else if (e.target.matches('.commentModify')) {
    		    console.log('Modify 버튼이 클릭되었습니다.');
    		    const cno = e.target.getAttribute('href');
    		    const content = e.target.parentNode.parentNode.nextElementSibling.textContent;
    		    
    		    async function getPassword() {
    		        while (true) {
    		        const inputPw = prompt('비밀번호를 입력하세요');
    		    	isPasswordInputActive = true; // prompt 창이 열려있음을 표시
    		            if (inputPw === null) {
    		                break;
    		            } else if (inputPw.trim() === '') {
    		            	alert('비밀번호를 입력하세요');
	                		continue;
    		            } else {
    		                try {
    		                	console.log('inputPw: ', inputPw);
    		                	console.log('cno: ', cno);
    		                	const checkResponse = await fetch('${pageContext.request.contextPath}/comment/' + cno + '?commentPw=' + inputPw, {
    		                	    method: "GET",
    		                	    headers: {
    		                	        'Content-Type': 'application/json'
    		                	    }
    		                	});

    		                    const checkResult = await checkResponse.text();
    		                    if (checkResult === 'pwSuccess') {
    		                    	$('#commentModal').modal('show');
     		                        // 모달 내부의 요소들 가져오기
     		                        document.getElementById('modalCno').value = cno;
     		                        document.getElementById('modalComment').value = content;
     		                       if (isPasswordInputActive) {
     		          	            return; // 이미 다른 prompt 창이 열려있으면 함수 중단
     		          	        	}
    		                    } else if (checkResult === 'pwFail') {
    		                        alert('비밀번호가 틀렸습니다');
    		                    }
    		                } catch (error) {
    		                    console.error('Error:', error);
    		                    return;
    		                }
    		            }
    		        }
    		        isPasswordInputActive = false; // prompt 창이 닫혔음을 표시
    		    }
    		    await getPassword();
    		}

		});

		// 모달 수정 버튼 클릭 이벤트 리스너
		document.getElementById('modalModBtn').addEventListener('click', async () => {
		    const updatedComment = document.getElementById('modalComment').value;
		    const cno = document.getElementById('modalCno').value;
		    
		    // 수정한 댓글 내용을 서버로 전송
		    const updatedData = {
		        'comment': updatedComment
		    };
		    
		    try {
		        const updateResponse = await fetch('${pageContext.request.contextPath}/comment/' + cno, {
		            method: 'put',
		            headers: {
		                'Content-Type': 'application/json'
		            },
		            body: JSON.stringify(updatedData)
		        });

		        const updateResult = await updateResponse.text();
		        if (updateResult === "modSuccess") {
		            $('#commentModal').modal('hide'); // 모달 닫기
		            getList(1, true); // 댓글 목록 갱신
		        } else {
		            alert('댓글 수정에 실패했습니다.');
		        }
		    } catch (updateError) {
		        console.error('Error:', updateError);
		    }
		});

		//댓글 날짜 변환 함수
	    function parseTime(regDateTime) {
	    	let year, month, day, hour, minute, second;

	        if(regDateTime.length === 5) {
	            [year, month, day, hour, minute] = regDateTime;
	            second = 0;
	        } else {
	            [year, month, day, hour, minute, second] = regDateTime;
	        }

	        console.log(`${year}, ${month}, ${day}, ${hour}, ${minute}, ${second}`);

	        //원하는 날짜로 객체를 생성
	        const regTime = new Date(year, month-1, day, hour, minute, second);
	        console.log(regTime);
	        const date = new Date();
	        console.log(date);
	        const gap = date.getTime() - regTime.getTime();

	        let time;
	        if(gap < 60 * 60 * 24 * 1000) {
	            if(gap < 60 * 60 * 1000) {
	                time = '방금 전';
	            } else {
	                time = parseInt(gap / (1000 * 60 * 60)) + '시간 전';
	            }
	        } else if(gap < 60 * 60 * 24 * 30 * 1000) {
	            time = parseInt(gap / (1000 * 60 * 60 * 24)) + '일 전';
	        } else {
	            time = `${regTime.getFullYear()}년 ${regTime.getMonth()-1}월 ${regTime.getDate()}일`;
	        }
            return time;
        }

	} //window.onload
</script>


<%@ include file="./include/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>

<div class="container">
	<h1 class="text-center text-primary">상세보기</h1>
	<br><br>
	<hr>
		<div class="row mb-3">
			<div class="col-lg-1">글번호</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="bnoo" name="bnoo" readonly></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-lg-1">제목</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="title" name="title" readonly></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-lg-1">글쓴이</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="writer" name="writer" readonly></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-lg-1">내용</div>
			<div class="col-lg-11"><textarea class="form-control" id="content" name="content" readonly></textarea></div>
		</div>
		<hr>
		<div class="row">
			<div class="col-lg-1">작성일</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="regdate" name="regdate" readonly></div>
		</div>	
		<hr>
		<a href="/board/list"><input type="button" class="btn btn-primary float-right mr-5" id="writeCompl" value="목록"></a>
		<input type="button" class="btn btn-warning float-right mr-1" id="modify" value="수정">
		<input type="button" class="btn btn-danger float-right mr-1" id="delete" value="삭제">
	</div>
	
<script type="text/javascript">

	$(document).ready(function(){
		
		function timeCalc(i) {
			var timestamp = i;
			var date = new Date(timestamp);
			var formattedTime = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
			
			return formattedTime
			}
		
		
		$.urlParam = function(name){
		    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
		    if (results==null){
		       return null;
		    }
		    else{
		       return results[1] || 0;
		    }
		}
		
		var bno = $.urlParam("bno");
		
		
		
		console.log(bno);
		
		$.ajax({
			type : 'get',
			url : '/test/get/' + bno,
			header : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "get"
			},
			contentType : "application/json",
			dataType : 'json',
			data : 
				 encodeURI(bno)
			,
			success : function(board){
				
				
				
				console.log(timeCalc(board.regdate));
				
				
				
				
				$("#title").val(board.title);
				$("#bnoo").val(board.bno);
				$("#writer").val(board.writer);
				$("#content").val(board.content);
				$("#regdate").val(timeCalc(board.regdate));
			}
		});
		
		$("#modify").on("click", function(){
			
			location.href="/board/modifyForm?bno=" + bno;
		});
		
		$("#delete").on("click", function(){
			
			$.ajax({
				
				type : 'delete',
				url : '/test/delete/' + bno ,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				contentType : "application/json",
				data : JSON.stringify({
					
					bno : bno
				}),
				dataType : 'text',
				success : function(result) {
					
					if(result == 'SUCCESS'){
						
						alert("게시글 삭제가 완료되었습니다.");
						location.href = "/board/list"
					}
				}
				
				
			});
		});
	});

</script>

</body>
</html>














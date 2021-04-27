<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="container">
	<h1 class="text-center text-primary">글쓰기</h1>
	<br><br>
	<hr>
		<div class="row mb-3">
			<div class="col-lg-1">제목</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="title" name="title"></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-lg-1">글쓴이</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="writer" name="writer"></div>
		</div>
		<hr>
		<div class="row mb-3">
			<div class="col-lg-1">내용</div>
			<div class="col-lg-11"><textarea class="form-control" id="content" name="content"></textarea></div>
		</div>
		<hr>
		<div class="row">
			<div class="col-lg-1">작성일</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="regdate" name="regdate" readonly></div>
		</div>	
		<hr>
		<input type="button" class="btn btn-primary float-right mr-5" id="writeCompl" value="작성완료">
	</div>
	
	
	
	<script type="text/javascript">
	$(document).ready(function(){
  	  
  	  var date = new Date();
  	    var year = date.getFullYear();
  	    var month = ("0" + (1 + date.getMonth())).slice(-2);
  	    var day = ("0" + date.getDate()).slice(-2);
  	    
	      $("#regdate").val(year + "-" + month + "-" + day);
    });
	
	$("#writeCompl").on("click", function(){
		
		var title = $("#title").val();
		var writer = $("#writer").val();
		var content = $("#content").val();
		$.ajax({
			
			type : 'post',
			url : '/test/register' ,
			header : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Ovveride" : "POST"
			},
			contentType : "application/json",
			data : JSON.stringify({
				title : title,
				writer : writer,
				content : content
			}),
			dataType : 'text',
			success : function(result) {
				console.log("result : " + result);
				if(result == 'SUCCESS'){
					alert("작성이 완료되었습니다.");
					location.href="/board/list";
				}
			}
				
			
			
		});
	});
	
	
	</script>
	
</body>
</html>
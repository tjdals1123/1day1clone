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
	<h1 class="text-center text-primary">수정하기</h1>
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
		<div class="row">
			<div class="col-lg-1">수정일자</div>
			<div class="col-lg-11"><input type="text" class="form-control" id="updatedate" name="updatedate" readonly></div>
		</div>	
		<hr>
		<input type="button" class="btn btn-primary float-right mr-5" id="modifyCompl" value="완료">
		
	</div>

<script type="text/javascript">

		$(document).ready(function(){
			
			$.urlParam = function(name){
			    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
			    if (results==null){
			       return null;
			    }
			    else{
			       return results[1] || 0;
			    }
			}
		
		function timeCalc(i) {
			var timestamp = i;
			var date = new Date(timestamp);
			var formattedTime = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
			
			return formattedTime
			}
		
		var bno = $.urlParam("bno")
		
		console.log(bno);
		
		$("#modifyCompl").on("click", function(){
			
			var title = $("#title").val();
			var writer = $("#writer").val();
			var content = $("#content").val();
		
			$.ajax({
				
				type : 'put',
				url : '/test/modify/' + bno,
				header : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				contentType : "application/json",
				data : JSON.stringify({
					bno : bno,
					title : title,
					writer : writer,
					content : content
					
				}),
				dataType : "text",
				success : function(result) {
					console.log("result : " + result);
					if(result == 'SUCCESS'){
						alert("작성이 완료되었습니다.");
						location.href="/board/get?bno="+ bno;
					}
				}
				
			});
		});
	});

</script>

</body>
</html>
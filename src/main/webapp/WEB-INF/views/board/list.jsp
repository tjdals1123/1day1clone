<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
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
		<table class="table table-hover">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성일</th>
					<th>수정날짜</th>
				</tr>
			</thead>
			<tbody id="boardList">
				
			</tbody>
		</table>
		
		<a href="/board/register"><button class="btn btn-primary float-right">글쓰기</button></a>
		
		<div class="text-center">
			<ul id="pagination" class="pagination">
			
			</ul>
			<ul id="takesearch" class="pagination">
			
			</ul>
		</div>
		
		<div class="btn-group" data-toggle="buttons">
			
			<label class="btn btn-default">
				<input type="radio" name="searchTypeT" id="option1" value="t"> 제목
			</label>
			<label class="btn btn-default">
				<input type="radio" name="searchTypeT" id="option2" value="c"> 내용
			</label>
			<label class="btn btn-default">
				<input type="radio" name="searchTypeT" id="option3" value="w"> 작성자
			</label>
		</div>
			<input type="text" name="keyword" id="keywordInput" placeholder="Search">
			
			<button class="btn btn-primary btn-lg" id="searchBtn">검색</button>

	
		
		
<!-- 		  <ul class="pagination"> -->
<!--     <li class="page-item disabled"><a class="page-link" href="#">«</a></li> -->
<!--     <li class="page-item active"><a class="page-link" href="#">1</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">4</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">5</a></li> -->
<!--     <li class="page-item"><a class="page-link" href="#">»</a></li> -->
<!--    </ul> -->
		
	</div>
	
	
<script type="text/javascript">

		$(document).ready(function(){
		
			
		function getBoardList(page){
			$.getJSON("/test/list/" + page, function(data){
				
				var str = "";
				
				$(data.list).each(
						function(){
							
							var timestamp = this.regdate;
	    	    			var date = new Date(timestamp);
	    	    			var formattedTime = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
							
							str += 		"<tr><td>" + this.bno + "</td><td><a href='/board/get?bno="+ this.bno + "'>" + this.title + "</a></td><td>" 
								+ this.writer + "</td><td>" + formattedTime + "</td><td>" 
								+ this.updatedate + "</td>" + "</tr>";
							
						});
				
					$("#boardList").html(str);
					
					printPaging(data.pageMaker);
					
			});
			
		}
			
		getBoardList(1);
			function printPaging(pageMaker) {
	    		var str = "";
	    		
	    		if(pageMaker.prev) {
	    			str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
	    		}
	    		
	    		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
	    			var active = pageMaker.cri.page == i ? 'active' : '';
	    			str += "<li class='page-item" + active + "'><a class='page-link' href='" + i +"'>" + i + "</a></li>";
	    		}
	    		if(pageMaker.next) {
	    			str += "<li class='page-item'><a class='page-link' href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
	    		}
	    		
	    		$('#pagination').html(str);
	    		
	    	}
			
			$("#pagination").on("click", "li a", function(e) {
				e.preventDefault();
				
				formPage = $(this).attr("href");
				
 				getBoardList(formPage);
			});
			
			$("#searchBtn").on("click", 
			
			
			function getListSearch(page, searchType, keyword){
				
//  				formPage = $(this).attr("href");
 				
				
				
				
				searchType = $('input[name="searchTypeT"]:checked').val();
				
				
				
				
				keyword = $("#keywordInput").val();
				
				page = 1;
				
				console.log(page);
				
				var str = "";
				
				$.ajax({
					
					type : 'get',
					url : '/test/list/' + page + '/' + searchType + '/' + keyword,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "GET"
					},
					contentType : "application/json",
					data : JSON.stringify(page , searchType, encodeURI(keyword)),
					dataType : 'json',
					success :
						function(result){
						$(result.list).each(
						
						function(){
						var timestamp = this.regdate;
    	    			var date = new Date(timestamp);
    	    			var formattedTime = date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2) + "-" + ("0" + date.getDate()).slice(-2);
						
    	    			str += "<tr><td>" + this.bno + "</td><td><a href='/board/get?bno="+ this.bno + "'>" + this.title + "</a></td><td>" 
						+ this.writer + "</td><td>" + formattedTime + "</td><td>" 
						+ this.updatedate + "</td>" + "</tr>";
    	    			
    	    			$("#boardList").html(str);
					
						getListSearch(1, searchType, keyword);
						
				})
					}
					
				
				    
				});	
				
				
			
			});
			
			
// 			function printPagingTakeSearch(pageMaker, searchType, keyword) {
// 	    		var str = "";
	    		
// 	    		if(pageMaker.prev) {
// 	    			str += "<li><a class='page-link' href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
// 	    		}
	    		
// 	    		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
// 	    			var active = pageMaker.cri.page == i ? 'active' : '';
// 	    			str += "<li class='" + active + "'><a href='" + i + "'>" + i + "</a></li>";
// 	    		}
// 	    		if(pageMaker.next) {
// 	    			str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
// 	    		}
	    		
// 	    		$('#takesearch').html(str);
// 	    	}
			
// 			$("#takesearch").on("click", "li a", function(e) {
// 				e.preventDefault();
				
// 				formPage = $(this).attr("href");
// 				var keyword = $("#keywordInputT").val();
// 				getTakeListSearch(formPage, searchType ,keyword);
// 			});
// 	    	$("#searchBtnT").on("click", function() {
// 	    		keyword = $("#keywordInputT").val();
// 				searchType = $('input[name="searchTypeT"]:checked').val();
// 	    		console.log(searchType);
// 	    		console.log(keyword);
				
			    
// 				 if(keyword == "" || searchType == "undefined") {
// 				    getTakeList(1);
// 					$("#takesearch").html("");
// 				 } else {
// 					console.log("====================");
// 					getTakeListSearch(1, searchType, keyword);
// 					console.log("====================");
					
// 					$("#pagination").html("");
// 				 } 
	    		
// 	    	})
	    	
		});
</script>

<%-- <c:forEach var="board" items="${list}"> --%>
<!-- 				<tr> -->
<%-- 					<td>${baord.bno}</td> --%>
<%-- 					<td>${board.title}</td> --%>
<%-- 					<td>${board.writer}</td> --%>
<%-- 					<td>${board.regdate}</td> --%>
<%-- 					<td>${board.updatedate}</td> --%>
<!-- 				</tr> -->
<%-- 				</c:forEach> --%>

</body>
</html>









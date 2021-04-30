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
<style>
	#modDiv{
		width : 300px;
		height : 100px;
		background-color: green; 
		position : absolute;
		top : 50%;
		left : 50%;
		margin-top : -50px;
		margin-left : -150px;
		padding : 10px;
		z-index : 1000;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<h2>Ajax 테스트</h2>
	
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY TEXT <input type="text" name="replytext" id="newReplyText">
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
		
	</div>
	
	<ul id="replies">
		
	</ul>
	<ul class='pagination'>
	
	</ul>
	
	<div id="modDiv" style="display:none;">
		<div class = "modal-title"></div>
		<div>
			<input type="text" id="replytext">
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">Delete</button>
			<button type="button" id="closeBtn">Close</button>
		</div>
		
	</div>
	
	
	<script type="text/javascript">
		 
	$(document).ready(function(){
		
	
	
	var bno = 229375
		
// 		$.getJSON("/replies/all/" + bno, function(data){
			
// 			console.log(data.length);
// 		});
		
	function getAllList(){
		$.getJSON("/replies/all/" + bno, function(data){
			
			var str = "";
			console.log(data.length);
			
			$(data).each(
				function() {
					
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
						+ this.rno + ":" + this.replytext
						+ "<button>수정/삭제</button></li>";
				});
			$("#replies").html(str);
		});
		}
		getAllList();
	
	
	$("#replyAddBtn").on("click", function(){
		
		var replyer = $("#newReplyWriter").val();
		var replytext = $("#newReplyText").val();
		
		$.ajax({
			
			type : 'post',
			url : '/replies',
			headers : {
				
				"Content-Type" : "application/json",
				"X-HTTP-Mehtod-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			
			success : function(result) {
				if(result == 'SUCCESS'){
					
					alert("등록 되었습니다.");
					
					getAllList();
				}
				
			}
			
		})
		
	});
	
	$("#replies").on("click", ".replyLi button", function(){
		
		
		var reply = $(this).parent();
		
		var rno = reply.attr("data-rno");
		
		var replytext = reply.text();
		
		$(".modal-title").html(rno);
		$("#replytext").val(replytext);
		$("#modDiv").show("slow");
		
	});
	
	$("#replyDelBtn").on("click", function(){
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		$.ajax ({
			
			type : 'delete',
			url : '/replies/' + rno,
			header : {
				
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
				
			},
			dataType : 'text',
			success : function(result) {
				
				console.log("result: " + result);
				if(result == 'SUCCESS') {
					
					alert("삭제 되었습니다.");
					$("#modDiv").hide("slow");
					getAllList();
					
				}
			}
			
		});
	});
	
	$("#replyModBtn").on("click", function(){
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();
		
		
		$.ajax({
			
			type : 'patch',
			url : '/replies/' + rno,
			header : {
				
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PATCH"
				
			},
			contentType : "application/json",
			data : JSON.stringify({replytext : replytext}),
			dataType : 'text',
			success : function(result) {
				
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					
					alert("수정 되었습니다.");
					$("#modDiv").hide("slow");
					getAllList();
					
				}
			}
			
		});
	});
	
	$("#closeBtn").on("click", function(){
		
		$("#modDiv").hide("slow");
	});
	
	function getPageList(page) {
		
		$.getJSON("/replies/" + bno + "/" + page, function(data){
			
			console.log(data.list.length);
			
			var str = "";
			
			$(data.list).each(function(){
				
				str += "<li data-rno='" + this.rno + "' class='replyLi'>"
					+ this. rno + " : " + this.replytext
					+ "<button>MOD</button></li>";
			})
			
			$("#replies").html(str);
			console.log(data.pageMaker);
			printPaging(data.pageMaker);
		});
	}//getPageList
	
	function printPaging(pageMaker){
		
		var str = "";
		
		if(pageMaker.prev) {
			
			str += "<li><a href='" + (pageMaker.startPage -1) + "'> << </a></li>";
		}
		
		for(var i = pageMaker.startPage, len=pageMaker.endPage; i<= len; i++) {
			
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
		}
		
		if(pageMaker.next) {
			
			str += "<li><a href='" + (pageMaker.endpage + 1) + "'> >> </a></li>";
		}
		
		$('.pagination').html(str);
	}// printPaging
	
	$(".pagination").on("click", "li a", function(e){
		
		e.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getPageList(replyPage);
	});
	
	getPageList(1);
	
});//document	
	</script>
	
</body>
</html>

























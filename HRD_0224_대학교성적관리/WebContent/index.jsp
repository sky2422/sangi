<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 성적 관리</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h2>대학교 성적관리 프로그램</h2>
		</div>
		대학교에서 학생정보, 성적정보, 등급정보 데이터베이스를 구축하고 학생관리와 성적관리 및 성적조회를 위한 프로그램을 작성하는
		프로그램이다.<br> <br> 프로그램 작성순서<br><br>
		<ol>
			<li>학생정보 테이블을 작성한다.</li>
			<li>성적정보 테이블을 작성한다.</li>
			<li>등급정보 테이블을 작성한다.</li>
			<li>학생정보 입력 화면 프로그램을 작성한다.</li>
			<li>성적정보 입력 화면 프로그램을 작성한다.</li>
			<li>성적조회 프로그램을 작성한다.</li>
			<li>재수강대상자 프로그램을 작성한다.</li>
		</ol>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
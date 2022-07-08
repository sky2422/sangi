<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h2>학원 수강관리 프로그램</h2>
		</div>
		영남 학원의 수강생 정보, 수강신청 정보 데이터베이스를 구축하고 수강생관리를 위한 프로그램을 작성하는 프로그램이다.
		<br><br>
		프로그램 작성 순서<br><br>
		<ol>
			<li>수강생정보 테이블을 생성한다.</li>
			<li>과목정보 테이블을 생성한다.</li>
			<li>수강정보 테이블을 생성한다.</li>
			<li>수강생정보, 과목정보, 수강정보 테이블에 제시된 문제지의 참조데이터를 추가 생성한다.</li>
			<li>수강생정보 입력 화면 프로그램을 작성한다.</li>
			<li>수강생정보 조회 프로그램을 작성한다.</li>
			<li>수강신청 화면 프로그램을 작성한다.</li>
			<li>수강신청 정보 조회 프로그램을 작성한다.</li>
		</ol>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>
<body>
	<%@ include file = "header.jsp" %> <!-- header.jsp안에 dbcon.jsp(DB 연결) -->
	<section>
		<div>
			<h2>쇼핑몰관리 프로그램</h2>
		</div>
		쇼핑몰에서 회원정보,매출정보,등급정보 데이터베이스를 구축하고 회원관리와 회원조회 및 매출조회를 위한
		프로그램을 저장하는 프로그램이다.<br><br>
		프로그램 작성 순서<br><br>
		<ol>
			<li>회원정보 테이블을 생성한다.</li>
			<li>매출정보 테이블을 생성한다.</li>
			<li>등급정보 테이블을 생성한다.</li>
			<li>회원정보 입력 화면프로그램을 작성한다.</li>
			<li>회원조회/수정 프로그램을 작성한다.</li>
			<li>매출조회 프로그램을 작성한다.</li>	
		</ol>
	</section>	
	<%@ include file = "footer.jsp" %> <!-- DB 연결 해제 -->
</body>
</html>






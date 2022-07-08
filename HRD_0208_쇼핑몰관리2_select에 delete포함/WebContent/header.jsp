<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ★중요 : DB 연결 파일 포함 + 변수 선언-->
<%@ include file="dbcon.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
<!-- ★중요 : style.css 연결 -->
<!-- stylesheet로 모니터 화면에 보여줄 'text/css'로 이루어진  style.css 파일을 이 html파일과 연결하라-->
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>쇼핑몰관리 프로그램</h2>
	</header>
	<nav>
		<a href="insert.jsp">회원등록</a>
		<a href="select.jsp">회원조회/등록</a>
		<a href="select2.jsp">매출조회</a>
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>






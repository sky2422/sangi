<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여관리 프로그램</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>급여관리</h2>
	</header>
	<nav>
		<a href="insert.jsp">사원등록</a>
		<a href="select.jsp">사원목록조회/수정</a>
		<!-- <a href="select2_1.jsp">급여조회(1001:아침출근-저녁퇴근 / 저녁퇴근-아침출근)</a> -->
		<a href="select2_2.jsp">급여조회(1001:아침출근-저녁퇴근 / 저녁퇴근-아침출근)</a>
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>
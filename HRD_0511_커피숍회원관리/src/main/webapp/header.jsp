<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피숍 회원 관리</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>커피숍 회원관리 프로그램</h2>
	</header>
	<nav>
		<a href="insert.jsp">회원등록</a>
		<a href="insert2.jsp">커피등록</a>
		<a href="select.jsp">회원목록조회/수정</a>
		<a href="select2.jsp">커피목록조회</a>
		<a href="select3.jsp">매출현황조회</a>
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>
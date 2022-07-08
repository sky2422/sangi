<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>학원 수강관리 프로그램</h2>
	</header>
	<nav>
		<a href="insert.jsp">수강생등록</a>
		<a href="select.jsp">수강생목록조회/수정</a>
		<a href="insert2.jsp">수강신청</a>
		<a href="select2.jsp">수강조회</a>
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>
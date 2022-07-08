<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스클럽관리</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>헬스클럽관리 프로그램</h2>
	</header>
	<nav>
		<a href="insert.jsp">회원등록</a>
		<a href="select.jsp">회원목록/트레이너신청</a>
		<a href="select2.jsp">트레이너목록</a>
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>
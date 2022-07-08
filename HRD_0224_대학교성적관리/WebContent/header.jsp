<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 성적 관리</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<header>
		<h2>대학교성적관리 프로그램</h2>
	</header>
	<nav>
		<a href="insert.jsp">학생등록</a>
		<a href="insert2.jsp">성적등록</a>
		<!-- 방법-1 -->
		<!-- <a href="select.jsp">성적조회</a> -->
		<!-- 방법-1 -->
		<a href="select_2.jsp">성적조회</a>
		<!-- 방법-1 -->
		<a href="select2.jsp">재수강대상자</a>
		<!-- 방법-2 -->
		<!-- <a href="select2_2.jsp">재수강대상자</a> -->
		<a href="index.jsp">홈으로</a>
	</nav>
</body>
</html>
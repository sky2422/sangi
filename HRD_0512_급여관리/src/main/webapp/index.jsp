<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여관리 프로그램</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h3>급여관리 프로그램</h3>
		</div>
		회사에서 사원 정보, 출퇴근 정보 데이터베이스를 구축하고 급여관리를 위한 프로그램을 작성하는 프로그램이다.<br>
		프로그램 작성 순서<br> <br>
		<ol>
			<li>사원정보 테이블을 생성한다.</li>
			<li>출퇴근정보 테이블을 생성한다.</li>
			<li>사원정보 입력 화면프로그램을 작성한다.</li>
			<li>사원정보 조회/수정 프로그램을 작성한다.</li>
			<li>급여 정보 조회 프로그램을 작성한다.</li>
		</ol>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
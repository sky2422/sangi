<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<footer>
	   <!--[ⓒ입력 방법-1] 한글 ㅇ 입력->[한자] 눌러  찾아 선택-->
	   <!--[ⓒ입력 방법-2] -->
		HRDKOREA Copyright &copy;2019 All reserved.
	</footer>
</body>
</html>
<!-- ★★DB 연결 해제 -->
<%
try{
	if(con != null) con.close();
	if(stmt != null) stmt.close();
	if(ps != null) ps.close();
	if(rs != null) rs.close();
}catch(Exception e){
	e.printStackTrace();
}
%>










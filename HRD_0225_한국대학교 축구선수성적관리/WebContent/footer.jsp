<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<footer> HRDKOREA Copyrightⓒ 2021 All rights reserved. HUMAN
		Rescources Development Service of korea.</footer>
</body>
</html>
<%
try{
	if(con!=null) con.close();
	if(stmt!=null) stmt.close();
	if(ps!=null) ps.close();
	if(rs!=null) rs.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
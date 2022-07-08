<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피숍 회원관리 프로그램</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>커피숍 회원관리 프로그램</h2>
		</div>
		<table border="1" width="900" style="margin: 0 auto;">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>성별</th>
				<th>회원전화</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주도시</th>				
			</tr>
			<%
			sql = "select CUSTNO,CUSTNAME,";
			sql += " decode(GENDER,'M','남자','F','여자') as GENDER,";
			sql += " PHONE,ADDRESS,";
			sql += " to_char(JOINDATE, 'yyyy-mm-dd') as JOINDATE,";
			sql += " decode(GRADE,'A','VIP','B','일반','C','직원') as GRADE,";
			sql += " CITY";
			sql += " from member_tbl";
			sql += " ORDER BY 1 ASC";
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
			%>
				<tr align="center">
					<td><a href="update.jsp?CUSTNO=<%=rs.getString(1) %>"><%=rs.getString(1) %></a></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
					<td><%=rs.getString(6) %></td>
					<td><%=rs.getString(7) %></td>
					<td><%=rs.getString(8) %></td>
				</tr>	
			<%	
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
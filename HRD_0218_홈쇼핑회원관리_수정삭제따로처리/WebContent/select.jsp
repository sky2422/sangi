<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈쇼핑 회원관리</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>회원목록조회/수정</h2>
		</div>
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			
			<%
			sql += "select custno,custname,phone,address,";
			sql += " to_char(joindate,'yyyy-mm-dd') as joindate,";
			sql += " decode(grade,'A','VIP','B','일반','C','직원') as grade,";
			sql += " city";
			sql += " from member_tbl_02";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
			%>
				<tr align="center">
					<td><a href="updateDelete.jsp?custno=<%=rs.getString(1) %>"><%=rs.getString(1) %></a></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
					<td><%=rs.getString(6) %></td>
					<td><%=rs.getString(7) %></td>
				</tr>
			<%	
			}
			%>
			
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








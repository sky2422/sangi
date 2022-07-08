<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관 회원&예매 관리 프로그램</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>회원별 예매정보 조회</h2>
		</div>
		<table border="1" width="700" style="margin:0 auto">
			<tr>
				<th>회원아이디</th>
				<th>회원이름</th>
				<th>영화제목</th>
				<th>시청등급</th>
				<th>예매횟수</th>
			</tr>
			
			<%
			sql += "select me_id, me_name, mo_name, mo_limit, count(me_id)";
			sql += " from MOVIE_1 natural join MOVIE_2 natural join MOVIE_3";
			sql += " group by me_id, me_name, mo_name, mo_limit";
			sql += " order by 2 asc";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
			%>
				<tr align="center">
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
				</tr>
			<%	
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
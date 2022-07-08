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
			<h2>회원매출조회</h2>
		</div>
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>				
			</tr>
			
			<%
			sql += "select custno, custname,";
			sql += " decode(grade,'A','VIP','B','일반','C','직원') as decodegrade, ";
			sql += " sum(price) as totalprice";
			sql += " from member_tbl_02 NATURAL JOIN money_tbl_02";
			sql += " group by custno, custname, grade";
			sql += " order by 4 desc";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
			%>
				<tr align="center">					
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>					
				</tr>
			<%	
			}
			%>
			
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








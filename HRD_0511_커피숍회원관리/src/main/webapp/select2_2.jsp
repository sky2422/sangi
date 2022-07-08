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
			<h2>커피목록조회</h2>
		</div>
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>
				<th bgcolor="yellow">상품코드</th>
				<th bgcolor="yellow">상품명</th>
				<th bgcolor="yellow">상품단가</th>				
			</tr>
			
			<%			
			sql="SELECT PCODE,PNAME,PCOST FROM coffee_tbl";	
			
			rs=stmt.executeQuery(sql);
			while(rs.next()){
			%>
				<tr align="center">
					<td><a href="update2Delete2.jsp?PCODE=<%=rs.getString(1)%>"><%=rs.getString(1) %></a></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>					
				</tr>			
			<%			 	
			}
			%>
		</table>
		<p>
		<div>
			<h2>커피목록조회(수정된 커피 가격)</h2>
		</div>
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>
				<th bgcolor="yellow">상품코드</th>
				<th bgcolor="yellow">상품명</th>
				<th bgcolor="yellow">상품단가</th>				
			</tr>			
			<%			
			sql = "SELECT c2.PCODE, c2.PNAME, c2.PCOST ";	
			sql += " FROM coffee_tbl c1 JOIN coffee_tbl2 c2";
			sql += " ON c1.PCODE=c2.PCODE AND c1.PNAME=c2.PNAME AND c1.PCOST<>c2.PCOST";
			
			rs=stmt.executeQuery(sql);
			
			while(rs.next()){				
			%>
				<tr align="center">
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>					
				</tr>
			<%	
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
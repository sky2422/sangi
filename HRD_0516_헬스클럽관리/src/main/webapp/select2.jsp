<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스클럽관리</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<section>
		<div>
			<h2>트레이너목록</h2>
		</div>
		<div>
			<table style="margin: 0 auto;" width="700" border="1">
				<tr>
					<th style="background-color: yellow;">트레이너번호</th>
					<th style="background-color: yellow;">트레이너이름</th>
					<th style="background-color: yellow;">담당시간</th>
					<th style="background-color: yellow;">담당회원수</th>
				</tr>
				<%
					sql="select t.tno, tname , t.ttime, count(a.tno)"; 
					sql+=" from trainer_tbl t LEFT OUTER JOIN apptrainer_tbl a"; 
					sql+=" ON t.tno=a.tno";
					sql+=" group by t.tno, tname, t.ttime";
					sql+=" order by t.tno";
					
					rs=stmt.executeQuery(sql);
					
					while(rs.next()){
				%>
				<tr>
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
				</tr>
				<%		
					}
				%>
			</table>
		</div>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
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
			<h2>회원목록</h2>
		</div>
		<div>
			<table style="margin: 0 auto;" width="700" border="1">
				<tr>
					<th style="background-color: yellow;">회원번호</th>
					<th style="background-color: yellow;">회원이름</th>
					<th style="background-color: yellow;">회원주소</th>
					<th style="background-color: yellow;">등록일</th>
					<th style="background-color: yellow;">성별</th>
					<th style="background-color: yellow;">전화번호</th>
				</tr>
				<%@ page import="java.net.URLEncoder"%>
				
				<%
					sql="select memno,mname,maddress,";
					sql+=" to_char(joindate,'yyyy.mm.dd') joindate,";
					sql+=" decode(gender,'M','남','F','여') gender,tel";
					sql+=" from member_tbl";
					sql+=" order by memno";
					rs=stmt.executeQuery(sql);
					
					while(rs.next()){
				%>
				<tr>
					<td><!--회원번호와 회원이름을 값으로 넘김)-->
						<a href="insert2.jsp?memno=<%=rs.getString("memno") %>&mname=<%=URLEncoder.encode(rs.getString("mname"),"UTF-8") %>"><%=rs.getString("memno") %></a>
					</td>
					<td><%=rs.getString("mname") %></td>
					<td><%=rs.getString("maddress") %></td>
					<td><%=rs.getString("joindate") %></td>
					<td><%=rs.getString("gender") %></td>
					<td><%=rs.getString("tel") %></td>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>
<body>
	<%@ include file = "header.jsp" %> <!-- header.jsp안에 dbcon.jsp(DB 연결+변수 선언) -->
	<section>
		<div>
			<h2>회원조회</h2>
		</div>
		<!-- 자동으로 스크롤바 생김 -->
		<!-- <div style="overflow : auto"> -->
		
		<!-- style="margin:0 auto" 크롬에서 가운데 정렬 -->
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>주소</th>
				<th>가입일</th>
				<th>성별</th>
				<th>전화번호</th>				
			</tr>
			<%
			//sql = "select memno, name, address, to_char(hiredate,'yyyy.mm.dd.'), DECODE(gender, 'M','남', 'F','여'), 	tel1, tel2, tel3 from member";
			
			sql += "select memno, name, address,"; 
			sql += " to_char(hiredate,'yyyy.mm.dd.') AS hiredate,"; 
			sql += " DECODE(gender, 'M','남', 'F','여') AS gender,";
			sql += " tel1, tel2, tel3";
			sql += " from member";//★★주의:마지막에 제일 앞부분 한칸씩 띄우기
			sql += " order by memno";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){//'1001'''''
			%>
			<tr align="center">
			    <!--링크를 사용한  Get 방식으로 요청시 : "요청URL?파라미터이름1=파라미터값1&파라미터이름2=파라미터값2" -->
				<td><a href="update.jsp?memno=<%=rs.getString(1) %>"><%=rs.getString(1) %></a></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %>-<%=rs.getString(7) %>-<%=rs.getString(8) %></td>				
			</tr>
			<%} %>
		</table>
		<!-- </div> -->
	</section>	
	<%@ include file = "footer.jsp" %> <!-- DB 연결 해제 -->
</body>
</html>


















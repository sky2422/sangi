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
			<h2>매출조회</h2>
		</div>
		<!-- 자동으로 스크롤바 생김 -->
		<!-- <div style="overflow : auto"> -->
		
		<!-- style="margin:0 auto" 크롬에서 가운데 정렬 -->
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>등급</th>
				<th>회원번호</th>
				<th>이름</th>
				<th>구입액</th>				
			</tr>
			<%	
			/*
			sql += "select memgrade, "; 
			sql += " memno, name, TO_CHAR(totalprice,'L999,999,999') ";//지역화폐단위(L)+천단위 구분쉼표
			sql += " from grade JOIN (select memno, name, SUM(price*bno) as totalprice";
			sql += " from member NATURAL JOIN buy";				
			sql += " group by memno, name)";				
			sql += " ON (totalprice BETWEEN loprice AND hiprice)";//비등가조인 조건
			sql += " order by totalprice desc";//★★주의:마지막에 제일 앞부분 한칸씩 띄우기
			*/
			sql += "SELECT CASE when totalprice between (SELECT loprice FROM grade WHERE memgrade = 1) and (SELECT hiprice FROM grade WHERE memgrade = 1) then 'VIP'";
			sql += " when totalprice between (SELECT loprice FROM grade WHERE memgrade = 2) and (SELECT hiprice FROM grade WHERE memgrade = 2) then 'Gold'";
			sql += " when totalprice between (SELECT loprice FROM grade WHERE memgrade = 3) and (SELECT hiprice FROM grade WHERE memgrade = 3) then 'Silver'";
			sql += " when totalprice between (SELECT loprice FROM grade WHERE memgrade = 4) and (SELECT hiprice FROM grade WHERE memgrade = 4) then 'Normal' ";
			sql += " END AS grade,";
			sql += " m.memno, name, TO_CHAR(totalprice,'L999,999,999')";
			sql += " FROM member m JOIN (SELECT memno, sum(price*bno) AS totalprice";
			sql += " FROM buy";    
			sql += " GROUP BY memno) b";    
			sql += " ON (m.memno = b.memno)";
			sql += " ORDER BY totalprice desc";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){//
			%>
			<tr align="center">
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>			
			</tr>
			<%} %>
		</table>
		<!-- </div> -->
	</section>	
	<%@ include file = "footer.jsp" %> <!-- DB 연결 해제 -->
</body>
</html>


















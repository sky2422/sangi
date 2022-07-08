<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한관리 프로그램</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h3>사용자 조회/수정</h3>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>사용자번호</th>
				<th>사용자명</th>
				<th>소속부서번호</th>
				<th>사용자번구분</th>
				<th>등록일자</th>
			</tr>
			<%
			sql += "select USER_NO, USER_NAME, ";
			sql += " NVL(decode(DEPT_NO,'A01','인사','A02','개발','B01','총무','B02','회계'),' ') as DEPT_NO, ";
			sql += " USER_GBN,"; 
			sql += " to_char(REG_DATE,'yyyy/mm//dd') as REG_DATE";
			sql += " from USER_TBL_08";
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
			%>
			<tr>
				<td><a href="update.jsp?USER_NO=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getString(5)%></td>
			</tr>
			<%	
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>






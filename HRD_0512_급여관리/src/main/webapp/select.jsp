<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 조회/수정</title>
</head>
<body>
	<%@include file="header.jsp"%>
	<section>
		<div>
			<h3>사원 조회/수정</h3>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>사원번호</th>
				<th>사원명</th>
				<th>부서번호</th>
				<th>입사일자</th>
				<th>사원상태코드</th>
				<th>사원상태명</th>
			</tr>					
			<%
				sql = "select EMPLOYEE_NO, EMPLOYEE_NAME, DEPT_NO,";
				sql += " to_char(HIRE_DATE,'yyyy-mm-dd') as HIRE_DATE, EMPLOYEE_STATUS,";
				sql += " decode(EMPLOYEE_STATUS,'1','입사','2','퇴사','3','휴직')";
				sql += " from EMPLOYEE_TBL_13";
				sql += " order by EMPLOYEE_NO";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
			%>
				<tr align="center">
					<td><%=rs.getString(1) %></td> 
					<td> <!-- 같은이름이 있을 수 있으므로 반드시 PRIMARY KEY 사원번호 -->
					<a href="update.jsp?EMPLOYEE_NO=<%=rs.getString(1)%>"><%=rs.getString(2)%></a>
					</td>
					<td><%=rs.getString(3) %></td>
					<td><%=rs.getString(4) %></td>
					<td><%=rs.getString(5) %></td>
					<td><%=rs.getString(6) %></td>
				</tr>		
			<%
				}
			%>
		</table>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
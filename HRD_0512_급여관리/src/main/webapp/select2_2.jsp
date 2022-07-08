<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여조회</title>
</head>
<body>
	<%@include file="header.jsp"%>
	<section>
		<div>
			<h3>급여조회(1001:아침출근-저녁퇴근 / 저녁퇴근-아침출근)</h3>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>근무년월</th>
				<th>사원번호</th>
				<th>급여</th>
			</tr>
			<%
				sql = " select substr(WORK_DATE,1,6)as WORK_DATE, EMPLOYEE_NO, ";
				sql += " (case ";
				sql += " when sum(substr(WORK_OUT_TIME,1,2)-substr(WORK_IN_TIME,1,2))>0 ";
				sql += " then (sum(substr(WORK_OUT_TIME,1,2)-substr(WORK_IN_TIME,1,2))*60";
				sql += " + sum(substr(WORK_OUT_TIME,3,2)-substr(WORK_IN_TIME,3,2)))*(9000/60)";
				sql += " when sum(substr(WORK_OUT_TIME,1,2)-substr(WORK_IN_TIME,1,2))<0";
				sql += " then (sum(24-substr(WORK_IN_TIME,1,2)+substr(WORK_OUT_TIME,1,2))*60";
				sql += " + sum(substr(WORK_OUT_TIME,3,2)-substr(WORK_IN_TIME,3,2)))*(9000/60)";
				sql += " end) as salary";
				sql += " from EMPLOYEE_TBL_13 natural join WORK_TBL_13";
				sql += " group by substr(WORK_DATE,1,6), EMPLOYEE_NO";

				rs = stmt.executeQuery(sql);

				while (rs.next()) {
			%>
			<tr style="text-align: center;">
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
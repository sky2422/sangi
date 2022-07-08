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
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>
				<th>근무년월</th>
				<th>사원번호</th>
				<th>급여</th>
			</tr>
			<%
				sql = " select substr(WORK_DATE,1,6),EMPLOYEE_NO,";
				//sql += " sum(round((WORK_OUT_TIME-WORK_IN_TIME)*24*60,2)) as total_time,";
				sql += " sum(round((WORK_OUT_TIME-WORK_IN_TIME)*24*60,2))*(9000/60) as salary";
				sql += " from(select substr(WORK_DATE,1,6) WORK_DATE,EMPLOYEE_NO, ";
				sql += " to_date(WORK_IN_TIME,'hh24mi') WORK_IN_TIME,";
				sql += " (case ";
				sql += "  when WORK_IN_TIME>WORK_OUT_TIME then (to_date(WORK_OUT_TIME,'hh24mi')+1)";
				sql += " else to_date(WORK_OUT_TIME,'hh24mi') ";
				sql += " end) as WORK_OUT_TIME";
				sql += " from WORK_TBL_13)";
				sql += " group by substr(WORK_DATE,1,6),EMPLOYEE_NO";

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
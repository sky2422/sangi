<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 성적 관리</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h2>성적조회</h2>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>전공1</th>
				<th>전공2</th>
				<th>전공3</th>
				<th>교양1</th>
				<th>교양2</th>
				<th>학생총점</th>
				<th>학생평균</th>
			</tr>
			<%
			sql += "select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,";
			sql += " (m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2) AS sumscore,";
			sql += " ROUND((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5,1) AS avgscore";
			sql += " from student_tbl LEFT OUTER JOIN score_tbl";
			sql += " USING(studno)";
			sql += " order by studno asc";
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
			%>
			<tr align="center">
				<!-- studno는 NUMBER이므로 -->
				<%-- <td><%=rs.getInt(1) %></td> --%><!-- 연산을 하려면  -->
				<td><%=rs.getString(1) %></td><!-- 목적 : 출력만 하므로 String  -->
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
				<td><%=rs.getString(7) %></td>
				<td><%=rs.getString(8) %></td>
				<td><%=rs.getString(9) %></td>
			</tr>
			<%	
			}
			%>
			
			<%
			sql = "select SUM(m_subject1),SUM(m_subject2),SUM(m_subject3),SUM(s_subject1),SUM(s_subject2)";
			sql += " from score_tbl";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
			%>
			<tr align="center">	
			    <td colspan="2">과목 총점</td>			
				<td><%=rs.getString(1)!=null?rs.getString(1):""%></td>
				<td><%=rs.getString(2)!=null?rs.getString(2):""%></td>
				<td><%=rs.getString(3)!=null?rs.getString(3):""%></td>
				<td><%=rs.getString(4)!=null?rs.getString(4):""%></td>
				<td><%=rs.getString(5)!=null?rs.getString(5):""%></td>
				<td colspan="2"></td>					
			</tr>
			<%	
			}
			%>
			
			<%
			sql = "select ROUND(AVG(m_subject1),1),ROUND(AVG(m_subject2),1),ROUND(AVG(m_subject3),1),ROUND(AVG(s_subject1),1),ROUND(AVG(s_subject2),1)";
			sql += " from score_tbl";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
			%>
			<tr align="center">	
			    <td colspan="2">과목 평균</td>			
				<td><%=rs.getString(1)!=null?rs.getString(1):""%></td>
				<td><%=rs.getString(2)!=null?rs.getString(2):""%></td>
				<td><%=rs.getString(3)!=null?rs.getString(3):""%></td>
				<td><%=rs.getString(4)!=null?rs.getString(4):""%></td>
				<td><%=rs.getString(5)!=null?rs.getString(5):""%></td>
				<td colspan="2"></td>					
			</tr>
			<%	
			}
			%>
		</table>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>








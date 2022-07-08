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
					<th style="padding:0px 8px">학번</th>
					<th style="padding:0px 8px">이름</th>
					<th style="padding:0px 8px">전공1</th>
					<th style="padding:0px 8px">전공2</th>
					<th style="padding:0px 8px">전공3</th>
					<th style="padding:0px 8px">교양1</th>
					<th style="padding:0px 8px">교양2</th>
					<th style="padding:0px 8px">학생총점</th>
					<th style="padding:0px 8px">학생평균</th>
				</tr>
				<%
				sql = "select * from (";
				sql += " select studno, sname, m_subject1, m_subject2, m_subject3, s_subject1, s_subject2,";
				sql += " m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2 as total,"; 
				sql += " round((m_subject1 + m_subject2 + m_subject3 + s_subject1 + s_subject2)/5, 1) as avg";
				sql += " from student_tbl left outer join score_tbl using(studno)";
				
				sql += " union all";
				
				sql += " select null, '과목 총점', sum(m_subject1) as m_subject1, sum(m_subject2) as m_subject2, sum(m_subject3) as m_subject3,"; 
				sql += " sum(s_subject1) as s_subject1, sum(s_subject2) as s_subject2, null, null";
				sql += " from score_tbl";
				
				sql += " union all";
				
				sql += " select null, '과목 평균', round(avg(m_subject1),1) as m_subject1, round(avg(m_subject2),1) as m_subject2, round(avg(m_subject3),1) as m_subject3,"; 
				sql += " round(avg(s_subject1),1) as s_subject1, round(avg(s_subject2),1) as s_subject2, null, null";
				sql += " from score_tbl";
				sql += " ) order by studno asc";
				
				ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				
				while(rs.next()) {
				%>
				<tr align="center">
				
					<%if(!(rs.getString("sname").equals("과목 총점")||rs.getString("sname").equals("과목 평균"))) {%>
						<td><%=rs.getString("studno")!=null?rs.getString("studno"):"" %></td>
						<td><%=rs.getString("sname")!=null?rs.getString("sname"):"" %></td>
					<%} else {%>
						<th colspan="2"><%=rs.getString("sname")%></th>			
					<%}%>
					
					<td><%=rs.getString("m_subject1")!=null?rs.getString("m_subject1"):"" %></td>
					<td><%=rs.getString("m_subject2")!=null?rs.getString("m_subject2"):""  %></td>
					<td><%=rs.getString("m_subject3")!=null?rs.getString("m_subject3"):""  %></td>
					<td><%=rs.getString("s_subject1")!=null?rs.getString("s_subject1"):"" %></td>
					<td><%=rs.getString("s_subject2")!=null?rs.getString("s_subject1"):"" %></td>
					
					<%if(rs.getString("total")!=null || rs.getString("avg")!=null) {%>
						<td><%=rs.getString("total")!=null?rs.getString("total"):"" %></td>
						<td><%=rs.getString("avg")!=null?rs.getString("avg"):"" %></td>
					<%} else {%>
						<td colspan="2"></td>			
					<%}%>	
									
				</tr>
				<% 	
				}
				%>
		</table>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>








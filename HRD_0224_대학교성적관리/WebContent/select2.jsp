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
			<h2>재수강대상자</h2>
		</div>
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>
				<th>과목</th>
				<th>전공1</th>
				<th>전공2</th>
				<th>전공3</th>
				<th>교양1</th>
				<th>교양2</th>	
			</tr>
			<%
			sql = "select SUM(CASE when m_subject1>=90 then 1 else 0 END),";
			sql += " SUM(CASE when m_subject2>=90 then 1 else 0 END),";
			sql += " SUM(CASE when m_subject3>=90 then 1 else 0 END),";
			sql += " SUM(CASE when s_subject1>=90 then 1 else 0 END),";
			sql += " SUM(CASE when s_subject2>=90 then 1 else 0 END)";
			sql += " from score_tbl";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
			%>
			<tr align="center">	
				<th>성적 우수자</th>			
				<td><%=rs.getString(1)!=null?rs.getString(1):""%>명</td>
				<td><%=rs.getString(2)!=null?rs.getString(2):""%>명</td>
				<td><%=rs.getString(3)!=null?rs.getString(3):""%>명</td>
				<td><%=rs.getString(4)!=null?rs.getString(4):""%>명</td>
				<td><%=rs.getString(5)!=null?rs.getString(5):""%>명</td>				
			</tr>
			<%	
			}
			%>
			
			<%
			//주의 : sql = 으로 시작
			sql = "select SUM(CASE when m_subject1<60 then 1 else 0 END),";
			sql += " SUM(CASE when m_subject2<60 then 1 else 0 END),";
			sql += " SUM(CASE when m_subject3<60 then 1 else 0 END),";
			sql += " SUM(CASE when s_subject1<60 then 1 else 0 END),";
			sql += " SUM(CASE when s_subject2<60 then 1 else 0 END)";
			sql += " from score_tbl";
			
			rs = stmt.executeQuery(sql);
			if(rs.next()){
			%>
			<tr align="center">	
				<th>재수강 대상자</th>			
				<td><%=rs.getString(1)!=null?rs.getString(1):""%>명</td>
				<td><%=rs.getString(2)!=null?rs.getString(2):""%>명</td>
				<td><%=rs.getString(3)!=null?rs.getString(3):""%>명</td>
				<td><%=rs.getString(4)!=null?rs.getString(4):""%>명</td>
				<td><%=rs.getString(5)!=null?rs.getString(5):""%>명</td>				
			</tr>
			<%	
			}
			%>
			
			
		</table>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>








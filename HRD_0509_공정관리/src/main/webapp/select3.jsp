<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>과정평가형 자격 CBQ</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>제품조회</h2>
		</div>
		<table border="1" width="900" style="margin:0 auto">
			<tr>
				<th>작업지시번호</th>
				<th>제품코드</th>
				<th>제품명</th>
				<th>준비</th>
				<th>인쇄</th>
				<th>코팅</th>
				<th>합지</th>
				<th>접합</th>
				<th>포장</th>
				<th>최종공정일자</th>
				<th>최종공정시간</th>
			</tr>
			<%
			sql+="select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno,";
			sql+=" w.p_code,p_name,";
			sql+=" decode(p_p1,'Y','완료','N','~','') as p_p1,";
			sql+=" decode(p_p2,'Y','완료','N','~','') as p_p2,";
			sql+=" decode(p_p3,'Y','완료','N','~','') as p_p3,";
			sql+=" decode(p_p4,'Y','완료','N','~','') as p_p4,";
			sql+=" decode(p_p5,'Y','완료','N','~','') as p_p5,";
			sql+=" decode(p_p6,'Y','완료','N','~','') as p_p6,";
			//--to_char(수나 '날짜','형식') 사용못하는 이유 : w_lastdate는 문자이므로 사용불가
			sql+=" substr(w_lastdate,1,4)||'-'||substr(w_lastdate,5,2)||'-'||substr(w_lastdate,7,2) as w_lastdate,";
			sql+=" substr(w_lasttime,1,2)||':'||substr(w_lasttime,3,2) as w_lasttime";
			sql+=" from TBL_PROCESS pc left outer join TBL_WORKLIST w";
			sql+=" on (pc.w_workno=w.w_workno)";
			sql+=" left outer join TBL_PRODUCT pd";
			sql+=" on (w.p_code=pd.p_code)";
			sql+=" order by 1";
			
			rs=stmt.executeQuery(sql);
			
			while(rs.next()){
			%>
				<tr align="center">
				<!-- 표현식 : 변수, 반환값이 있는 메서드 -->
					<td><%=rs.getString(1)!=null?rs.getString(1):""%></td>
					<td><%=rs.getString(2)!=null?rs.getString(2):"" %></td>
					<td><%=rs.getString(3)!=null?rs.getString(3):"" %></td>
					<td><%=rs.getString(4)!=null?rs.getString(4):"" %></td>
					<td><%=rs.getString(5)!=null?rs.getString(5):"" %></td>
					<td><%=rs.getString(6)!=null?rs.getString(6):"" %></td>
					<td><%=rs.getString(7)!=null?rs.getString(7):"" %></td>
					<td><%=rs.getString(8)!=null?rs.getString(8):"" %></td>
					<td><%=rs.getString(9)!=null?rs.getString(9):"" %></td>
					<td><%=rs.getString(10)!=null?rs.getString(10):"" %></td>
					<td><%=rs.getString(11)!=null?rs.getString(11):"" %></td>
					
				</tr>
			<%	
			}
			%>
		</table>
    </section>
	<%@include file="footer.jsp"%>
</body>
</html>
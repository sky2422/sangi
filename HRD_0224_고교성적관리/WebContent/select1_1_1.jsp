<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고교성적관리</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<section>
		<div>
			<h2>성적조회</h2>
		</div>
		
		<table style="margin: 0 auto;" width="800" border="1">
				<tr>
					<th>학년 반 번호</th>
					<th>이름</th>
					<th>성별</th>
					<th>국어</th>
					<th>영어</th>
					<th>수학</th>
					<th>총점</th>
					<th>평균</th>
				</tr>
				<%
				/*
				//[문제-1] 학생등록 후 성적등록 안하면 '성적조회안되도록 함', ※총점수합계, 총점수평균 따로
				//NATURAL JOIN
				sql += "select syear||'_'||sclass||'_'||sno, sname, ";
				sql += " decode(gender,'M','남','F','여') as gender, ";
				sql += " kor, eng, math,";
				sql += " sum(kor+eng+math) as totalsum,";
				sql += " round(sum(kor+eng+math)/3,1) as totalavg";
				sql += " from examtbl_1 NATURAL JOIN examtbl_3";
				sql += " group by syear, sclass, sno, sname, gender, kor, eng, math";
				sql += " order by syear, sclass, sno asc";
				*/
				
				/*
				//[문제-2] 학생등록 후 성적등록 안해도 '성적조회되도록 함', ※총점수합계, 총점수평균 따로
				//LEFT OUTER JOIN~ON
				sql += "select e1.syear||'_'||e1.sclass||'_'||e1.sno, sname, ";
				sql += " decode(gender,'M','남','F','여') as gender, ";
				sql += " kor, eng, math,";
				sql += " sum(kor+eng+math) as totalsum,";
				sql += " round(sum(kor+eng+math)/3,1) as totalavg";
				sql += " from examtbl_1 e1 LEFT OUTER JOIN examtbl_3 e3";
				sql += " ON e1.syear=e3.syear and e1.sclass=e3.sclass and e1.sno=e3.sno";
				sql += " group by e1.syear, e1.sclass, e1.sno, sname, gender, kor, eng, math";
				sql += " order by e1.syear, e1.sclass, e1.sno asc";
				*/
				
				//[문제-2] 학생등록 후 성적등록 안해도 '성적조회되도록 함', ※총점수합계, 총점수평균 따로
				//LEFT OUTER JOIN~USING
				//[방법-3] null 처리를 java로
				sql += "select syear||'_'||sclass||'_'||sno, sname, ";
				sql += " decode(gender,'M','남','F','여') as gender, ";
				sql += " kor, eng, math,";
				sql += " sum(kor+eng+math) as totalsum,";
				sql += " round(sum(kor+eng+math)/3,1) as totalavg";
				sql += " from examtbl_1 LEFT OUTER JOIN examtbl_3";
				sql += " USING(syear, sclass, sno)";
				sql += " group by syear, sclass, sno, sname, gender, kor, eng, math";
				sql += " order by syear, sclass, sno asc";
				
				rs = stmt.executeQuery(sql);
				
				//[java로 null 처리방법-2]
				String kor=null;
				String eng=null;
				String math=null;
				String totalsum=null;
				String totalavg=null;
				
				while(rs.next()){
					if(rs.getString(4)!=null) kor=rs.getString(4);
					else kor="";
					
					if(rs.getString(5)!=null) eng=rs.getString(5);
					else eng="";
					
					if(rs.getString(6)!=null) math=rs.getString(6);
					else math="";
					
					if(rs.getString(7)!=null) totalsum=rs.getString(7);
					else totalsum="";
					
					if(rs.getString(8)!=null) totalavg=rs.getString(8);
					else totalavg="";
				%>
				<tr align="center">
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>					
					<td><%=kor%></td>
					<td><%=eng%></td>
					<td><%=math%></td>
					<td><%=totalsum%></td>
					<td><%=totalavg%></td>
				</tr>
				<%	
				}
				
				sql = "select sum(kor), sum(eng), sum(math),";
				sql += " round(avg(kor),1), round(avg(eng),1), round(avg(math),1) ";
				sql += "from examtbl_3";
				
				rs = stmt.executeQuery(sql);
				rs.next();
				%>
				<tr align="center">
					<td></td>
					<td></td>
					<td>총점수합계</td>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td></td>
					<td></td>
				</tr>
				<tr align="center">
					<td></td>
					<td></td>
					<td>총점수평균</td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
					<td></td>
					<td></td>
				</tr>
		</table>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>








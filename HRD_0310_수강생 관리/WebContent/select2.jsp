<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h2>■ 월별 신청 현황</h2>
		</div>
		<div style="overflow:auto;">
			<table border="1" width="300" style="margin: 0 auto;">
				<tr>
					<th>신청년월</th>
					<th>수강인원</th>					
				</tr>
				<%
				sql = "select to_char(REGISTER_DATE,'yyyy/mm'), count(STUDENT_NO)";
				sql += " from REGISTER_TBL_01";
				       //group by REGISTER_DATE//'년월일'하나의 그룹으로 (주의)=>결과가 달라짐
				sql += " group by to_char(REGISTER_DATE,'yyyy/mm')";//'년월'하나의 그룹으로
				sql += " order by 1";
				
				rs=stmt.executeQuery(sql);
				
				while(rs.next()){
				%>
				<tr align="center">					
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
		
		<div>
			<h2>■ 수강신청정보조회</h2>
		</div>
		<div style="overflow:auto;">
			<table border="1" width="700" style="margin: 0 auto;">
				<tr>
					<th>수강신청번호</th>
					<th>수강생</th>
					<th>과목명</th>
					<th>신청일자</th>
					<th>이수여부</th>				
				</tr>
				<%
				/* //방법-1(decode 이용)
				sql = "select REGISTER_SEQ, STUDENT_NO, STUDENT_NAME, SUBJECT_NAME, REGISTER_DATE,";
				sql += " decode(REGISTER_STATUS,'0','신청','1','완료','2','취소')";
				sql += " from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01";//STUDENT_NO(수강생번호)로 조인
				sql += " NATURAL join SUBJECT_TBL_01";//SUBJECT_SEG(과목번호)로 조인
				sql += " order by 1 desc";
				*/
				
				//방법-2(CASE~END 이용)
				sql = "select REGISTER_SEQ, STUDENT_NO, STUDENT_NAME, SUBJECT_NAME, REGISTER_DATE,";
				sql += " case REGISTER_STATUS";
				sql += " when '0' then '신청'";
				sql += " when '1' then '완료'";
				sql += " when '2' then '취소'";
				sql += " end REGISTER_STATUS";
				sql += " from STUDENT_TBL_01 NATURAL join REGISTER_TBL_01 NATURAL join SUBJECT_TBL_01";
				sql += " order by 1 desc";
				
				rs=stmt.executeQuery(sql);
				
				while(rs.next()){
				%>
				<tr align="center">					
					<td><%=rs.getString(1)%></td>
					<td>(<%=rs.getString(2)%>)<%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
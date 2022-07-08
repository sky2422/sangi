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
			<h2>수강생 조회/수정</h2>
		</div>
		<div style="height:400px; overflow:auto;">
			<table border="1" width="800" style="margin: 0 auto;">
				<tr>
					<th>수강생번호</th>
					<th>이름</th>
					<th>연락처</th>
					<th>생년월일</th>
					<th>메일주소</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>수강과목수</th>
				</tr>
				<%
				/*
				null 처리방법-1 : 삼항연산자    (조건문)?참:거짓
						        rs.getString(5)!=null?rs.getString(5):' '
							    rs.getString(5)!=null?rs.getString(5):""
				null 처리방법-2 : nvl(STUDENT_EMAIL,' ') //주의 ' '
				null 처리방법-3 : nvl2(STUDENT_ID, STUDENT_ID, ' ')
				*/
				sql = "select s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE,  "; 
				sql += " to_char(STUDENT_BIRTH,'yyyy/mm/dd') as STUDENT_BIRTH,";
				//sql += " nvl(STUDENT_EMAIL,' ') as STUDENT_EMAIL,";
				sql += " STUDENT_EMAIL,";//방법-1 사용함
				sql += " nvl(STUDENT_ID,' ') as STUDENT_ID,";//방법-2 사용함
				sql += " nvl2(STUDENT_PW, STUDENT_PW, ' ') as STUDENT_PW,";//방법-3 사용함
				sql += " count(r.STUDENT_NO)";//주의:s.STUDENT_NO로 하면 안됨
				sql += " from STUDENT_TBL_01 s LEFT OUTER JOIN REGISTER_TBL_01 r";
				sql += " on(s.STUDENT_NO = r.STUDENT_NO)";
				sql += " GROUP BY s.STUDENT_NO, STUDENT_NAME, STUDENT_PHONE, STUDENT_BIRTH,";
				sql += " STUDENT_EMAIL, STUDENT_ID, STUDENT_PW";
				sql += " ORDER BY 8 ASC, 1 DESC";
				
				rs=stmt.executeQuery(sql);
				
				while(rs.next()){
				%>
				<tr align="center">
					<td>
						<a href="updateDelete2.jsp?STUDENT_NO=<%=rs.getString(1)%>"><%=rs.getString(1)%></a>
					</td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)!=null?rs.getString(5):' '%></td><!-- 방법1:삼항연산자    (조건문)?참:거짓  -->
					<td><%=rs.getString(6)%></td> <!-- 방법-2사용함 -->
					<td><%=rs.getString(7)%></td> <!-- 방법-3사용함 -->					
					<td><%=rs.getString(8)%></td> 
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page import="java.net.URLEncoder" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 조회/수정</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>선수 정보 조회/수정</h2>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>선수번호</th>
				<th>이름</th>
				<th>소속팀번호</th>
				<th>연락처</th>
				<th>등번호</th>
				<th>생일</th>
				<th>메일주소</th>				
			</tr>
			<%@ page import="java.net.URLEncoder" %>
			<%
			sql += "select PLAYER_NO,PLAYER_NAME,TEAM_NO,"; 
			//방법-1
			sql += " substr(PLAYER_PHONE,1,3)||'-'||substr(PLAYER_PHONE,4,4)||'-'||substr(PLAYER_PHONE,8,4),";
			
			//방법-2:정규화 사용
			/* https://gent.tistory.com/221 참조
			-- 오라클 ----
			REGEXP_REPLACE(PLAYER_PHONE, '(문자열앞3자리)(나머지문자열)(문자열뒤4자리)', '\1-\2-\3')
			핸드폰 번호는 [3자리 + (3자리 또는 4자리) + 4자리] 의 형식
			
			-- java : \1-\2-\3에서 특수문자(\)인식하기 위해 앞에 \추가(이스케이프 문자) ----
			REGEXP_REPLACE(PLAYER_PHONE, '(문자열앞3자리)(나머지문자열)(문자열뒤4자리)', '\\1-\\2-\\3')
			 */			
			//sql += " REGEXP_REPLACE(PLAYER_PHONE, '(.{3})(.+)(.{4})', '\\1-\\2-\\3'),";
			
			sql += " BACK_NO, to_char(PLAYER_BIRTH,'mm/dd'),";
			sql += " nvl(PLAYER_EMAIL,' ')";//''은 null과 같다
			sql += " from PLAYER_TBL";
			sql += " order by BACK_NO asc";
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
			%>
			<tr style="text-align: center;">
				<td><%=rs.getString(1)%></td>
				<td> 
				    <!-- 선수이름을 파라미터 값으로 넘기지 말고-->
				    <%-- <a href="update.jsp?PLAYER_NAME=<%=URLEncoder.encode(rs.getString(2),"utf-8")%>"><%=rs.getString(2)%></a> --%>
					<!-- '기본키'에 대한 값을 파라미터 값으로 넘겨야 함-->
					<a href="update.jsp?PLAYER_NO=<%=rs.getString(1)%>"><%=rs.getString(2)%></a>
				</td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getString(5)%></td>
				<td><%=rs.getString(6)%></td>
				<td><%=rs.getString(7)%></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>







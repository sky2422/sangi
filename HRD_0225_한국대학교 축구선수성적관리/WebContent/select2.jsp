<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ page import="java.net.URLEncoder" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>경기결과조회</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>경기 결과 조회</h2>
		</div>
		<table border="1" width="700" style="margin: 0 auto;">
			<tr>
				<th>경기번호</th>
				<th>득점</th>
				<th>경고수</th>
				<th>퇴장수</th>		
			</tr>
			<%
			sql += "select MATCH_NO, sum(PLAYER_SCORE), sum(YELLOW_CARD), sum(RED_CARD)";
			sql += " from RECORD_TBL";
			sql += " group by MATCH_NO";
			sql += " order by 1";
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
			%>
			<tr style="text-align: center;">
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getString(4)%></td>
			</tr>
			<%
				}
				%>
			</table>
			<table style="margin:8px auto">
			<%
			sql = "select player_no, player_name, player_score";
			sql += " from player_tbl join (";
			sql += " select player_no,"; 
			sql += " rank() over(order by sum(player_score) desc, sum(yellow_card), sum(red_card)) as rank,";
			sql += " sum(player_score) as player_score";
			sql += " from record_tbl group by player_no)";
			sql += " using(player_no) where rank = 1 order by player_no";
			
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()){
			%>
				<tr height="40px">
					<td width="100px">최우수 선수</td>
					<td width="180px"><%=rs.getString("player_no") %></td>
					<td width="100px"><%=rs.getString("player_name") %></td>
					<td><%=rs.getString("player_score") %>골</td>
				</tr>
			<%
			}
			%>	
			</table>
		</article>
	</section>
	
	<%@ include file="footer.jsp" %>
</body>
</html>

<!-- 
[ResultSet cursor 제어]
ResultSet rs = null;
rs.first(); //rs 의 커서를 제일 처음으로 이동
rs.last();//커서를 제일 뒤로 이동
rs.next(); //커서를 다음으로(한칸 이동)
rs.previous(); //커서를 이전으로(한칸이동)
rs.getRow();//현재 커서의 위치값
rs.isFirst();//커서의 위치가 처음인지 확인
(ex)   if(rs.isFirst()) {
       System.out.println("처음입니다.");
   }
rs.isLast();//커서의 위치가 마지막인지 확인
rs.beforeFirst();//커서를 제일 앞으로(rs.first() 보다 한칸 앞_빈공간)
rs.afterLast();//커서를 제일 뒤로(rs.last() 보다 한칸 뒤_빈공간)

### ResultSet을 제어하다보면 "전방향 전용 결과 집합에 부적합한 작업이 수행되었습니다" 라는 에러를 볼수있다.
이럴땐 statement에서 "ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE"를 선언해주자!
-----------------------------------------------------
String sql = "select * from table";
pstmt = conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs = pstmt.executeQuery();
-----------------------------------------------------
# mysql에서는 없었는데 오라클을 사용하면서 겪은 에러
                             



 -->





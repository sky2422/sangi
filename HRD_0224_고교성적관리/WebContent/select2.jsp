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
			<h2>반별평균</h2>
		</div>
		
		<table style="margin: 0 auto;" width="800" border="1">
				<tr>
					<th>학년</th>
					<th>반</th>
					<th>교사명</th>
					<th>국어총점</th>
					<th>영어총점</th>
					<th>수학총점</th>
					<th>국어평균</th>
					<th>영어평균</th>
					<th>수학평균</th>
				</tr>
				<%
				sql="select syear, sclass, tname, sum(kor),sum(eng),sum(math),";
				sql+=" round(avg(kor),1), round(avg(eng),1), round(avg(math),1)";
				sql+=" from examtbl_3 natural join examtbl_2";
				sql+=" group by syear, sclass, tname";
				sql+=" order by sclass";
				
				
				/* AVG 함수는 null 값을 제외하고 연산하는데,
				null 값을 포함해서 평균을 계산해야 하는 경우에는 NVL 함수를 사용하여
				AVG(NVL(kor, 0)) 형태로 null 값을 치환해야 정확한 값이 계산됩니다. */
				/*
				sql = "select syear, sclass, tname,";
				sql += " sum(kor),sum(eng),sum(math),";
				sql += " round(avg(NVL(kor,0)),1), round(avg(NVL(eng,0)),1), round(avg(NVL(math,0)),1)";
				sql += " from examtbl_2 natural join examtbl_3";
				sql += " group by syear, sclass, tname";
				sql += " order by sclass";
				*/
				
				rs = stmt.executeQuery(sql);
				
				//[java로 null 처리방법-1]
				while(rs.next()){
				%>
				<tr align="center">
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>					
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>		
					<td><%=rs.getString(7)%></td>
					<td><%=rs.getString(8)%></td>
					<td><%=rs.getString(9)%></td>		
				</tr>
				<%	
				}
				%>				
		</table>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>








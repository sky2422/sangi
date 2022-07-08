<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피숍 회원관리 프로그램</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>매출현황조회</h2>
		</div>
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>				
				<th bgcolor="yellow">상품명</th>
				<th bgcolor="yellow">상품단가</th>	
				<th bgcolor="yellow">총판매수량</th>			
				<th bgcolor="yellow">총판매금액</th>			
			</tr>			
			<%			
			sql = "select c.PNAME, c.PCOST,";
			sql += " nvl(sum(s.AMOUNT),0),";//nvl(to_char(sum(s.AMOUNT),'999,999,999'),' '),
			sql += " nvl(to_char(sum(s.AMOUNT)*c.PCOST,'L999,999,999'),' ')";
			//nvl(to_char(sum(PRICE),'L999,999,999'),' ')
			sql += " from coffee_tbl c, sale_tbl s";//중복 제거하지 않으므로 별칭 사용함
			sql += " where c.PCODE=s.PCODE(+)";//조인조건
			sql += " group by PNAME, PCOST";
			sql += " order by 4 DESC";
			
			rs=stmt.executeQuery(sql);
			while(rs.next()){
			%>
				<tr align="center">
					<td><%=rs.getString(1) %></td>
					<td><%=rs.getString(2) %></td>
					<td><%=rs.getString(3) %></td>					
					<td align="right"><%=rs.getString(4) %></td>					
				</tr>
			<%			 	
			}
			%>
		</table>		
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
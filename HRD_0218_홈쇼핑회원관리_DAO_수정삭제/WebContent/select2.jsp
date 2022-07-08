<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈쇼핑 회원관리</title>
</head>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>회원매출조회</h2>
		</div>
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>				
			</tr>
			<%@ page import="java.util.List" %>
			<%@ page import="member.*" %>
			
			<%
			ShoppingDAO dao=new ShoppingDAO();
			
			//List부모 인터페이스
			List<SalesBeans> list=dao.getSales();
			
			for(int i=0;i<list.size();i++){//size():객체수=Member수
				SalesBeans beans=list.get(i);
			%>
				<tr align="center">
					<td><%=beans.getCustno() %></td>				
					<td><%=beans.getCustname() %></td>
					<td><%=beans.getGrade() %></td>
					<td><%=beans.getTotalprice() %></td>									
				</tr>
			<%
			}
			%>
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








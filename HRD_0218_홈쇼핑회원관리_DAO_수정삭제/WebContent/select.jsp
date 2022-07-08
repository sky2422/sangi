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
			<h2>회원목록조회/수정</h2>
		</div>
		<table style="margin:0 auto" border="1" width="900">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			
			<%@ page import="java.util.List" %>
			<%@ page import="member.*" %>
			
			<%
			ShoppingDAO dao = new ShoppingDAO();
			
			//List 부모 인터페이스
			List<MemberBeans> list = dao.getMembers();
			
			for(int i=0;i<list.size();i++){//size():객체수=Member수
				MemberBeans beans = list.get(i);
			%>
				<tr align="center">
					<td><a href="updateDelete.jsp?custno=<%=beans.getCustno()%>"><%=beans.getCustno()%></a></td>
					<td><%=beans.getCustname()%></td>
					<td><%=beans.getPhone()%></td>
					<td><%=beans.getAddress()%></td>
					<td><%=beans.getJoindate()%></td>
					<td><%=beans.getGrade()%></td>
					<td><%=beans.getCity()%></td>					
				</tr>
			<%	
			}
			%>
			
		</table>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








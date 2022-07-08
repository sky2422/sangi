<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피숍 회원관리 프로그램</title>
</head>
<script type="text/javascript">
	function updatecheck() {
		f.update2Delete2Pro.value="update";
		if (f.PCODE.value == "") {
			alert("상품코드가 입력되지 않았습니다.");
			return f.PCODE.focus();
		}
		if (f.PNAME.value == "") {
			alert("상품명이 입력되지 않았습니다.");
			return f.PNAME.focus();
		}
		if (f.PCOST.value == "") {
			alert("상품단가가 선택되지 않았습니다.");
			return f.PCOST.focus();
		}		
		f.submit();
	}
	
	function deletecheck() {
		f.update2Delete2Pro.value="delete";
		if (f.PCODE.value == "") {
			alert("상품코드가 입력되지 않았습니다.");
			return f.PCODE.focus();
		}
		f.submit();
	}
	
</script>
<body>
	<%@ include file="header.jsp"%>
	<%
	String PCODE=request.getParameter("PCODE");
	
	//sql="select PCODE,PNAME,PCOST from coffee_tbl where PCODE='"+PCODE+"'"; //★★주의 : 반드시 '문자' (작은 따옴표)
	//rs=stmt.executeQuery(sql);
	
	sql="select PCODE,PNAME,PCOST from coffee_tbl where PCODE=?";
	ps=con.prepareStatement(sql);	
	
	ps.setString(1, PCODE);
	rs=ps.executeQuery();
	
	rs.next();
	
	String PNAME=rs.getString("PNAME");
	String PCOST=rs.getString("PCOST");
	%>
	<section>
		<div>
			<h2>커피목록수정/삭제</h2>
		</div>
		<form action="update2Delete2Pro.jsp" method="post" name="f">
			<input type="hidden" name="update2Delete2Pro" value="">
			<table border="1" width="700" style="margin: 0 auto;">
				<tr>
					<th bgcolor="yellow">상품코드</th>
					<td>
						<input type="text" name="PCODE" value="<%=PCODE%>" size="30">
						4글자 내로 입력하세요. ex)A101
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">상품명</th>
					<td>
						<input type="text" name="PNAME" value="<%=PNAME%>" size="30">
					</td>
				</tr>				
				<tr>
					<th style="background-color: yellow;">상품단가</th>
					<td>
						<input type="text" name="PCOST" value="<%=PCOST%>" size="30">
						가격만 입력하시오.ex)6000
					</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" value="수정" onclick="updatecheck();return false;">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="삭제" onclick="deletecheck();return false;">
			</center>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
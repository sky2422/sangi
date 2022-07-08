<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈쇼핑 회원관리</title>
</head>

<script type="text/javascript">
function check(){
	if(f.custno.value == ""){//if(f.custno.value == ''){//if(!f.custno.value){
		alert("회원번호가 입력되지 않았습니다.");		
		return f.custno.focus();
	}
	if(f.custname.value == ""){
		alert("회원성명이 입력되지 않았습니다.");		
		return f.custname.focus();
	}
	if(f.phone.value == ""){
		alert("전화번호가 입력되지 않았습니다.");		
		return f.phone.focus();
	}
	if(f.address.value == ""){
		alert("회원주소가 입력되지 않았습니다.");		
		return f.address.focus();
	}
	if(f.joindate.value == ""){
		alert("가입일자가 입력되지 않았습니다.");		
		return f.joindate.focus();
	}
	
	if(f.grade.value == ""){
		alert("회원등급이 입력되지 않았습니다.");		
		return f.grade.focus();
	}
	/*
	if(f.grade.value != "A" 
	&& f.grade.value != "B"
	&& f.grade.value != "C" ){
		alert("회원등급이 잘못 입력되었습니다.");		
		return f.grade.select();
	}
	*/
	
	if(!(f.grade.value == "A" 
	|| f.grade.value == "B"
	|| f.grade.value == "C") ){
			alert("회원등급이 잘못 입력되었습니다.");		
			return f.grade.select();
	}
	
	if(f.city.value == ""){
		alert("도시코드가 입력되지 않았습니다.");		
		return f.city.focus();
	}	
	
	f.submit();
}
</script>

<body>
<!-- header.jsp에서 "dbcon.jsp" include한 것 없애기, footer.jsp에서도 "DB연결 해제" 없애기 -->
	<%@ include file="header.jsp"%> 
	
	<%@ page import="member.*" %>
	
	<%
	ShoppingDAO dao = new ShoppingDAO();//기본생성자
	MemberBeans beans = dao.getMaxCustnoJoindate();
	%>
	<section>
		<div>
			<h2>쇼핑몰 회원 등록</h2>
		</div>
		<form action="insertPro.jsp" name="f" method="post">
			<table style="margin:0 auto" border="1" width="600">
				<tr>
					<th>회원번호(자동발생)</th>
					<td>
					<%--  <%='변수' 또는 '리턴값이 있는 메서드' 또는 '수식(변수 또는 리턴값이 있는 메서드를 포함할 수 있음)' %> --%>
						<input type="text" name="custno" value="<%=beans.getCustno()%>" size="10" maxlength="6" readonly>
					</td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td>
						<input type="text" name="custname" value="" size="10" maxlength="20">
					</td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td>
						<input type="text" name="phone" value="" size="20" maxlength="13">
					</td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td>
						<input type="text" name="address" value="" size="30" maxlength="60">
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						<input type="text" name="joindate" value="<%=beans.getJoindate()%>" size="10" maxlength="" readonly>
					</td>
				</tr>
				<tr>
					<th>고객등급[A:VIP, B:일반, C:직원]</th>
					<td>
						<input type="text" name="grade" value="" size="10" maxlength="1">
					</td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td>
						<input type="text" name="city" value="" size="10" maxlength="2">
					</td>
				</tr>
				<tr>
					<th colspan="2">					
						<input type="submit" value="등록" onclick="check(); return false;">
						<input type="button" value="조회" onclick="location.href='select.jsp'">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








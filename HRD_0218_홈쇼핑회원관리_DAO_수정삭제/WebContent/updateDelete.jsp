<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈쇼핑 회원관리</title>
</head>

<script type="text/javascript">
function checkUpdate(){
	if(f.custno.value == ""){
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
	//f.action = "updatePro.jsp";//수정과 삭제 따로 처리하기 위한 방법
	f.pro.value="수정";//수정과 삭제 함께 처리하기 위한 방법-2
	f.submit();
}

function checkDelete(){
	if(f.custno.value == ""){
		alert("회원번호가 입력되지 않았습니다.");		
		return f.custno.focus();
	}
	
	if(confirm("회원을 정말 삭제하시겠습니까?")){
		//f.action = "deletePro.jsp";//수정과 삭제 따로 처리하기 위한 방법
		f.pro.value="삭제";//수정과 삭제 함께 처리하기 위한 방법-2
		f.submit();
	}else return;
	
}
</script>

<body>
	<%@ include file="header.jsp"%>
	
	<%@ page import="member.*" %>
	
	<%
	String custno = request.getParameter("custno");//"100001"
	
	ShoppingDAO dao = new ShoppingDAO();
	//custno회원번호에 대한 회원정보를 MemberBeans객체로 얻어와
	MemberBeans beans = dao.getMember(custno);
	//아래코드처럼 화면에 뿌림	
	%>
	
	<section>
		<div>
			<h2>쇼핑몰 회원 정보 수정</h2>
		</div>
		<!-- 수정과 삭제 따로 처리하기 위한 방법-->
		<!-- <form action="" name="f" method="post"> -->
		
		<!-- <form action="updateDeletePro_if.jsp" name="f" method="post">  -->
		<form action="updateDeletePro_switch.jsp" name="f" method="post">
		
		<!-- 수정과 삭제 함께 처리하기 위한 방법-2 -->
		<input type="hidden" name="pro" value="">
			<table style="margin:0 auto" border="1" width="600">
				<tr>
					<th>회원번호</th>
					<td>
					    <%--  <%='변수' 또는 '리턴값이 있는 메서드' 또는 '수식(변수 또는 리턴값이 있는 메서드를 포함할 수 있음)' %> --%>
						<input type="text" name="custno" value="<%=beans.getCustno()%>" size="10" maxlength="6" readonly>
					</td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td>
						<input type="text" name="custname" value="<%=beans.getCustname()%>" size="10" maxlength="20">
					</td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td>
						<input type="text" name="phone" value="<%=beans.getPhone()%>" size="20" maxlength="13">
					</td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td>
						<input type="text" name="address" value="<%=beans.getAddress()%>" size="30" maxlength="60">
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						<input type="text" name="joindate" value="<%=beans.getJoindate()%>" size="10" maxlength="">
					</td>
				</tr>
				<tr>
					<th>고객등급[A:VIP, B:일반, C:직원]</th>
					<td>
						<input type="text" name="grade" value="<%=beans.getGrade()%>" size="10" maxlength="1">
					</td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td>
						<input type="text" name="city" value="<%=beans.getCity()%>" size="10" maxlength="2">
					</td>
				</tr>
				<tr>
					<th colspan="2">	
					<!-- 수정과 삭제 함께 처리하기 위한 방법-1 : name-->				
						<input type="submit" name="submit" value="수정" onclick="checkUpdate(); return false;">
						<input type="submit" name="submit" value="삭제" onclick="checkDelete(); return false;">
						<input type="button" value="조회" onclick="location.href='select.jsp'">
						<input type="reset" value="다시쓰기" >
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>








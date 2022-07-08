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
	f.action = "updatePro.jsp";
	f.submit();
}

function checkDelete(){
	if(f.custno.value == ""){
		alert("회원번호가 입력되지 않았습니다.");		
		return f.custno.focus();
	}
	
	if(confirm("회원을 정말 삭제하시겠습니까?")){
		f.action = "deletePro.jsp";
		f.submit();
	}else return;
	
}
</script>

<body>
	<%@ include file="header.jsp"%>
	
	<%
	String custno = request.getParameter("custno");//"100007"
	
	sql += "select custno,custname,phone,address,";
	sql += " to_char(joindate,'yyyy-mm-dd') as joindate,";
	sql += " grade, city";
	sql += " from member_tbl_02";
	//sql += " where custno='"+custno+"'";//[방법-1] Statment
	sql += " where custno=?";//[방법-2]
	
	//rs = stmt.executeQuery(sql);//[방법-1]
			
	ps = con.prepareStatement(sql);//[방법-2] PreparedStatement
	ps.setString(1, custno);
	rs = ps.executeQuery();
	
	rs.next();//"100007"에 정보 조회
	
	//String custno = rs.getString(1);
	String custname = rs.getString("custname");
	String phone = rs.getString("phone");
	String address = rs.getString("address");
	String joindate = rs.getString("joindate");
	String grade = rs.getString("grade");
	String city = rs.getString("city");	
	%>
	
	<section>
		<div>
			<h2>쇼핑몰 회원 정보 수정</h2>
		</div>
		<form action="" name="f" method="post">
			<table style="margin:0 auto" border="1" width="600">
				<tr>
					<th>회원번호</th>
					<td>
					    <%--  <%='변수' 또는 '리턴값이 있는 메서드' 또는 '수식(변수 또는 리턴값이 있는 메서드를 포함할 수 있음)' %> --%>
						<input type="text" name="custno" value="<%=custno%>" size="10" maxlength="6" readonly>
					</td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td>
						<input type="text" name="custname" value="<%=custname%>" size="10" maxlength="20">
					</td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td>
						<input type="text" name="phone" value="<%=phone%>" size="20" maxlength="13">
					</td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td>
						<input type="text" name="address" value="<%=address%>" size="30" maxlength="60">
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						<input type="text" name="joindate" value="<%=joindate%>" size="10" maxlength="">
					</td>
				</tr>
				<tr>
					<th>고객등급[A:VIP, B:일반, C:직원]</th>
					<td>
						<input type="text" name="grade" value="<%=grade%>" size="10" maxlength="1">
					</td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td>
						<input type="text" name="city" value="<%=city%>" size="10" maxlength="2">
					</td>
				</tr>
				<tr>
					<th colspan="2">					
						<input type="submit" value="수정" onclick="checkUpdate(); return false;">
						<input type="submit" value="삭제" onclick="checkDelete(); return false;">
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








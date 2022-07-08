<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화관 회원&예매 관리 프로그램</title>
</head>

<script type="text/javascript">
function check() {
	if(f.me_id.value==""){
		alert("회원아이디를 입력해주세요.");
		return f.me_id.focus();		
	}
	if(f.me_pass.value==""){
		alert("회원비밀번호를 입력해주세요.");
		return f.me_pass.focus();		
	}
	if(f.me_name.value==""){
		alert("회원이름를 입력해주세요.");
		return f.me_name.focus();		
	}
	if(f.gender[0].checked==false 
	&& f.gender[1].checked==false){
		alert("성별을 입력해주세요.");
		return;		
	}
	if(f.birth.value==""){
		alert("생년월일을 입력해주세요.");
		return f.birth.focus();		
	}
	if(f.address.value==""){
		alert("주소를 입력해주세요.");
		return f.address.focus();		
	}
	if(f.tel.value==""){
		alert("전화번호를 입력해주세요.");
		return f.tel.focus();		
	}
	f.submit();//주의
}

function rewrite(){
	f.reset();
	f.me_id.focos();
}
</script>

<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>회원등록</h2>
		</div>
		<form action="insertPro.jsp" method="post" name="f">
			<table border="1" width="500" style="margin:0 auto">
				<tr>
					<th>회원 아이디</th>
					<td>
						<input type="text" name="me_id" value="" size="10" maxlength="12">
					</td>
				</tr>
				<tr>
					<th>회원비밀번호</th>
					<td>
						<input type="password" name="me_pass" value="" size="11" maxlength="15">
					</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td>
						<input type="text" name="me_name" value="" size="10" maxlength="20">
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="M">남자</label>
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="F">여자</label>
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
						<input type="text" name="birth" value="" size="10" maxlength="">(예)1999-10-10
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="address" value="" size="40" maxlength="100">
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel" value="" size="20" maxlength="13">(예)010-1234-5678
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="회원등록" onclick="check(); return false">
						<input type="button" value="다시쓰기" onclick="rewrite()">
					</th>
				</tr>
			
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
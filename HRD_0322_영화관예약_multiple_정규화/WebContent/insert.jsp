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
	//아이디와 패스워드 값 데이터 정규화 공식
	const regIDPass = /^[a-zA-Z0-9]{3,12}$/;  //반드시 슬러쉬(/)로 시작
	
	//이름 정규화 공식
	const regName = /^[가-힝a-zA-Z]{2,}$/;
	
	//전화번호 정규화 공식
	const regTel = /^\d{3}-\d{3,4}-\d{4}$/;
	
	//회원 아이디 유효성 검사 - 정규식 공식 이용	
	if(!f.me_id.value){//if(f.me_id.value==""){
		alert("회원아이디를 입력해주세요.");
		return f.me_id.focus();		
	}/** 입력한 데이터를 검사하는 test() : 입력한 값이 정규화 데이터를 사용했다면 true를 반환 */
	else if( !regIDPass.test(f.me_id.value) ){
		alert("아이디는 3~12자의 영어 대소문자와 숫자로만 입력 가능합니다.");
		return f.me_id.select();//블럭 설정		
	}
	
	
	//회원 비밀번호 유효성 검사 - 정규식 공식 이용
	if(f.me_pass.value==""){
		alert("회원비밀번호를 입력해주세요.");
		return f.me_pass.focus();		
	}else if( !regIDPass.test(f.me_pass.value) ){
		alert("비밀번호는 3~12자의 영어 대소문자와 숫자로만 입력 가능합니다.");
		return f.me_pass.select();//블럭 설정		
	}
	
	//회원 이름 유효성 검사 - 정규식 공식 이용
	if(f.me_name.value==""){
		alert("회원이름를 입력해주세요.");
		return f.me_name.focus();		
	}else if( !regName.test(f.me_name.value) ){//이름에 특수문자가 들어간 경우
		alert("이름이 잘못 입력되었습니다.");
		return f.me_name.select();//블럭 설정		
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
	
	//전화번호 유효성 체크 - 정규식 공식 이용
	if(f.tel.value==""){
		alert("전화번호를 입력해주세요.");
		return f.tel.focus();		
	}else if( !regTel.test(f.tel.value)){
		alert("전화번호가 잘못 입력되었습니다.");
		return f.tel.select();
	}
	
	f.submit();//주의
}

function rewrite(){
	if(confirm("다시 쓰시겠습니까?")) {
		f.reset();
		f.me_id.focus();
	}
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
						<input type="text" name="me_id" value="" size="20" maxlength="12">
					</td>
				</tr>
				<tr>
					<th>회원비밀번호</th>
					<td>
						<input type="password" name="me_pass" value="" size="20" maxlength="15">
					</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td>
						<input type="text" name="me_name" value="" size="20" maxlength="20">
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
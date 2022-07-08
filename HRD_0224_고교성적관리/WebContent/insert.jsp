<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고교성적관리</title>
</head>
<script>
	function check(){
		if(f.syear.value==""){
			alert("학년을 입력해주세요.");
			return f.syear.focus();
		}
		if(f.sclass.value==""){
			alert("반을 입력해주세요.");
			return f.sclass.focus();
		}
		if(f.sno.value==""){
			alert("번호를 입력해주세요.");
			return f.sno.focus();
		}
		if(f.sname.value==""){
			alert("이름을 입력해주세요.");
			return f.sname.focus();
		}
		if(f.birth.value==""){
			alert("생년월일을 입력해주세요.");
			return f.birth.focus();
		}
		if(f.gender[0].checked==false && f.gender[1].checked==false){
			alert("성별을 선택해주세요.");
			return;
		}
		if(f.tel1.value==""){
			alert("전화번호를 입력해주세요.");
			return f.syear.focus();
		}
		if(f.tel2.value==""){
			alert("전화번호를 입력해주세요.");
			return f.tel2.focus();
		}
		if(f.tel3.value==""){
			alert("전화번호를 입력해주세요.");
			return f.tel3.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp" %>
	<section>
		<div>
			<h2>학생등록</h2>
		</div>
		<form method="post" action="insertPro.jsp" name="f">
			<table style="margin: 0 auto;" width="400" border="1">
				<tr>
					<th>학년</th>
					<td><input type="text" name="syear" size="10" maxlength="1">(예)1</td>
				</tr>
				<tr>
					<th>반</th>
					<td><input type="text" name="sclass" size="10" maxlength="2">(예)01</td>
				</tr>
				<tr>
					<th>번호</th>
					<td><input type="text" name="sno" size="10" maxlength="2">(예)01</td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="sname" size="15" maxlength="20"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="birth" size="15" maxlength="8">(예)20191011</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						&nbsp;&nbsp;<input type="radio" name="gender" value="M">남자
						&nbsp;&nbsp;<input type="radio" name="gender" value="F">여자
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel1" size="5" maxlength="3">-
						<input type="text" name="tel2" size="5" maxlength="4">-
						<input type="text" name="tel3" size="5" maxlength="4">
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="학생등록" onclick="check(); return false">
						<input type="reset" value="다시쓰기">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
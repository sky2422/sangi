<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
</head>
<script type="text/javascript">
	function check(){
		if(!f.STUDENT_NAME.value){
			alert("이름을 입력해 주세요");			
			return f.STUDENT_NAME.focus();
		}
		if(!f.STUDENT_PHONE.value){
			alert("연락처를 입력해 주세요");			
			return f.STUDENT_PHONE.focus();
		}
		if(!f.STUDENT_BIRTH.value){
			alert("생년월일을 입력해 주세요");			
			return f.STUDENT_BIRTH.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	
	<section>
		<div>
			<h2>수강생 등록</h2>
		</div>
		<form action="insertPro.jsp" method="post" name="f">
			<table border="1" width="600" style="margin: 0 auto;">
			    <tr hidden="STUDENT_NO">
					<th>수강생번호</th>
					<td><input type="text" name="STUDENT_NO" value=""></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="STUDENT_NAME" maxlength="20"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="STUDENT_ADDR" size="50" maxlength="100"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="STUDENT_PHONE" maxlength="14">(예)01023456789</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="STUDENT_BIRTH">(예)2001-06-27</td>
				</tr>
				<tr>
					<th>메일주소</th>
					<td>
						<input type="text" name="STUDENT_EMAIL1">
						@
						<select name="STUDENT_EMAIL2">
							<option value="naver.com">naver.com</option>
							<option value="chol.net">chol.net</option>
							<option value="gmail.com">gmail.com</option>
						</select>					
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="STUDENT_ID" maxlength="12"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="STUDENT_PW" size="21" maxlength="50"></td>
				</tr>
			</table>
			<center>
				<input type="submit" value="등록" onclick="check(); return false">
				<input type="button" value="조회" onclick="location.href='select.jsp'">
			</center>
		</form>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
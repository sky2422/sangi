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
		if(f.kor.value==""){
			alert("국어를 입력해주세요.");
			return f.kor.focus();
		}
		if(f.eng.value==""){
			alert("영어를 입력해주세요.");
			return f.eng.focus();
		}
		if(f.math.value==""){
			alert("수학을 입력해주세요.");
			return f.math.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp" %>
	<section>
		<div>
			<h2>성적등록</h2>
		</div>
		<form method="post" action="insert2Pro.jsp" name="f">
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
					<th>국어</th>
					<td><input type="text" name="kor" size="10" maxlength="3">성적범위(0~100)</td>
				</tr>
				<tr>
					<th>영어</th>
					<td><input type="text" name="eng" size="10" maxlength="3">성적범위(0~100)</td>
				</tr>
				<tr>
					<th>수학</th>
					<td><input type="text" name="math" size="10" maxlength="3">성적범위(0~100)</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="성적등록" onclick="check(); return false">
						<input type="button" value="조회" onclick="location='select.jsp'">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
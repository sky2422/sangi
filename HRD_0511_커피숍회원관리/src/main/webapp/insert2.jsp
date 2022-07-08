<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커피숍 회원관리 프로그램</title>
</head>
<script type="text/javascript">
	function check() {
		if (f.PCODE.value == "") {
			alert("상품코드가 입력되지 않았습니다.");
			return f.PCODE.focus();
		}
		if (f.PNAME.value == "") {
			alert("상품명이 입력되지 않았습니다.");
			return f.PNAME.focus();
		}		
		if (f.PCOST.value == "") {
			alert("상품단가가 입력되지 않았습니다.");
			return f.PCOST.focus();
		}
		f.submit();
	}
	
	function rewirite() {
		let x = confirm("모든 항목의 정보를 지우시겠습니까? 지우면 다시 입력해주세요.");
		if (x == true) {
			f.reset();
			f.PCODE.focus();
		}
	}
</script>
<body>
	<%@ include file="header.jsp"%>	
	<section>
		<div>
			<h2>커피등록</h2>
		</div>
		<form action="insert2Pro.jsp" method="post" name="f">
			<table border="1" width="700" style="margin: 0 auto;">
				<tr>
					<th bgcolor="yellow">상품코드</th>
					<td>
						<input type="text" name="PCODE" value="" size="30" maxlength="4">4글자 내로 입력하세요. ex)A101
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">상품명</th>
					<td>
						<input type="text" name="PNAME" value="" size="30">
					</td>
				</tr>				
				<tr>
					<th style="background-color: yellow;">상품단가</th>
					<td>
						<input type="text" name="PCOST" value="" size="30">가격만 입력하시오.ex)6000
					</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" value="등록" onclick="check();return false;">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="다시쓰기" onclick="rewirite();">
			</center>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
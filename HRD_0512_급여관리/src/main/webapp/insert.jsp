<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원등록</title>
</head>
<script type="text/javascript">
	function check() {
		if (f.EMPLOYEE_NO.value == "") {
			alert("사원번호가 입력되지 않았습니다.");
			return f.EMPLOYEE_NO.focus();
		}
		if (f.EMPLOYEE_NAME.value == "") {
			alert("사원명이 입력되지 않았습니다.");
			return f.EMPLOYEE_NAME.focus();
		}
		if (f.DEPT_NO.value == "") {
			alert("부서번호가 입력되지 않았습니다.");
			return f.DEPT_NO.focus();
		}
		if (f.HIRE_DATE.value == "") {
			alert("입사일자가 입력되지 않았습니다.");
			return f.HIRE_DATE.focus();
		}
		if (f.EMPLOYEE_STATUS[0].selected == false
		&& f.EMPLOYEE_STATUS[1].selected == false
		&& f.EMPLOYEE_STATUS[2].selected == false) {
			alert("사원상태가 선택되지 않았습니다.");
			return;
		}
		f.submit();
	}
</script>
<body>
	<%@include file="header.jsp"%>
	<%
		sql = "select nvl(max(EMPLOYEE_NO),0)+1 as EMPLOYEE_NO from EMPLOYEE_TBL_13";
		rs = stmt.executeQuery(sql);
		rs.next();
		String EMPLOYEE_NO = rs.getString("EMPLOYEE_NO");
	%>
	<section>
		<div>
			<h3>사원등록</h3>
		</div>
		<form action="insertPro.jsp" method="post" name="f">
			<table border="1" width="500" style="margin: 0 auto;">
				<tr>
					<th style="background-color: yellow;">사원번호</th>
					<td>
						<input type="text" name="EMPLOYEE_NO" value="<%=EMPLOYEE_NO%>"
							size="20" maxlehgth="">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">사원명</th>
					<td>
						<input type="text" name="EMPLOYEE_NAME" value="" size="20" maxlehgth="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">부서번호</th>
					<td>
						<input type="text" name="DEPT_NO" value="" size="20" maxlehgth="2">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">입사일자</th>
					<td>
						<input type="text" name="HIRE_DATE" value="" size="20" maxlehgth="">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">사원상태</th>
					<td>
						<select name="EMPLOYEE_STATUS">
							<option value="1">입사</option>
							<option value="2">퇴사</option>
							<option value="3">휴직</option>
						</select>
					</td>
				</tr>
			</table>
			<center>
				<input type="submit" value="등록" onclick="check(); return false;">
				<input type="button" value="조회" onclick="location='select.jsp'">
			</center>
		</form>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
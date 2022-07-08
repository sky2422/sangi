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
		if (f.CUSTNO.value == "") {
			alert("회원번호가 입력되지 않았습니다.");
			return f.CUSTNO.focus();
		}
		if (f.CUSTNAME.value == "") {
			alert("회원성명이 입력되지 않았습니다.");
			return f.CUSTNAME.focus();
		}
		if (f.GENDER[0].checked == false 
		 && f.GENDER[1].checked == false) {
			alert("성별이 선택되지 않았습니다.");
			return;
		}
		if (f.PHONE.value == "") {
			alert("회원전화가 입력되지 않았습니다.");
			return f.PHONE.focus();
		}
		if (f.ADDRESS.value == "") {
			alert("주소가 입력되지 않았습니다.");
			return f.ADDRESS.focus();
		}
		if (f.JOINDATE.value == "") {
			alert("가입일자가 입력되지 않았습니다.");
			return f.JOINDATE.focus();
		}
		if (f.GRADE.value == "") {
			alert("고객등급이 입력되지 않았습니다.");
			return f.GRADE.focus();
		}
		if (f.CITY.value == "") {
			alert("거주도시가 입력되지 않았습니다.");
			return f.CITY.focus();
		}
		f.submit();
	}
	
	function rewirite() {
		let x = confirm("모든 항목의 정보를 지우시겠습니까? 지우면 다시 입력해주세요.");
		if (x == true) {
			f.reset();
			f.CUSTNAME.focus();
		}
	}
</script>
<body>
	<%@ include file="header.jsp"%>
	<%
		sql = "select CUSTNO,CUSTNAME,GENDER,PHONE,ADDRESS,";
		sql += " to_char(JOINDATE, 'yyyy-mm-dd') as JOINDATE,";
		sql += " GRADE,CITY";
		sql += " from member_tbl";
		sql += " where CUSTNO=?";

		ps = con.prepareStatement(sql);
		//ps.setInt(1, Integer.parseInt(request.getParameter("CUSTNO")));
		ps.setString(1, request.getParameter("CUSTNO"));
		rs = ps.executeQuery();
		
		rs.next();	
	%>
	<section>
		<div>
			<h2>회원수정</h2>
		</div>
		<form action="updatePro.jsp" method="post" name="f">
			<table border="1" width="700" style="margin: 0 auto;">
				<tr>
					<th bgcolor="yellow">회원번호</th>
					<td>
						<input type="text" name="CUSTNO" value="<%=rs.getString(1)%>" size="30" readonly>
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">회원성명</th>
					<td>
						<input type="text" name="CUSTNAME" value="<%=rs.getString(2)%>" size="30">
					</td>
				</tr>
				<tr>
					<th bgcolor="yellow">성별</th>
					<td>
						&nbsp;
						<label>
							<input type="radio" name="GENDER" value="F" <%=rs.getString(3)!=null && rs.getString(3).equalsIgnoreCase("F")?"checked":""%>>여
						</label>
						&nbsp;
						<label>
							<input type="radio" name="GENDER" value="M" <%if(rs.getString(3)!=null && rs.getString(3).equalsIgnoreCase("F")){out.print("checked");} %>>남
						</label>
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">회원전화</th>
					<td>
						<input type="text" name="PHONE" value="<%=rs.getString(4)%>" size="30">
					</td>
				</tr>
				<tr>
					<th bgcolor="yellow">주소</th>
					<td>
						<input type="text" name="ADDRESS" value="<%=rs.getString(5)%>" size="30">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">가입일자</th>
					<td>
						<input type="text" name="JOINDATE" value="<%=rs.getString(6)%>" size="30" readonly>
					</td>
				</tr>
				<tr>
					<th bgcolor="yellow">고객등급[A:VIP, B:일반 , C:직원]</th>
					<td>
						<input type="text" name="GRADE" value="<%=rs.getString(7)%>" size="30" maxlength="1">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">거주도시</th>
					<td>
						<input type="text" name="CITY" value="<%=rs.getString(8)%>" size="30" maxlength="2">숫자 두자리 입력 ex).20
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
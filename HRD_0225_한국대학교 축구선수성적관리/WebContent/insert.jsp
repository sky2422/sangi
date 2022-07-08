<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 등록</title>
</head>
<script type="text/javascript">
	function check() {
		if (f.PLAYER_NO.value == "") {
			alert("선수번호가 입력되지 않았습니다.");
			return f.PLAYER_NO.focus();
		}
		if (f.PLAYER_NAME.value == "") {
			alert("이름이 입력되지 않았습니다.");
			return f.PLAYER_NAME.focus();
		}
		if (f.TEAM_NO.value == "") {
			alert("소속팀 번호가 입력되지 않았습니다.");
			return f.TEAM_NO.focus();
		}
		if (f.PLAYER_PHONE.value == "") {
			alert("연락처가 입력되지 않았습니다.");
			return f.PLAYER_PHONE.focus();
		}
		if (f.PLAYER_BIRTH.value == "") {
			alert("생년월일이 입력되지 않았습니다.");
			return f.PLAYER_BIRTH.focus();
		}
		/*
		if (f.PLAYER_EMAIL[0].selected == false
		 && f.PLAYER_EMAIL[1].selected == false
		 && f.PLAYER_EMAIL[2].selected == false)
		{
			alert("메일주소가 입력되지 않았습니다.");
			return;
		}
		*/
		if (f.BACK_NO.value == "") {
			alert("등번호가 입력되지 않았습니다.");
			return f.BACK_NO.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp"%>
	<%
		sql = "select nvl(max(PLAYER_NO),10000)+1 as PLAYER_NO from PLAYER_TBL";
		rs = stmt.executeQuery(sql);
		rs.next();
		String PLAYER_NO = rs.getString("PLAYER_NO");
	%>
	<section>
		<div>
			<h2>선수 정보 등록</h2>
		</div>
		<form action="insertPro.jsp" method="post" name="f">
			<table border="1" width="500" style="margin: 0 auto;">
				<tr>
					<th style="background-color: yellow;">선수번호</th>
					<td>
						<input type="text" name="PLAYER_NO" value="<%=PLAYER_NO%>" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">이름</th>
					<td>
						<input type="text" name="PLAYER_NAME" value="" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">소속팀 번호</th>
					<td>
						<input type="text" name="TEAM_NO" value="" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">연락처</th>
					<td>
						<input type="text" name="PLAYER_PHONE" value="" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">생년월일</th>
					<td>
						<input type="text" name="PLAYER_BIRTH" value="" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">메일주소</th>
					<td>
						<input type="text" name="PLAYER_EMAIL1">
						@
						<select name="PLAYER_EMAIL2">
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="gmail.com">gmail.com</option>
						</select>		
					</td>	
				</tr>
				<tr>
					<th style="background-color: yellow;">등번호</th>
					<td>
						<input type="text" name="BACK_NO" value="" size="20">
					</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" value="등록" onclick="check(); return false;">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="조회" onclick="location='select.jsp'">
			</center>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
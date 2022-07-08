<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선수 조회/수정</title>
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
	
	function rewrite(){		
		let x=confirm("다시쓰기를 하시겠습니까");
		//if(confirm("다시쓰기를 하시겠습니까")){
		if(x){
			f.reset();
			return f.PLAYER_NAME.select();
		}else return;
	}
</script>
<body>
	<%@ include file="header.jsp"%>
	<%  String PLAYER_NO = request.getParameter("PLAYER_NO");
		
		sql += "select PLAYER_NO,PLAYER_NAME,TEAM_NO, PLAYER_PHONE,";
		sql += " to_char(PLAYER_BIRTH,'yyyy-mm-dd') as PLAYER_BIRTH, ";
		
		//[방법-1] : NVL사용 - null일 때 ' '
		sql += " NVL(substr(PLAYER_EMAIL,1,INSTR(PLAYER_EMAIL,'@',1)-1),' ') AS PLAYER_EMAIL1, ";
		
		//[방법-2] : NVL사용 - null일 때 '' (※''은 null임)		
		//sql += " NVL(substr(PLAYER_EMAIL,1,INSTR(PLAYER_EMAIL,'@',1)-1),'') AS PLAYER_EMAIL1, ";
		
		//[방법-3] : NVL사용안함 (null일 때 ''로 처리하면 NVL 함수 사용하나 안하나 같은 결과)
		//sql += " substr(PLAYER_EMAIL,1,INSTR(PLAYER_EMAIL,'@',1)-1) AS PLAYER_EMAIL1,";
		
		sql += " NVL(substr(PLAYER_EMAIL,INSTR(PLAYER_EMAIL,'@',1)+1),'naver.com') AS PLAYER_EMAIL2,";
		sql += " BACK_NO";
		sql += " from PLAYER_TBL";
		sql += " where PLAYER_NO='"+PLAYER_NO+"'";
	
		rs = stmt.executeQuery(sql);
		rs.next();
		
		String PLAYER_NAME = rs.getString("PLAYER_NAME");
		String TEAM_NO = rs.getString("TEAM_NO");
		String PLAYER_PHONE = rs.getString("PLAYER_PHONE");
		String PLAYER_BIRTH = rs.getString("PLAYER_BIRTH");
		String PLAYER_EMAIL1 = rs.getString("PLAYER_EMAIL1");
		String PLAYER_EMAIL2 = rs.getString("PLAYER_EMAIL2");
		String BACK_NO = rs.getString("BACK_NO");
	%>
	<section>
		<div>
			<h2>선수 정보 조회/수정</h2>
		</div>
		<form action="updatePro.jsp" method="post" name="f">
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
						<input type="text" name="PLAYER_NAME" value="<%=PLAYER_NAME%>" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">소속팀 번호</th>
					<td>
						<input type="text" name="TEAM_NO" value="<%=TEAM_NO%>" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">연락처</th>
					<td>
						<input type="text" name="PLAYER_PHONE" value="<%=PLAYER_PHONE%>" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">생년월일</th>
					<td>
						<input type="text" name="PLAYER_BIRTH" value="<%=PLAYER_BIRTH%>" size="20">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">메일주소</th>
					<td>
						<!-- [방법-1] -->
						<input type="text" name="PLAYER_EMAIL1" value="<%=PLAYER_EMAIL1.trim()%>">
						<%-- <input type="text" name="PLAYER_EMAIL1" value="<%=PLAYER_EMAIL1.equals(" ")?"":PLAYER_EMAIL1%>">  --%>
																		
						<!-- [방법-2]와 [방법-3] -->
						<%-- <input type="text" name="PLAYER_EMAIL1" value="<%=PLAYER_EMAIL1==null?"":PLAYER_EMAIL1%>"> --%>
						@
						<select name="PLAYER_EMAIL2">
							<option value="naver.com" <%if(PLAYER_EMAIL2.equals("naver.com")) {out.print("selected");}%>>naver.com</option>
							<option value="daum.net"  <%=PLAYER_EMAIL2.equals("chol.net")?"selected":""%>>daum.net</option>
							<option value="gmail.com" <%if(PLAYER_EMAIL2.equals("gmail.com")) {out.print("selected='selected'");}%>>gmail.com</option>
						</select>		
					</td>	
				</tr>
				<tr>
					<th style="background-color: yellow;">등번호</th>
					<td>
						<input type="text" name="BACK_NO" value="<%=BACK_NO%>" size="20">
					</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" value="수정" onclick="check(); return false;">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="다시쓰기" onclick="rewrite(); return false;">
			</center>
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
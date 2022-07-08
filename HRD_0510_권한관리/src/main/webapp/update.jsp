<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권한관리 프로그램</title>
</head>
<script type="text/javascript">
	function check() {
		if (f.USER_NO.value == "") {
			alert("사용자번호가 입력되지 않았습니다.");
			return f.USER_NO.focus();
		}
		if (f.USER_NAME.value == "") {
			alert("사용자명이 입력되지 않았습니다.");
			return f.USER_NAME.focus();
		}
		if (f.USER_PW.value == "") {
			alert("암호가 입력되지 않았습니다.");
			return f.USER_PW.focus();
		}
		
		//암호확인 유효성 체크
		if (!f.USER_PW2.value) {
			alert("암호확인이 입력되지 않았습니다.");
			return f.USER_PW2.focus();			
		}else if (f.USER_PW2.value != f.USER_PW.value) {//암호확인과 암호가 같지 않으면
			alert("암호확인이 정확히 입력되지 않았습니다.");
			//return f.USER_PW2.select();
			f.USER_PW2.value = "";
			return f.USER_PW2.focus();
		}
		
		if (f.DEPT_NO.value == "") {
			alert("소속부서번호가 입력되지 않았습니다.");
			return f.DEPT_NO.focus();
		}
		if (f.USER_GBN.value == "") {
			alert("사용자구분이 입력되지 않았습니다.");
			return f.USER_GBN.focus();
		}
		if (f.REG_DATE.value == "") {
			alert("등록일자가 입력되지 않았습니다.");
			return f.REG_DATE.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp"%>
	<%
	//String USER_NO=request.getParameter("USER_NO");
	
	sql += "select USER_NO, USER_NAME, USER_PW, DEPT_NO, USER_GBN,";
	sql += " to_char(REG_DATE,'yyyy/mm//dd') as REG_DATE";
	sql += " from USER_TBL_08";
	sql += " where USER_NO = ?";
	
	ps=con.prepareStatement(sql);
	ps.setString(1, request.getParameter("USER_NO"));
	
	rs=ps.executeQuery();
	rs.next();
	
	String USER_NO = rs.getString(1);
	String USER_NAME = rs.getString(2);
	String USER_PW = rs.getString(3);
	String DEPT_NO = rs.getString(4);
	String USER_GBN = rs.getString(5);
	String REG_DATE = rs.getString(6);
	%>
	<section>
		<div>
			<h3>사용자 수정</h3>
		</div>
		<form action="updatePro.jsp" method="post" name="f">
			<table border="1" width="500" style="margin: 0 auto;">
				<tr>
					<th style="background-color: yellow;">사용자 번호</th>
					<td>
						<input type="text" name="USER_NO" value="<%=USER_NO%>" size="20" maxlength="5">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">사용자명</th>
					<td>
						<input type="text" name="USER_NAME" value="<%=USER_NAME%>" size="20" maxlength="50">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">암호</th>
					<td>
						<input type="text" name="USER_PW" value="<%=USER_PW%>" size="21" maxlength="50">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">암호확인</th>
					<td>
						<input type="text" name="USER_PW2" value="<%=USER_PW%>" size="21" maxlength="50">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">소속부서번호</th>
					<td>
						<input type="text" name="DEPT_NO" value="<%=DEPT_NO%>" size="20" maxlength="3">
					</td>
				</tr>				
				<tr>
					<th style="background-color: yellow;">사용자 구분</th>
					<td>
						<input type="text" name="USER_GBN" value="<%=USER_GBN%>" size="20" maxlength="2">
					</td>
				</tr>
				<tr>
					<th style="background-color: yellow;">등록일자</th>
					<td>
						<input type="text" name="REG_DATE" value="<%=REG_DATE %>" size="20" maxlength="">
					</td>
				</tr>
			</table>
			<br>
			<center>
				<input type="submit" value="수정" onclick="check(); return false;">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="조회" onclick="location='select.jsp'">
			</center>
			
		</form>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
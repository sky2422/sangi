<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스클럽관리</title>
</head>
<script type="text/javascript">
	function check(){
		if(f.memno.value==""){
			alert("회원번호를 입력해주세요.");
			return f.memno.focus();
		}
		if(f.mname.value==""){
			alert("회원이름을 입력해주세요.");
			return f.mname.focus();
		}
		if(f.maddress.value==""){
			alert("회원주소를 입력해주세요.");
			return f.maddress.focus();
		}
		if(f.joindate.value==""){
			alert("등록일을 입력해주세요.");
			return f.joindate.focus();
		}
		if(f.gender[0].checked()==false
		&& f.gender[1].checked()==false){
			alert("회원성별을 선택해주세요.");
			return;
		}
		if(f.tel.value==""){
			alert("전화번호를 입력해주세요.");
			return f.tel.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp" %>
	<%
		sql="select nvl(max(memno),1000)+1 as memno, to_char(sysdate,'yy-mm-dd') as joindate from member_tbl";
		rs=stmt.executeQuery(sql);
		rs.next();
		String memno = rs.getString("memno");
		
		/*sql="select to_char(sysdate,'yy-mm-dd') joindate from dual";
		rs=stmt.executeQuery(sql);
		rs.next();*/
		String joindate = rs.getString("joindate");
	%>
	<section>
		<div>
			<h2>회원등록</h2>
		</div>
		<form method="post" action="insertPro.jsp" name="f">
			<table style="margin: 0 auto;" width="500" border="1">
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="memno" value="<%=memno %>" size="15" maxlength="4">(자동생성)</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td><input type="text" name="mname" size="25" maxlength="20"></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input type="text" name="maddress" size="25" maxlength="50"></td>
				</tr>
				<tr>
					<th>등록일</th>
					<td><input type="text" name="joindate" value="<%=joindate %>" size="25" readonly>(자동생성)</td>
				</tr>
				<tr>
					<th>회원성별</th>
					<td>
						&nbsp;&nbsp;<input type="radio" name="gender" value="M">남자
						&nbsp;&nbsp;<input type="radio" name="gender" value="F">여자
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" name="tel" size="25" maxlength="15">(예)010-0000-0000</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="회원등록" onclick="check(); return false">
						<input type="reset" value="다시쓰기">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
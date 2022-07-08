<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>친구관리 프로그램</title>
</head>
<script type="text/javascript">
function check() {
	
		//f.proALL.value = "insert";
		
		if (f.MEMBER_NO.value == "") {
			alert("회원번호를 입력해주세요.");
			return f.MEMBER_NO.focus();
		}
		if (f.MEMBER_ID.value == "") {
			alert("회원ID를 입력해주세요.");
			return f.MEMBER_ID.focus();
		}
		if (f.MEMBER_NAME.value == "") {
			alert("이름을 입력해주세요.");
			return f.MEMBER_NAME.focus();
		}
		if (f.MEMBER_GRADE[0].selected == false
				&& f.MEMBER_GRADE[1].selected == false
				&& f.MEMBER_GRADE[2].selected == false) {
			alert("등급을 입력해주세요.");
			return;
		}
		if (f.MEMBER_HOBBY[0].checked == false
				&& f.MEMBER_HOBBY[1].checked == false
				&& f.MEMBER_HOBBY[2].checked == false) {
			alert("취미를 입력해주세요.");
			return;
		}
		if (f.MEMBER_DATE.value == "") {
			alert("등록일자를 입력해주세요.");
			return f.MEMBER_DATE.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp"%> 
	<%
	sql="select nvl(max(MEMBER_NO),1000)+1 as MEMBER_NO, to_char(sysdate,'yyyy/mm/dd') as MEMBER_DATE from MEMBER_TBL_11";	
	rs=stmt.executeQuery(sql);
	/*
	String MEMBER_NO = "";
	if(rs.next()){
		MEMBER_NO = rs.getString("MEMBER_NO");
	}
	*/
	rs.next();
	String MEMBER_NO=rs.getString("MEMBER_NO");
	String MEMBER_DATE=rs.getString("MEMBER_DATE");
	
	%>
	
	<section>
		<div>
			<h2>친구 등록</h2>
		</div>
		<form action="proALL.jsp" method="post" name="f">
			<input type="hidden" name="proALL" value="insert"> <!-- [수정]이 함께 있으면 value값 생략 -->
			<table border="1" width="600" style="margin: 0 auto">
				<tr>
					<th>회원번호</th>
					<td>
						<input type="text" name="MEMBER_NO" value="<%=MEMBER_NO%>" size="20" readonly>(자동입력)
					</td>
				</tr>
				<tr>
					<th>회원ID</th>
					<td>
						<input type="text" name="MEMBER_ID" size="20">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="MEMBER_NAME" size="20">
					</td>
				</tr>
				<tr>
					<th>등급</th>
					<td>
						<select name="MEMBER_GRADE" size="4">
							<option value="S">특별회원</option>
							<option value="A">우수회원</option>
							<option value="B">일반회원</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>취미</th>
					<td>
						<label><input type="checkbox" name="MEMBER_HOBBY" value="독서">독서</label>
						<label><input type="checkbox" name="MEMBER_HOBBY" value="운동">운동</label>
						<label><input type="checkbox" name="MEMBER_HOBBY" value="영화">영화</label>
					</td>
				</tr>
				<tr>
					<th>등록일자</th>
					<td>
						<input type="text" name="MEMBER_DATE" value="<%=MEMBER_DATE%>" size="20" readonly>(자동입력)
					</td>
				</tr>
			</table>
		</form>
		<br>
		<center>
			<input type="submit" value="등록" onclick="check(); return false">&nbsp;&nbsp;&nbsp;
			<input type="button" value="조회" onclick="location.href='select.jsp'">
		</center>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
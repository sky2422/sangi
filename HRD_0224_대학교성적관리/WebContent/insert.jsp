<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 성적 관리</title>
</head>
<script type="text/javascript">
	function check(){
		if(f.studno.value == ''){
			alert("학번을 입력해주세요.");
			return f.studno.focus();
		}
		if(!f.syear.value){
			alert("학년을 입력해주세요.");
			return f.syear.focus();
		}
		if(!f.sname.value){
			alert("학생이름을 입력해주세요.");
			return f.sname.focus();
		}
		if(!f.address.value){
			alert("학생주소를 입력해주세요.");
			return f.address.focus();
		}
		if(f.gender[0].checked == false 
		&& f.gender[1].checked == false ){
			alert("학생성별을 입력해주세요.");
			return;
		}
		if(!f.tel.value){
			alert("전화번호를 입력해주세요.");
			return f.tel.focus();
		}
		if(!f.idnum.value){
			alert("주민번호를 입력해주세요.");
			return f.idnum.focus();
		}
		f.submit();
	}
	
	function rewrite(){
		f.reset();
		f.sname.focus();
	}

</script>

<body>
	<%@include file="header.jsp"%><!-- DB연결 -->
	<% 
	sql = "select NVL(max(studno),1000)+1 as studno from student_tbl";
	/*
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery();
	*/
	rs = stmt.executeQuery(sql);
	/*
	String studno = null;
	if(rs.next()){
		studno = rs.getString("studno");
	}
	*/
	rs.next();
	//String studno=rs.getString("studno");
	int studno = rs.getInt("studno");//해도 되나 String으로 빠르게 처리함
	
	sql = "select NVL(MIN(syear),01) as syear from student_tbl";
	rs = stmt.executeQuery(sql);
	rs.next();
	String syear = rs.getString("syear");
	%>
	
	<section>
		<div>
			<h2>학생등록</h2>
		</div>
		<form action="insertPro.jsp" method="post" name="f">
			<table border="1" width="600" style="margin: 0 auto;">
				<tr>
					<th>학번</th>
					<td><!-- type="number"로 해도 무방함 -->				
						<input type="text" name="studno" value="<%=studno%>" size="10">(자동생성)
					</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>
						<input type="text" name="syear" value="<%=syear%>"  size="10" maxlength="2" readonly>(자동입력)
					</td>
				</tr>
				<tr>
					<th>학생이름</th>
					<td>
						<input type="text" name="sname" value="" maxlength="20" size="20">
					</td>
				</tr>
				<tr>
					<th>학생주소</th>
					<td>
						<input type="text" name="address" value="" size="30" maxlength="100">
					</td>
				</tr>
				<tr>
					<th>학생성별</th>
					<td>
						&nbsp;&nbsp;
						<label><input type="radio" name="gender" value="M">남자</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="gender" value="F">여자</label>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel" value="" size="20" maxlength="30">
					</td>
				</tr>
				<tr>
					<th>주민번호</th>
					<td>
						<input type="text" name="idnum" value="" size="20" maxlength="14">(예)000000-0000000
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="학생등록" onclick="check(); return false;">
						&nbsp;&nbsp;
						<input type="button" value="다시쓰기" onclick="rewrite();">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
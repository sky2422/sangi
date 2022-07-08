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
		if(!f.m_subject1.value){
			alert("전공1을 입력해주세요.");
			return f.m_subject1.focus();
		}
		if(!f.m_subject2.value){
			alert("전공2을 입력해주세요.");
			return f.m_subject2.focus();
		}
		if(!f.m_subject3.value){
			alert("전공3을 입력해주세요.");
			return f.m_subject3.focus();
		}
		if(!f.s_subject1.value){
			alert("교양1을 입력해주세요.");
			return f.s_subject1.focus();
		}
		if(!f.s_subject2.value){
			alert("교양2을 입력해주세요.");
			return f.s_subject2.focus();
		}
		
		f.submit();
	}
</script>

<body>
	<%@include file="header.jsp"%><!-- DB연결 -->
		
	<section>
		<div>
			<h2>성적등록</h2>
		</div>
		<form action="insert2Pro.jsp" method="post" name="f">
			<table border="1" width="400" style="margin: 0 auto;">
				<tr>
					<th>학번</th>
					<td>
						<input type="text" name="studno" value="" size="10">
					</td>
				</tr>
				<tr>
					<th>학년</th>
					<td>
						<input type="text" name="syear" value=""  size="10" maxlength="2">
					</td>
				</tr>
				<tr>
					<th>전공1</th>
					<td>
						<input type="text" name="m_subject1" value="" maxlength="3" size="20">
					</td>
				</tr>
				<tr>
					<th>전공2</th>
					<td>
						<input type="text" name="m_subject2" value="" maxlength="3" size="20">
					</td>
				</tr>
				<tr>
					<th>전공3</th>
					<td>
						<input type="text" name="m_subject3" value="" maxlength="3" size="20">
					</td>
				</tr>
				<tr>
					<th>교양1</th>
					<td>
						<input type="text" name="s_subject1" value="" maxlength="3" size="20">
					</td>
				</tr>
				<tr>
					<th>교양2</th>
					<td>
						<input type="text" name="s_subject2" value="" maxlength="3" size="20">
					</td>
				</tr>
				
				<tr>
					<th colspan="2">
						<input type="submit" value="성적등록" onclick="check(); return false;">
						&nbsp;&nbsp;
						<input type="button" value="조회" onclick="location='select.jsp'">
						<!--<input type="button" value="조회" onclick="location.href='select.jsp'">-->
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>과정평가형 자격 CBQ</title>
</head>
<script type="text/javascript">
	function insertcheck(){
		f.pro.value="insert";
		
		if(f.w_workno.value==""){
			alert("작업지시번호가 입력되지 않았습니다.");
			return f.w_workno.focus();
		}
		if(f.p_p1[0].checked==false && f.p_p1[1].checked==false){
			alert("재료준비를 선택하지 않았습니다.");
			return;
		}
		if(f.p_p2[0].checked==false && f.p_p2[1].checked==false){
			alert("인쇄공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p3[0].checked==false && f.p_p3[1].checked==false){
			alert("코팅공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p4[0].checked==false && f.p_p4[1].checked==false){
			alert("합지공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p5[0].checked==false && f.p_p5[1].checked==false){
			alert("접합공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p6[0].checked==false && f.p_p6[1].checked==false){
			alert("포장적재를 선택하지 않았습니다.");
			return;
		}		
		if(f.w_lastdate.value==""){
			alert("최종작업일자가 입력되지 않았습니다.");
			return f.w_lastdate.focus();
		}
		if(f.w_lasttime.value==""){
			alert("최종작업시간이 입력되지 않았습니다.");
			return f.w_lasttime.focus();
		}
		f.submit();
	}
	
	function updatecheck(){
		f.pro.value="update";
		
		if(f.w_workno.value==""){
			alert("작업지시번호가 입력되지 않았습니다.");
			return f.w_workno.focus();
		}
		if(f.p_p1[0].checked==false && f.p_p1[1].checked==false){
			alert("재료준비를 선택하지 않았습니다.");
			return;
		}
		if(f.p_p2[0].checked==false && f.p_p2[1].checked==false){
			alert("인쇄공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p3[0].checked==false && f.p_p3[1].checked==false){
			alert("코팅공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p4[0].checked==false && f.p_p4[1].checked==false){
			alert("합지공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p5[0].checked==false && f.p_p5[1].checked==false){
			alert("접합공정을 선택하지 않았습니다.");
			return;
		}
		if(f.p_p6[0].checked==false && f.p_p6[1].checked==false){
			alert("포장적재를 선택하지 않았습니다.");
			return;
		}		
		if(f.w_lastdate.value==""){
			alert("최종작업일자가 입력되지 않았습니다.");
			return f.w_lastdate.focus();
		}
		if(f.w_lasttime.value==""){
			alert("최종작업시간이 입력되지 않았습니다.");
			return f.w_lasttime.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp"%>
	<section>
		<div>
			<h2>작업공정등록</h2>
		</div>
		<form action="insertUpdatePro.jsp" method="post" name="f">
			<input type="hidden" name="pro" value="">
			<table border="1" width="500" style="margin:0 auto">
				<tr>
					<th>작업지시번호</th>
					<td><input type="text" name="w_workno" value="" maxlength="8">예)20190001</td>
				</tr>
				<tr>
					<th>재료준비</th>
					<td style="padding-left:15px">
						<label><input type="radio" name="p_p1" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p1" value="N">작업중</label>					
					</td>
				</tr>
				<tr>
					<th>인쇄공정</th>
					<td style="padding-left:15px">
						<label><input type="radio" name="p_p2" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p2" value="N">작업중</label>					
					</td>
				</tr>
				<tr>
					<th>코팅공정</th>
					<td style="padding-left:15px">
						<label><input type="radio" name="p_p3" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p3" value="N">작업중</label>					
					</td>
				</tr>
				<tr>
					<th>합지공정</th>
					<td style="padding-left:15px">					   
						<label><input type="radio" name="p_p4" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p4" value="N">작업중</label>					
					</td>
				</tr>
				<tr>
					<th>접합공정</th>
					<td style="padding-left:15px">
						<label><input type="radio" name="p_p5" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p5" value="N">작업중</label>					
					</td>
				</tr>
				<tr>
					<th>포장적재</th>
					<td style="padding-left:15px">
						<label><input type="radio" name="p_p6" value="Y">완료</label>
						&nbsp;&nbsp;
						<label><input type="radio" name="p_p6" value="N">작업중</label>					
					</td>
				</tr>
				
				<tr>
					<th>최종작업일자</th>
					<td><input type="text" name="w_lastdate" value="" maxlength="8">예)20190101</td>
				</tr>
				<tr>
					<th>최종작업시간</th>
					<td><input type="text" name="w_lasttime" value="" maxlength="4">예)1300</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="공정등록" onclick="insertcheck(); return false">
						<input type="submit" value="공정수정" onclick="updatecheck(); return false">
						<input type="button" value="다시쓰기" 
						onclick="alert('정보를 지우고 처음부터 다시 입력합니다.'); f.reset(); f.w_workno.focus();">
					</th>
				</tr>
			</table>		
		</form> 
		<br>
		<div style="text-align:center; font-weight:bold">
		[참고]공정정보입력은 작업지시서에 등록된 작업지시번호를 참조하여 저장합니다.		
		</div>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>
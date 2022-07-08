<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
</head>
<script type="text/javascript">
	function check() {		
     	if(f.STUDENT_NO.value == ""){
			alert("수강생번호를 입력해 주세요");
			f.STUDENT_NO.focus();
			return false;
		}
		if(f.SUBJECT_SEQ.value == ""){
			alert("신청과목을 선택해 주세요");
			return;
		}
		if(f.REGISTER_DATE.value == ""){
			alert("신청일자를 입력해 주세요");
			f.REGISTER_DATE.focus();
			return false;
		}
		//수강상태에 대한 유효성 체크는 안해도 됨
		if(f.REGISTER_STATUS[0].selected == false
		&& f.REGISTER_STATUS[1].selected == false
		&& f.REGISTER_STATUS[2].selected == false){
			alert("수강상태를 선택해보세요");		
			return;
		}
		f.submit();
	}
</script>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<%
	sql = "select NVL(MAX(REGISTER_SEQ),0)+1 from REGISTER_TBL_01";
	rs = stmt.executeQuery(sql);
	rs.next();
	int REGISTER_SEQ = rs.getInt(1);
	
	sql = "select to_char(sysdate, 'yyyy/mm/dd') from REGISTER_TBL_01";
	rs = stmt.executeQuery(sql);
	rs.next();
	String REGISTER_DATE = rs.getString(1);
	%>
	<section>
		<div>
			<h2>수강신청</h2>
		</div>
		<form action="insert2Pro.jsp" method="post" name="f">
			<table border="1" width="400" style="margin: 0 auto;">
			    <tr hidden="REGISTER_SEQ">
					<th>수강신청번호</th>
					<td><input type="text" name="REGISTER_SEQ" value="<%=REGISTER_SEQ%>"></td>
				</tr>
				<tr>
					<th>수강생번호</th>
					<td><input type="text" name="STUDENT_NO" size="18"></td>
				</tr>
				<tr>
					<th>신청과목</th>
					<td>
						<select name="SUBJECT_SEQ">
							<option value="수강과목"></option>
							<%
							sql = "select SUBJECT_SEQ, SUBJECT_NAME from SUBJECT_TBL_01";
							rs = stmt.executeQuery(sql);
							
							while(rs.next()){
								String SUBJECT_SEQ = rs.getString("SUBJECT_SEQ");
								String SUBJECT_NAME = rs.getString("SUBJECT_NAME");
								%>
								<option value="<%=SUBJECT_SEQ%>"><%=SUBJECT_NAME%></option>
							<%	
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>신청일자</th>
					<td><input type="text" name="REGISTER_DATE" value="<%=REGISTER_DATE%>" size="18"></td>
				</tr>				
				<tr>
					<th>수강상태</th>
					<td>						
						<select name="REGISTER_STATUS">
							<option value="0">신청</option>
							<option value="1">완료</option>
							<option value="2">취소</option>
						</select>					
					</td>
				</tr>				
			</table>
			<center>
				<input type="submit" value="등록" onclick="check(); return false">
				<input type="button" value="조회" onclick="location.href='select2.jsp'">
			</center>
		</form>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
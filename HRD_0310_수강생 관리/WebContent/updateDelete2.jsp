<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원 수강 관리</title>
</head>
<script type="text/javascript">
	function check(){
		if(!f.STUDENT_NAME.value){
			alert("이름을 입력해 주세요");			
			return f.STUDENT_NAME.focus();
		}
		if(!f.STUDENT_PHONE.value){
			alert("연락처를 입력해 주세요");			
			return f.STUDENT_PHONE.focus();
		}
		if(!f.STUDENT_BIRTH.value){
			alert("생년월일을 입력해 주세요");			
			return f.STUDENT_BIRTH.focus();
		}
		f.submit();
	}
</script>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<%
	int STUDENT_NO = Integer.parseInt(request.getParameter("STUDENT_NO"));
	
	/* //방법-1
	sql = "select STUDENT_NAME, nvl(STUDENT_ADDR, ' ') as STUDENT_ADDR, STUDENT_PHONE, to_char(STUDENT_BIRTH, 'yyyy/mm/dd') as STUDENT_BIRTH,";
	sql += " nvl(REGEXP_SUBSTR(STUDENT_EMAIL, '[^@]+', 1, 1),' ') as STUDENT_EMAIL1,";
	sql += " REGEXP_SUBSTR(STUDENT_EMAIL, '[^@]+', 1, 2) as STUDENT_EMAIL2,";
	sql += " nvl(STUDENT_ID,' ') as STUDENT_ID,";//null처리 방법-2
	sql += " nvl(STUDENT_PW,' ') as STUDENT_PW";//null처리 방법-2
	sql += " from STUDENT_TBL_01";
	sql += " where STUDENT_NO=?";
	*/
	
	/* //방법-2
	sql = "select STUDENT_NAME, nvl(STUDENT_ADDR, ' ') as STUDENT_ADDR, STUDENT_PHONE, to_char(STUDENT_BIRTH, 'yyyy/mm/dd') as STUDENT_BIRTH,";
	sql += " nvl(SUBSTR(STUDENT_EMAIL, 1, INSTR(STUDENT_EMAIL, '@', 1)-1),' ') as STUDENT_EMAIL1,";
	sql += " nvl(SUBSTR(STUDENT_EMAIL, INSTR(STUDENT_EMAIL, '@', 1)+1),'naver.com') as STUDENT_EMAIL2,";
	sql += " nvl(STUDENT_ID,' ') as STUDENT_ID,";//null처리 방법-2
	sql += " nvl(STUDENT_PW,' ') as STUDENT_PW";//null처리 방법-2
	sql += " from STUDENT_TBL_01";
	sql += " where STUDENT_NO=?";
	*/
	
	//방법-3 : STUDENT_EMAIL 자바로 처리
	sql ="select STUDENT_NO, STUDENT_NAME, nvl(STUDENT_ADDR, ' ') as STUDENT_ADDR, STUDENT_PHONE, to_char(STUDENT_BIRTH,'yyyy/mm/dd') as STUDENT_BIRTH, ";
	sql += " STUDENT_EMAIL, ";
	sql += " nvl(STUDENT_ID,' ') as STUDENT_ID, nvl(STUDENT_PW,' ') as STUDENT_PW ";
	sql += " from STUDENT_TBL_01";
	sql += " where STUDENT_NO = ?";
	
	ps = con.prepareStatement(sql);
	ps.setInt(1, STUDENT_NO);
	rs = ps.executeQuery();
	rs.next();
	//자바로 처리
	String STUDENT_EMAIL = rs.getString("STUDENT_EMAIL");
	
	int lastnumber = 0;
	String STUDENT_EMAIL1 = "";
	String STUDENT_EMAIL2 = "";
	
	//방법-3
	/*
	if(STUDENT_EMAIL != null) {
		lastnumber = STUDENT_EMAIL.indexOf('@');
	
	    STUDENT_EMAIL1 = STUDENT_EMAIL.substring(0, lastnumber);//시작길이0~lastnumber-1
	   // STUDENT_EMAIL2 = STUDENT_EMAIL.substring(lastnumber+1, STUDENT_EMAIL.length());
	    STUDENT_EMAIL2 = STUDENT_EMAIL.substring(lastnumber+1);//시작길이~끝까지
	}else STUDENT_EMAIL2 = "naver.com";
	*/
	
	//방법-4	: String의 split("@")로 2개의 문자열로 분리 
	String[] STUDENT_EMAIL_split = null;
	//String STUDENT_EMAIL1 = "";
	//String STUDENT_EMAIL2 = "";
	
	if(STUDENT_EMAIL != null){
		STUDENT_EMAIL_split = STUDENT_EMAIL.split("@");
		STUDENT_EMAIL1 = STUDENT_EMAIL_split[0];
		STUDENT_EMAIL2 = STUDENT_EMAIL_split[1];
	}else STUDENT_EMAIL2 = "naver.com";
	
	//String의 join("@",String[] 변수):String[]의 각 문자열을 하나로 합침(사이에 "@")
	//String email = String.join("@", STUDENT_EMAIL_split);//"cm@daum.net"
	
	String STUDENT_NAME = rs.getString("STUDENT_NAME");
	String STUDENT_ADDR = rs.getString("STUDENT_ADDR");
	String STUDENT_PHONE = rs.getString("STUDENT_PHONE");
	String STUDENT_BIRTH = rs.getString("STUDENT_BIRTH");
	//String STUDENT_EMAIL1 = rs.getString("STUDENT_EMAIL1");//방법-1과 2
	//String STUDENT_EMAIL2 = rs.getString("STUDENT_EMAIL2");//방법-1과 2
	String STUDENT_ID = rs.getString("STUDENT_ID");
	String STUDENT_PW = rs.getString("STUDENT_PW");
	
	//커서를 제일 앞에 위치시키기 위해-sql에서 nvl을 이용하여 null처리한 것	
	if(STUDENT_ADDR.equals(" ") || STUDENT_ADDR == null){
		STUDENT_ADDR="";//커서 제일 처음으로  위치시키기 [방법-1]
		//STUDENT_ADDR=STUDENT_ADDR.trim();//커서 제일 처음으로  위치시키기 [방법-2]
	}
	if(STUDENT_EMAIL1.equals(" ")){
		//STUDENT_EMAIL1="";
		STUDENT_EMAIL1=STUDENT_EMAIL1.trim();
	}
	if(STUDENT_ID.equals(" ")){
		//STUDENT_ID="";
		STUDENT_ID=STUDENT_ID.trim();
	}
	if(STUDENT_PW.equals(" ")){
		//STUDENT_PW="";
		STUDENT_PW=STUDENT_PW.trim();
	}
	
	//방법-1,2,3,4 : 아래 option에서 자바로 처리하는 것 대신 
	String select1 = "";
	String select2 = "";
	String select3 = "";
	
	if(STUDENT_EMAIL2.equalsIgnoreCase("naver.com")) {
		select1="selected";
	} else if(STUDENT_EMAIL2.equalsIgnoreCase("chol.net")) {
		select2="selected";
	} else if(STUDENT_EMAIL2.equalsIgnoreCase("gmail.com")) {
		select3="selected";
	}
	%>
	<section>
		<div>
			<h2>수강생 수정 및 삭제</h2>
		</div>
		<form action="updatePro.jsp" method="post" name="f">
			<table border="1" width="600" style="margin: 0 auto;">
			    <tr hidden="STUDENT_NO">
					<th>수강생번호</th>
					<td><input type="text" name="STUDENT_NO" value="<%=STUDENT_NO%>"></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="STUDENT_NAME" value="<%=STUDENT_NAME%>" maxlength="20"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="STUDENT_ADDR" value="<%=STUDENT_ADDR%>" size="50" maxlength="100"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="STUDENT_PHONE" value="<%=STUDENT_PHONE%>" maxlength="14">(예)01023456789</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" name="STUDENT_BIRTH" value="<%=STUDENT_BIRTH%>">(예)2001-06-27</td>
				</tr>
				<tr>
					<th>메일주소</th>
					<td>
						<input type="text" name="STUDENT_EMAIL1" value="<%=STUDENT_EMAIL1%>">
						@
						<select name="STUDENT_EMAIL2">
							<%-- <option value="naver.com" <%if(STUDENT_EMAIL2 != null && STUDENT_EMAIL2.equals("naver.com")){out.print("selected='selected'");}%>>naver.com</option>
							<option value="chol.net" <%if(STUDENT_EMAIL2 != null && STUDENT_EMAIL2.equals("chol.net")){out.print("selected='selected'");}%>>chol.net</option>
							<option value="gmail.com" <%=(STUDENT_EMAIL2 != null && STUDENT_EMAIL2.equals("gmail.com"))?"selected":"" %>>gmail.com</option> --%>
						    <option value="naver.com" <%=select1 %>>naver.com</option>
							<option value="chol.net"  <%=select2 %>>chol.net</option>
							<option value="gmail.com" <%=select3 %>>gmail.com</option>
						</select>					
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="STUDENT_ID" value="<%=STUDENT_ID%>" maxlength="12"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="STUDENT_PW" value="<%=STUDENT_PW%>" size="21" maxlength="50"></td>
				</tr>
			</table>
			<center>
				<input type="submit" value="수정" onclick="check(); return false">
				<input type="button" value="삭제" onclick="location.href='deletePro.jsp?STUDENT_NO=<%=STUDENT_NO%>'">
				<input type="button" value="조회" onclick="location.href='select.jsp'">
			</center>
		</form>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>
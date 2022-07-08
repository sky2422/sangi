<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>

<script type="text/javascript">
	//유효성 검사
	function check(){ //function=함수=메서드
		/*** [방법-1] type="submit"이든 "button"이든 관계없이 실행됨 ***/		
		if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
			alert("회원번호를 입력해주세요.");//알림창			
			return f.memno.focus();
		}
		if(f.name.value == ""){ 
			alert("회원이름을 입력해주세요.");			
			return f.name.focus();
		}
		if(f.address.value == ""){ 
			alert("주소를 입력해주세요.");			
			return f.address.focus();
		}
		if(f.hiredate.value == ""){
			alert("가입일을 입력해주세요.");			
			return f.hiredate.focus();
		}
		//★주의 : radio, checkbox
		if(f.gender[0].checked == false && f.gender[1].checked == false){ 
			alert("성별을 선택해주세요.");			
			return;//★주의
		}
		if(f.tel1.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			return f.tel1.focus();
		}
		if(f.tel2.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			return f.tel2.focus();
		}
		if(f.tel3.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			return f.tel3.focus();
		}
		
		f.submit();
		
		
		/**** [방법-2] type="submit"인 경우 ******/
		/*
		if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
			alert("회원번호를 입력해주세요.");//알림창			
			//return f.memno.focus();
			f.memno.focus();
			return false;//return값을 false로 주면 데이터 전송이 안됨
		}
		else if(f.name.value == ""){ 
			alert("회원이름을 입력해주세요.");			
			//return f.name.focus();
			f.name.focus();
			return false;
		}
		else if(f.address.value == ""){ 
			alert("주소를 입력해주세요.");			
			//return f.address.focus();
			f.address.focus();
			return false;
		}
		else if(f.hiredate.value == ""){
			alert("가입일을 입력해주세요.");			
			//return f.hiredate.focus();
			f.hiredate.focus();
			return false;
		}
		//★주의 : radio, checkbox
		else if(f.gender[0].checked == false && f.gender[1].checked == false){ 
			alert("성별을 선택해주세요.");			
			return false;//★주의
		}
		else if(f.tel1.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel1.focus();
			f.tel1.focus();
			return false;
		}
		else if(f.tel2.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel2.focus();
			f.tel2.focus();
			return false;
		}
		else if(f.tel3.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel3.focus();
			return false;
		}
		else{		
			//f.submit(); //생략 가능
			return true;//type="submit" 또는 "reset"인 경우 : true값을 리턴하면 데이터 전송됨(=submit됨)
			//즉, return값을 false로 주면 데이터 전송이 안되고 true를 줘야 전송됨
		}
		*/
		
		/**** [방법-3] type="button"인 경우 ******/
		/*
		if(f.memno.value == ""){ //javascript "" '' 둘다 문자열 취급함
			alert("회원번호를 입력해주세요.");//알림창			
			//return f.memno.focus();
			f.memno.focus();
			//return false;
		}
		else if(f.name.value == ""){ 
			alert("회원이름을 입력해주세요.");			
			//return f.name.focus();
			f.name.focus();
			//return false;
		}
		else if(f.address.value == ""){ 
			alert("주소를 입력해주세요.");			
			//return f.address.focus();
			f.address.focus();
			//return false;
		}
		else if(f.hiredate.value == ""){
			alert("가입일을 입력해주세요.");			
			//return f.hiredate.focus();
			f.hiredate.focus();
			return false;
		}
		//★주의 : radio, checkbox
		else if(f.gender[0].checked == false && f.gender[1].checked == false){ 
			alert("성별을 선택해주세요.");			
			//return false;//★주의
		}
		else if(f.tel1.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel1.focus();
			f.tel1.focus();
			//return false;
		}
		else if(f.tel2.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel2.focus();
			f.tel2.focus();
			//return false;
		}
		else if(f.tel3.value == ""){ 
			alert("전화번호를 입력해주세요.");			
			//return f.tel3.focus();
			//return false;
		}
		else{		
			f.submit(); //반드시 존재 : submit()으로 데이터 전송
			//return true;//type="submit" 또는 "reset"인 경우 : true값을 리턴하면 데이터 전송됨(=submit됨)
		}
		*/
	}//check() 끝
	
	function reWrite(){		
		var x = confirm("다시 쓰시겠습니까?");//[확인]==true,[취소]==false
		if(x==true) f.reset();
		f.name.focus();//커서
		
		//f.reset();
		//f.name.focus();//커서 
		//f.name.select();//블럭
	}
	
</script>

<body>
	<%@ include file = "header.jsp" %> <!-- header.jsp안에 dbcon.jsp(DB 연결 + 변수 선언)과 style.css가 포함-->
	
	<%
	/** 구문객체-2.PreparedStatment 구문객체 사용 : select 사용가능 => 반드시 결과로 ResultSet **/
	String memno = request.getParameter("memno");//'1004'
	
	sql += "select memno, name, address,";
	sql += " to_char(hiredate,'yyyy-mm-dd') AS hiredate,";
	sql += " gender,";
	sql += " tel1, tel2, tel3";
	sql += " from member";
	sql += " where memno=?";
	
	ps = con.prepareStatement(sql);
	ps.setString(1, memno);
	rs = ps.executeQuery();	
	
	//[방법-1]
	rs.next();//무조건 참이므로
	
	String name = rs.getString("name");//rs.getString(2);
	String address = rs.getString("address");
	String hiredate = rs.getString("hiredate");
	String gender = rs.getString("gender");
	String tel1 = rs.getString("tel1");
	String tel2 = rs.getString("tel2");
	String tel3 = rs.getString("tel3");
	
	//[방법-2]
	/*
	String name = null;
	String address = null;
	String hiredate = null;
	String gender = null;
	String tel1 = null;
	String tel2 = null;
	String tel3 = null;
	
	if(rs.next()){		
		//memno = rs.getString(1);//1004 -> 1004
		name = rs.getString("name");//name = rs.getString(2);
		address = rs.getString("address");
		hiredate = rs.getString("hiredate");
		gender = rs.getString("gender");
		tel1 = rs.getString("tel1");
		tel2 = rs.getString("tel2");
		tel3 = rs.getString("tel3");
	}
	*/
	
	%>	
	
	<section>
		<div>
			<h2>회원수정</h2>
		</div>
		
		<form action="insertPro.jsp" name="f" method="post">
			<!-- style="margin:0 auto" 크롬에서 가운데 정렬 -->
			<table style="margin:0 auto" border="1" width="500">
				<tr>
					<th>회원번호</th>
					<!-- 방법-1 -->
					<%-- <td><input type="text" name="memno" value="<%=rs.getString("memno")%>" size="10" maxlength="4" readonly>자동입력</td> --%>
					<!-- 방법-2 -->
					<td><input type="text" name="memno" value="<%=memno%>" size="10" maxlength="4" readonly></td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td><input type="text" name="name" value="<%=name%>" size="15" maxlength="30"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" value="<%=address%>" size="40" maxlength="100"></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><input type="text" name="hiredate" value="<%=hiredate %>" size="15" maxlength="15" readonly></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<%-- &nbsp;&nbsp;<label><input type="radio" name="gender" value="M" <%if(gender!=null && gender.equals("M")) {out.print("checked");}%>>남자</label> --%>
						<!-- jsp파일->서블릿(=java파일)으로 변경 out.print(gender!=null && gender.equals("M")?"checked":""); -->
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="M" <%=gender!=null && gender.equals("M")?"checked":""%>>남자</label>
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="F" <%if(gender!=null && gender.equals("F")) {out.print("checked='checked'");}%>>여자</label>	
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel1" value="<%=tel1%>" size="5" maxlength="3">-
						<input type="text" name="tel2" value="<%=tel2%>" size="5" maxlength="4">-
						<input type="text" name="tel3" value="<%=tel3%>" size="5" maxlength="4">
					
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<!-- [방법-1] type="submit"이든 "button"이든 관계없이 실행됨  -->					
						<input type="submit" value="회원수정" onclick="check(); return false">
					    <!--  <input type="button" value="회원등록" onclick="check(); return false"> -->
					    
					    <!-- [방법-2] type="submit"인 경우 : [회원등록] 클릭하면 insertPro.jsp로 입력한 데이터가 전송됨 
			            	이 때, return값을 false로 주면 전송이 안되고 true를 줘야 전송됨
							그래서 function check()에서 f.submit();가 없어도 전송됨.-->
					    <!-- <input type="submit" value="회원등록" onclick="check();"> -->
					    
					    <!-- [방법-3] type="button"인 경우 : [회원등록] 클릭하면 insertPro.jsp로 입력한 데이터가 
			            function check()에서 반드시 f.submit();에 의해 전송됨.-->
					    <!--  <input type="button" value="회원등록" onclick="check();"> -->
					    
					    <!-- [방법-1] reset:처음 상태로 돌아감 -->
					   <!--  <input type="reset" value="다시쓰기"> -->
					    <!-- [방법-2] -->
					    <input type="button" value="다시쓰기" onclick="reWrite()">
					</th>
				</tr>			
			</table>
		</form>	
	</section>	
	<%@ include file = "footer.jsp" %> <!-- DB 연결 해제 -->
</body>
</html>






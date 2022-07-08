<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰관리 프로그램</title>
</head>

<script type="text/javascript" src="check.js">	
</script>

<body>
	<%@ include file = "header.jsp" %> <!-- header.jsp안에 dbcon.jsp(DB 연결 + 변수 선언)과 style.css가 포함 -->
	
	<%
	/** 빈 구문객체-1.Statment 구문객체 사용 : select => 반드시 결과로 ResultSet **/
	/*
	NVL(max(memno),0) : max(memno)이 NULL이 아니면 max(memno),
	                                NULL이면 0
	NVL(max(memno),0) +1 = 그 다음 회원번호   (예)1009 + 1 = 1010                         
	*/
	
	//[방법-1] 반드시 회원번호 4자리로 1001부터 시작한다면
	//sql = "select NVL(max(memno),1000)+1 as memno from member";
	
	//[방법-2] 회원번호 4자리라는 말이 없으면
	sql = "select NVL(max(memno),0)+1 as memno from member";
	rs = stmt.executeQuery(sql);	
	
	//rs.next();//방법-1 : 1010	
	
	String memno = null; //방법-2 : 1010
	if(rs.next()){
		//memno = rs.getString(1);//index 번호
		memno = rs.getString("memno");//"컬럼명"
	}
	
	
	//가입일을 오늘 날짜로 자동입력
	sql = "select to_char(sysdate,'yyyy-mm-dd') as hiredate from dual";
	rs = stmt.executeQuery(sql);
	String hiredate = null;
	if(rs.next()){
		hiredate = rs.getString(1);//index 번호
		//hiredate = rs.getString("hiredate");//"컬럼명"
	}
	
	%>	
	
	<section>
		<div>
			<h2>회원등록</h2>
		</div>
		
		<form action="insertPro.jsp" name="f" method="post">
			<!-- style="margin:0 auto" 크롬에서 가운데 정렬 -->
			<table style="margin:0 auto" border="1" width="500">
				<tr>
					<th>회원번호</th>
					<%--  <%='변수' 또는 '리턴값이 있는 메서드' 또는 '수식(변수 또는 리턴값이 있는 메서드를 포함할 수 있음)' %> --%>
					<!-- 방법-1 -->
					<%-- <td><input type="text" name="memno" value="<%=rs.getString("memno")%>" size="10" maxlength="4" readonly>자동입력</td> --%>
					<!-- 방법-2 -->
					<td><input type="text" name="memno" value="<%=memno%>" size="10" maxlength="4" readonly>자동입력</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td><input type="text" name="name" value="" size="15" maxlength="30"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" value="" size="40" maxlength="100"></td>
				</tr>
				<tr>
					<th>가입일</th>
					<td><input type="text" name="hiredate" value="<%=hiredate %>" size="15" maxlength="15" readonly>자동입력</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="M">남자</label>
						&nbsp;&nbsp;<label><input type="radio" name="gender" value="F">여자</label>	
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" name="tel1" value="" size="5" maxlength="3">-
						<input type="text" name="tel2" value="" size="5" maxlength="4">-
						<input type="text" name="tel3" value="" size="5" maxlength="4">
					
					</td>
				</tr>
				<tr>
					<th colspan="2">
					    <!-- [방법-1과 2 공통] type="submit"일 때 중간에  submit()이 실행되지 않는 방법
					        (=즉, 데이터가 다 입력되지 않은 상태에서 [등록]버튼 누렀을 때 insertPro로 넘어가지 않도록 하는 방법)
					                           ★★return값을 false로 주면 submit은 실행이 안되므로
					         1. check(); return false;를 마지막에 넣어주어  check()실행 후 return false;실행시켜 submit 실행 안되게 함
					         2. function check(){
						            if(비어있으면){
						             return false;를 돌려주어  submit 실행 안되게 함
						            }마지막 else{
						             return true;
						            }
					         }
					    -->
						
						<!-- [방법-1] type="submit"이든 "button"이든 관계없이 실행됨  -->					
						<input type="submit" value="회원등록" onclick="check(); return false;">
					    <!-- <input type="button" value="회원등록" onclick="check();">  -->
					    
					    <!-- [방법-2] type="submit"인 경우 : [회원등록] 클릭하면 insertPro.jsp로 입력한 데이터가 전송됨 
			            	이 때, return값을 false로 주면 전송이 안되고 true를 줘야 전송됨
							그래서 function check()에서 f.submit();가 없어도 전송됨.-->
					    <!-- <input type="submit" value="회원등록" onclick="check();"> -->
					    
					    <!-- [방법-3] type="button"인 경우 : [회원등록] 클릭하면 insertPro.jsp로 입력한 데이터가 
			            function check()에서 반드시 f.submit();에 의해 전송됨.-->
					    <!-- <input type="button" value="회원등록" onclick="check();"> -->
					    
					    <input type="button" value="조회" onclick="location.href='select.jsp'">
					</th>
				</tr>			
			</table>
		</form>	
	</section>	
	<%@ include file = "footer.jsp" %> <!-- DB 연결 해제 -->
</body>
</html>






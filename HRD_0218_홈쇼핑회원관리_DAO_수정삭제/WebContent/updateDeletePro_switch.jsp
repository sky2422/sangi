<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file = "dbcon.jsp" %>  --%> <!-- 소스 그대로 복사하여 포함 -->  
 
<%@ page import="member.*" %>

<%
request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="beans" class="member.MemberBeans" scope="page"/>
<jsp:setProperty name="beans" property="*"/>  
 
<%
ShoppingDAO dao = new ShoppingDAO();
/*
switch(정수/문자/문자열을 결과)
case 정수상수/'문자상수'/"문자열상수"
*/
switch(request.getParameter("submit")){
//switch(request.getParameter("pro")){
case "수정":
	int result = dao.updateMember(beans);
	if(result > 0){
		%>
		<script>
		alert("회원정보수정이 완료되었습니다.");
	   	location.href="select.jsp";
		</script>
		<%
	}else{
		%>
		<script>
		alert("회원정보수정이 완료되지 않았습니다.");
	   	history.back();
		</script>
		<%
	}
	break;//"수정" 끝
	
case "삭제" :
	result = dao.deleteMember(beans);
	if(result > 0){
		%>
		<script>
		alert("회원삭제가 완료되었습니다.");
	   	location.href="select.jsp";
		</script>
		<%
	}else{
		%>
		<script>
		alert("회원삭제가 완료되지 않았습니다.");
	   	history.back();
		</script>
		<%
	}
	break;//"삭제" 끝
}//switch문 끝
%>







<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>

<%
String STUDENT_EMAIL1 = request.getParameter("STUDENT_EMAIL1");
String STUDENT_EMAIL2 = request.getParameter("STUDENT_EMAIL2");
String STUDENT_EMAIL = null;

if(!STUDENT_EMAIL1.equals("")){
	STUDENT_EMAIL = STUDENT_EMAIL1 + "@" + STUDENT_EMAIL2;
}

try{
	sql = "update STUDENT_TBL_01 set STUDENT_NAME=?, STUDENT_ADDR=?,STUDENT_PHONE=?,STUDENT_BIRTH=?,STUDENT_EMAIL=?,STUDENT_ID=?,STUDENT_PW=?";
	sql += " where STUDENT_NO=?";
	
	ps = con.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("STUDENT_NAME"));
	ps.setString(2, request.getParameter("STUDENT_ADDR"));
	ps.setString(3, request.getParameter("STUDENT_PHONE"));
	ps.setString(4, request.getParameter("STUDENT_BIRTH"));
	ps.setString(5, STUDENT_EMAIL);
	ps.setString(6, request.getParameter("STUDENT_ID"));
	ps.setString(7, request.getParameter("STUDENT_PW"));	
	
	//ps.setString(8, request.getParameter("STUDENT_NO"));
	ps.setInt(8, Integer.parseInt(request.getParameter("STUDENT_NO")));
	
	ps.executeUpdate();
	//성공 알림창
	%>
	<script>
		alert("수강생 수정이 완료되었습니다.");
		location.href="select.jsp";
	</script>
<%
}catch(Exception e){
	%>
	<script>
		alert("수강생 수정이 완료되지 않았습니다.");
		history.back();
	</script>
<%
}finally{
	
	try{
		if(con != null) con.close();
		if(stmt != null) stmt.close();
		if(ps != null) ps.close();
		if(rs != null) rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}	
}
%>
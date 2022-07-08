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
	sql = "select nvl(max(STUDENT_NO),0)+1  from STUDENT_TBL_01";
	rs = stmt.executeQuery(sql);
	rs.next();
	int STUDENT_NO = rs.getInt(1);//수강생 번호
	
	sql = "insert into STUDENT_TBL_01 values(?,?,?,?,?,?,?,?)";
	ps = con.prepareStatement(sql);
	ps.setInt(1, STUDENT_NO);
	ps.setString(2, request.getParameter("STUDENT_NAME"));
	ps.setString(3, request.getParameter("STUDENT_ADDR"));
	ps.setString(4, request.getParameter("STUDENT_PHONE"));
	ps.setString(5, request.getParameter("STUDENT_BIRTH"));
	ps.setString(6, STUDENT_EMAIL);
	ps.setString(7, request.getParameter("STUDENT_ID"));
	ps.setString(8, request.getParameter("STUDENT_PW"));
	
	ps.executeUpdate();
	//성공 알림창
	%>
	<script>
		alert("수강생 등록이 완료되었습니다.");
		location.href="insert.jsp";
	</script>
<%
}catch(Exception e){
	%>
	<script>
		alert("수강생 등록이 완료되지 않았습니다.");
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
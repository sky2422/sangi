<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>

<%

try{
	sql = "delete from STUDENT_TBL_01 where STUDENT_NO=?";
	
	ps = con.prepareStatement(sql);	
	
	//ps.setString(1, request.getParameter("STUDENT_NO"));
	ps.setInt(1, Integer.parseInt(request.getParameter("STUDENT_NO")));
	
	ps.executeUpdate();
	//성공 알림창
	%>
	<script>
		alert("수강생 삭제가 완료되었습니다.");
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
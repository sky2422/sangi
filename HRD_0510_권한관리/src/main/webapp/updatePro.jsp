<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%>    

<%
try{
	sql = "update USER_TBL_08 set USER_NAME=?,USER_PW=?,DEPT_NO=?,USER_GBN=?,REG_DATE=? where USER_NO=?";
	ps = con.prepareStatement(sql);	
	
	ps.setString(1, request.getParameter("USER_NAME"));
	ps.setString(2, request.getParameter("USER_PW"));
	ps.setString(3, request.getParameter("DEPT_NO"));
	ps.setString(4, request.getParameter("USER_GBN"));
	ps.setString(5, request.getParameter("REG_DATE"));
	ps.setString(6, request.getParameter("USER_NO"));
	
	ps.executeUpdate();
%>
	<script>
		alert("사용자 수정이 완료되었습니다.");
		history.back();//location="insert.jsp";
	</script>
<%	
}catch(Exception e){
%>
	<script>
		alert("사용자 수정이 완료되지 않았습니다.");
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>
<%
	try {

		sql = "update EMPLOYEE_TBL_13 set EMPLOYEE_NAME=?,DEPT_NO=?,HIRE_DATE=?,EMPLOYEE_STATUS=? where EMPLOYEE_NO=?";

		ps = con.prepareStatement(sql);

		ps.setString(1, request.getParameter("EMPLOYEE_NAME"));
		ps.setString(2, request.getParameter("DEPT_NO"));
		ps.setString(3, request.getParameter("HIRE_DATE"));
		ps.setString(4, request.getParameter("EMPLOYEE_STATUS"));

		ps.setString(5, request.getParameter("EMPLOYEE_NO"));

		ps.executeUpdate();
%>
<script>
	alert("사원등록이 완료되었습니다.")
	history.back();
</script>
<%
	} catch (Exception e) {
%>
<script>
	alert("사원등록이 완료되지않았습니다.")
	history.back();
</script>
<%
	} finally{
		try{
			if(con!=null) con.close();
			if(stmt!=null) stmt.close();
			if(ps!=null) ps.close();
			if(rs!=null) rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp" %> 

<%
try{
	sql="delete from member_tbl_02 where custno=?";
	
	ps=con.prepareStatement(sql);	
	
	ps.setString(1, request.getParameter("custno"));
	
	ps.executeUpdate();	
%>
	<script>
		alert("회원삭제가 완료되었습니다.");
		location="select.jsp";//location.href="select.jsp";//location.href("select.jsp");
	</script>
<%
}catch(Exception e){
%>
	<script>
		alert("회원삭제가 완료되지 않았습니다.");
		history.back();//history.go(-1);
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
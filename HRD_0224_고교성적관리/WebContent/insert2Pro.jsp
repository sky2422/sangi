<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp" %>
<%
try{
	sql="insert into examtbl_3 values(?,?,?,?,?,?)";
	ps = con.prepareStatement(sql);
	ps.setString(1, request.getParameter("syear"));
	ps.setString(2, request.getParameter("sclass"));
	ps.setString(3, request.getParameter("sno"));
	ps.setString(4, request.getParameter("kor"));
	ps.setString(5, request.getParameter("eng"));
	ps.setString(6, request.getParameter("math"));
	ps.executeUpdate();
	%>
	<script>
		alert("성적등록이 완료되었습니다.");
		location="insert2.jsp";
	</script>
	<%
}catch(Exception e){
	%>
	<script>
		alert("성적등록이 완료되지 않았습니다.");
		history.back();
	</script>
	<%
}
finally{
	try{
		if(rs!=null) rs.close();
		if(ps!=null) ps.close();
		if(stmt!=null) stmt.close();
		if(con!=null) con.close();
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp" %>
<%
try{
	sql="insert into apptrainer_tbl values(?,?,?,?)";
	ps=con.prepareStatement(sql);
	ps.setString(1, request.getParameter("tno"));
	ps.setString(2, request.getParameter("memno"));
	ps.setString(3, request.getParameter("mname"));
	ps.setString(4, request.getParameter("ttime"));
	ps.executeUpdate();
%>
	<script>
		alert("트레이너신청이 완료되었습니다.");
		location="select.jsp";
	</script>
<%
}catch(Exception e){
%>
	<script>
		alert("트레이너신청이 완료되지않았습니다.");
		history.back();
	</script>
<%
}finally{
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
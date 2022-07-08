<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp" %>
<%
try{
	sql="insert into member_tbl values(?,?,?,?,?,?)";
	ps=con.prepareStatement(sql);
	ps.setString(1, request.getParameter("memno"));
	ps.setString(2, request.getParameter("mname"));
	ps.setString(3, request.getParameter("maddress"));
	ps.setString(4, request.getParameter("joindate"));
	ps.setString(5, request.getParameter("gender"));
	ps.setString(6, request.getParameter("tel"));
	ps.executeUpdate();
%>
	<script>
		alert("회원등록이 완료되었습니다.");
		location.href="insert.jsp";
	</script>
<%
}catch(Exception e){
%>
	<script>
		alert("회원등록이 완료되지 않았습니다.");
		history.back(); //history.go(-1);
		//location.href="insert.jsp";
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
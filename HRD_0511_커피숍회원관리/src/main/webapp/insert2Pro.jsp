<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>

<%
try{
	//--상품단가 수정 전
	sql="insert into coffee_tbl values(?,?,?)";
	ps=con.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("PCODE"));
	ps.setString(2, request.getParameter("PNAME"));
	ps.setString(3, request.getParameter("PCOST"));	
	
	ps.executeUpdate();
	
	//--상품단가 수정 후
	sql="insert into coffee_tbl2 values(?,?,?)";
	ps=con.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("PCODE"));
	ps.setString(2, request.getParameter("PNAME"));
	ps.setString(3, request.getParameter("PCOST"));	
	
	ps.executeUpdate();
	//성공알림창
	%>
	<script>
		alert("상품등록이 완료되었습니다.");
		location.href="insert2.jsp";//location.href="select2.jsp";
	</script>
	<%
}catch(Exception e){
	//실패알림창
	%>
	<script>
		alert("상품등록이 완료되지 않았습니다.");
		history.back();
	</script>
	<%
}finally{
	try{
		if (con != null)	con.close();
		if (stmt != null)	stmt.close();
		if (ps != null)		ps.close();
		//if (rs != null) 	rs.close();	
	}catch(Exception e){
		e.printStackTrace();
	}
}
%>

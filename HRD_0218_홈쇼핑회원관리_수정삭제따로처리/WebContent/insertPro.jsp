<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "dbcon.jsp" %>  <!-- 소스 그대로 복사하여 포함 -->  
    
<%
try{
	sql = "insert into member_tbl_02 values(?,?,?,?,?,?,?)";
	
	ps = con.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("custno"));
	ps.setString(2, request.getParameter("custname"));
	ps.setString(3, request.getParameter("phone"));
	ps.setString(4, request.getParameter("address"));
	ps.setString(5, request.getParameter("joindate"));
	ps.setString(6, request.getParameter("grade"));
	ps.setString(7, request.getParameter("city"));
	
	ps.executeUpdate();
	//성공
%>
	<script>
		alert("회원등록이 완료 되었습니다.");
		location.href="select.jsp";
	</script>
<%	
}catch(Exception e){
	//실패
%>
	<script>
		alert("회원등록이 완료 되지 않았습니다.");
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
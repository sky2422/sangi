<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "dbcon.jsp" %>  <!-- 소스 그대로 복사하여 포함 -->  
    
<%
String submit = request.getParameter("submit");
//String submit = request.getParameter("pro");
try {
	if(submit.equals("수정")){
		sql = "update member_tbl_02 set custname = ?, phone = ?, address = ?,  grade = ?, city = ? where custno = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, request.getParameter("custname"));
		ps.setString(2, request.getParameter("phone"));
		ps.setString(3, request.getParameter("address"));
		ps.setString(4, request.getParameter("grade"));
		ps.setString(5, request.getParameter("city"));
		ps.setString(6, request.getParameter("custno"));
		ps.executeUpdate();	
		%>
		<script>
			alert("회원수정이 완료되었습니다.");
			location.href = "select.jsp";
		</script>
		<%
	} else {
		sql = "delete from member_tbl_02 where custno = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, request.getParameter("custno"));
		ps.executeUpdate();
		%>
		<script>
			alert("회원삭제가 완료되었습니다.");
			location.href = "select.jsp";
		</script>
		<%
	}

} catch(Exception e) {
	if(submit.equals("수정")) {
		%>
		<script>
			alert("회원수정이 실패했습니다.");
			history.back();
		</script>
		<%
	} else {
		%>
		<script>
			alert("회원삭제가 실패했습니다.");
			history.back();
		</script>
		<%
	}
} finally {
	try {
		if(con != null) con.close();
		if(stmt != null) stmt.close();
		if(ps != null) ps.close();
		if(rs != null) rs.close();		
	} catch(Exception e) {
		e.printStackTrace();
	}
}
%>






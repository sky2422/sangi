<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="dbcon.jsp" %>

<%
request.setCharacterEncoding("utf-8");

/*
switch(정수/문자/문자열)
case 정수상수/'문자상수'/'문자열상수'
*/
switch(request.getParameter("submit")) {//switch(request.getParameter("pro")) {
case "수정" :
	try {
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
			location.href = "selectMember.jsp";
		</script>
	<%
	} catch(Exception e) {
	%>
		<script>
			alert("회원수정이 실패했습니다.");
			history.back();
		</script>
	<%
	} finally {
		try {
			if(con != null) con.close();
			if(ps != null) ps.close();
			if(rs != null) rs.close();			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	break;
	
case "삭제" :
	try {
		sql = "delete from member_tbl_02 where custno = ?";
		ps = con.prepareStatement(sql);
		ps.setString(1, request.getParameter("custno"));
		ps.executeUpdate();	
	%>
		<script>
			alert("회원삭제가 완료되었습니다.");
			location.href = "selectMember.jsp";
		</script>
	<%
	} catch(Exception e) {
	%>
		<script>
			alert("회원삭제가 실패했습니다.");
			history.back();
		</script>
	<%
	} finally {
		try {
			if(con != null) con.close();
			if(ps != null) ps.close();
			if(rs != null) rs.close();			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	break;
} // switch문 끝
%>

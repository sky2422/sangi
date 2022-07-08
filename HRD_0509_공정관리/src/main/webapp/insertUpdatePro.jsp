<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%>

<%
switch(request.getParameter("pro")){
case "insert":
	try{
		sql="insert into tbl_process values(?,?,?,?,?,?,?,?,?)";
		ps=con.prepareStatement(sql);
		
		ps.setString(1, request.getParameter("w_workno"));
		ps.setString(2, request.getParameter("p_p1"));
		ps.setString(3, request.getParameter("p_p2"));
		ps.setString(4, request.getParameter("p_p3"));
		ps.setString(5, request.getParameter("p_p4"));
		ps.setString(6, request.getParameter("p_p5"));
		ps.setString(7, request.getParameter("p_p6"));
		ps.setString(8, request.getParameter("w_lastdate"));
		ps.setString(9, request.getParameter("w_lasttime"));
		
		ps.executeUpdate();
		//성공알림창
		%>
		<script>
			alert("공정상태가 정상적으로 등록되었습니다.");
			location="select3.jsp";/* '작업공정조회' 페이지로 이동*/ 
		</script>
		<%
	}catch(Exception e){
		//실패알림창
		%>
		<script>
			alert("공정상태가 정상적으로 등록되지 않았습니다.");
			history.back();
		</script>
		<%
	}finally{
		try{
			if(con!=null) con.close();
			if(stmt!=null) stmt.close();
			if(ps!=null) ps.close();
			if(rs!=null) rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	break;
	
case "update":
	try{
		sql="update tbl_process set p_p1=?,p_p2=?,p_p3=?,p_p4=?,p_p5=?,p_p6=?,w_lastdate=?,w_lasttime=? where w_workno=?";
		ps=con.prepareStatement(sql);		
		
		ps.setString(1, request.getParameter("p_p1"));
		ps.setString(2, request.getParameter("p_p2"));
		ps.setString(3, request.getParameter("p_p3"));
		ps.setString(4, request.getParameter("p_p4"));
		ps.setString(5, request.getParameter("p_p5"));
		ps.setString(6, request.getParameter("p_p6"));
		ps.setString(7, request.getParameter("w_lastdate"));
		ps.setString(8, request.getParameter("w_lasttime"));
		ps.setString(9, request.getParameter("w_workno"));
		
		ps.executeUpdate();
		//성공알림창
		%>
		<script>
			alert("공정상태가 정상적으로 수정되었습니다.");
			location="select3.jsp";/* '작업공정조회' 페이지로 이동*/ 
		</script>
		<%
	}catch(Exception e){
		//실패알림창
		%>
		<script>
			alert("공정상태가 정상적으로 수정되지 않았습니다.");
			history.back();
		</script>
		<%
	}finally{
		try{
			if(con!=null) con.close();
			if(stmt!=null) stmt.close();
			if(ps!=null) ps.close();
			if(rs!=null) rs.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	break;
}
%>





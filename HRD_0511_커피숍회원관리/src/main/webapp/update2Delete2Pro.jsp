<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="dbcon.jsp"%>

<%
switch(request.getParameter("update2Delete2Pro")){
case "update":
	try{
		//커피 원본 테이블 coffee_tbl: 커피 가격을 제외한 나머지는 수정할 수 있도록
		sql="update coffee_tbl set PNAME=? where PCODE=?";
		ps=con.prepareStatement(sql);	
	
		ps.setString(1, request.getParameter("PNAME"));
		ps.setString(2, request.getParameter("PCODE"));
		
		ps.executeUpdate();
		
		//-------------------------------------------------------
		//커피 수정 테이블 coffee_tbl2 : 커피가격까지 수정
		sql="update coffee_tbl2 set PNAME=?,PCOST=? where PCODE=?";
		ps=con.prepareStatement(sql);	
	
		ps.setString(1, request.getParameter("PNAME"));
		ps.setString(2, request.getParameter("PCOST"));	
		ps.setString(3, request.getParameter("PCODE"));
		
		ps.executeUpdate();
		
		//성공알림창
		%>
		<script>
			alert("커피수정이 완료되었습니다.");
			location="select2.jsp";
		</script>
		<%
	}catch(Exception e){
		//실패알림창
		%>
		<script>
			alert("커피수정이 완료되지 않았습니다.");
			history.back();
		</script>
		<%
	}finally{
		try{
			if (con != null)	con.close();
			if (stmt != null)	stmt.close();
			if (ps != null)		ps.close();
			if (rs != null) 	rs.close();	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	break;
	
case "delete":
	try{
		sql="delete coffee_tbl where PCODE=?";
		ps=con.prepareStatement(sql);	
	
		ps.setString(1, request.getParameter("PCODE"));
		
		ps.executeUpdate();
		
		sql="delete coffee_tbl2 where PCODE=?";
		ps=con.prepareStatement(sql);	
	
		ps.setString(1, request.getParameter("PCODE"));
		
		ps.executeUpdate();
		//성공알림창
		%>
		<script>
			alert("커피삭제가 완료되었습니다.");
			location="select2.jsp";
		</script>
		<%
	}catch(Exception e){
		//실패알림창
		%>
		<script>
			alert("커피삭제가 완료되지 않았습니다.");
			history.back();
		</script>
		<%
	}finally{
		try{
			if (con != null)	con.close();
			if (stmt != null)	stmt.close();
			if (ps != null)		ps.close();
			if (rs != null) 	rs.close();	
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	//break;
}//switch문의 끝
%>

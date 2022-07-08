<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 -->
<%@ include file="dbcon.jsp"%>


<%
try{
	sql = "insert into student_tbl values(?,?,?,?,?,?,?)";
	
	ps = con.prepareStatement(sql);
	ps.setInt(1, Integer.parseInt(request.getParameter("studno")));
	//ps.setString(1, request.getParameter("studno"));
	ps.setString(2, request.getParameter("syear"));
	ps.setString(3, request.getParameter("sname"));
	ps.setString(4, request.getParameter("address"));
	ps.setString(5, request.getParameter("gender"));
	ps.setString(6, request.getParameter("tel"));
	ps.setString(7, request.getParameter("idnum"));
	
	ps.executeUpdate();//업데이트 성공하면 1 리턴받음: 예외객체가 생성X
	//성공
%>
	<script>
		alert("학생등록이 완료되었습니다.");
		location.href="insert.jsp";//★주의 :반드시 문제를 읽고 이동하는 경로 확인하기
		//location.href="select.jsp";
		//location="insert.jsp";
		//history.back();
	</script>
<%	
}catch(Exception e){
	//실패
%>
	<script>
		alert("학생등록이 완료되지 않았습니다.");		
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
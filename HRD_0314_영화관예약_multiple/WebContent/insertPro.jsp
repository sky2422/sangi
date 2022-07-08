<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%> 

<%
try{
	/*자바의 autoCommit 속성은 기본값이 true이이므로 insert, delete, update 등의 데이터를 
	조작하는 작업을 실행했을 때 해당 작업이 즉시 완료되어 되돌릴 수 없다.
	즉, 트랜잭션을 이용하기 위해서 setAutoCommit을 false로 설정한다.	
	*/
	con.setAutoCommit(false); //기본값이 true
	
	sql = "insert into movie_1 values(?,?,?,?,?,?,?)";
	ps = con.prepareStatement(sql);
	
	ps.setString(1, request.getParameter("me_id"));
	ps.setString(2, request.getParameter("me_pass"));
	ps.setString(3, request.getParameter("me_name"));
	ps.setString(4, request.getParameter("gender"));
	ps.setString(5, request.getParameter("birth"));
	ps.setString(6, request.getParameter("address"));
	ps.setString(7, request.getParameter("tel"));
	
    int result = ps.executeUpdate();	
    if(result > 0) {
    	con.commit(); //트랜잭션 완료:영구 저장
%>
	<script>
		alert("회원등록이 완료되었습니다.");
		location="insert.jsp";	
	</script>
<%
    }
}catch(Exception e){
	con.rollback(); //트랜잭션 취소:이전으로 되돌림
%>
	<script>
		alert("회원등록이 완료되지 않았습니다.");
		history.back();	//history.go(-1);
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
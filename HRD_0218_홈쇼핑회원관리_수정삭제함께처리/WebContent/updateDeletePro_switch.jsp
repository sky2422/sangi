<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "dbcon.jsp" %>  <!-- 소스 그대로 복사하여 포함 -->  
    
<%
request.setCharacterEncoding("utf-8");

/*
switch(정수/문자/문자열을 결과)
case 정수상수/'문자상수'/"문자열상수"
*/
//switch(request.getParameter("submit")){
switch(request.getParameter("pro")){
case "수정":

	break;//"수정" 끝
	
case "삭제" :
	try{
		sql = "delete from member_tbl_02 where custno=?";
		
		ps = con.prepareStatement(sql);			
		ps.setString(1, request.getParameter("custno"));
		
		ps.executeUpdate();
		//성공
	%>
		<script>
			alert("회원삭제가 완료 되었습니다.");
			location.href="select.jsp";
		</script>
	<%	
	}catch(Exception e){
		//실패
	%>
		<script>
			alert("회원삭제가 완료 되지 않았습니다.");
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
	break;//"삭제" 끝
}//switch문 끝
%>







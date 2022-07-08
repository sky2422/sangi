<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- ★중요 : DB연결 파일 포함 + 변수 선언 -->
<%@ include file="dbcon.jsp" %>

<%
try{
/** [구문객체-2] PreparedStatement 사용 : SQL문에서 Like키워드를 사용할경우 사용할 수없다. **/
sql = "insert into member values(?,?,?,?,?,?,?,?)";

//sql문을 매개값으로 PreparedStatement 객체 생성
ps = con.prepareStatement(sql);//컴파일되어 DBMS로 넘겨짐->속도가 빠름

//memno가 number이면
//ps.setInt(1, Integer.parseInt(request.getParameter("memno")));
ps.setString(1, request.getParameter("memno"));

ps.setString(2, request.getParameter("name"));
ps.setString(3, request.getParameter("address"));
ps.setString(4, request.getParameter("hiredate"));
ps.setString(5, request.getParameter("gender"));
ps.setString(6, request.getParameter("tel1"));
ps.setString(7, request.getParameter("tel2"));
ps.setString(8, request.getParameter("tel3"));

ps.executeUpdate();	//업데이트 성공하면 1 리턴받음 : 예외객체가 생성X
%>
	<!-- 성공알림창:script -->
	<script>
		alert("회원등록이 완료되었습니다.");
		//location.href = "insert.jsp";
		location = "insert.jsp"; //★주의 : 반드시 문제 확인하기
		//location = "select.jsp";
	</script>
<% 	
} catch(Exception e){//실패 : 예외객체가 생성되어 이것을 잡아서 처리(알림창 띄움)
%>
	<!-- 실패알림창:script -->
	<script>
		alert("회원등록이 실패했습니다.");
		//location.href = "insert.jsp";
		//location = "insert.jsp";
		history.back();//history.go(-1);
	</script>
<% 		
}finally{//예외발생여부에 관계없이 무조건 실행(DB연결 해제)
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









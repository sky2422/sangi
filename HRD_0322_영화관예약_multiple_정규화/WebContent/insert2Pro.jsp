<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%> 

<%
//회원아이디와 비밀번호를 확인하여 회원이면 insert
try{
	String[] mo_name = request.getParameterValues("mo_name");
	
	sql = "select me_pass from movie_1 where me_id=?";
	ps = con.prepareStatement(sql);
	ps.setString(1, request.getParameter("me_id"));
	rs = ps.executeQuery();
	
	String dbpasswd = "";
	if(rs.next()){//해당 아이디의 me_pass(=실제 비밀번호)가 존재하면(즉, 회원이면)
		dbpasswd=rs.getString(1);//해당 아이디의 실제 비밀번호를 가져와
		//실제 비번과 요청하여 전송된 비번이 같으면
		if(dbpasswd.equals(request.getParameter("me_pass"))){
			for(int i=0;i<mo_name.length;i++){//영화제목 여러개 선택
				sql = "insert into movie_2 values(?,?,?,?)";
				ps = con.prepareStatement(sql);
				
				ps.setString(1, request.getParameter("me_id"));
				ps.setString(2, request.getParameter("me_pass"));
				ps.setString(3, mo_name[i]);
				ps.setString(4, request.getParameter("rm_date"));
				
				ps.executeUpdate();	
			}
		%>
			<script>
				alert("영화예매가 완료되었습니다.");
				location="insert2.jsp";	
			</script>
		<%}else{//비번이 틀리면
		%>
			<script>
				alert("비밀번호가 틀렸습니다.");
				history.back();	//history.go(-1);
			</script>
		<%	
		 }//안 else문 끝
	}else{//아이디가 존재하지 않으면(즉, 회원이 아니면)%>
		<script>
			alert("아이디가 틀렸습니다.(회원이 아닙니다.)");
			history.back();	//history.go(-1);
		</script>
	<%	
	}//바깥 else문 끝

}catch(Exception e){
%>
	<script>
		alert("영화예매가 완료되지 않았습니다.");
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
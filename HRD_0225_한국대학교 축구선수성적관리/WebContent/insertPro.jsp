<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%>

<%   
    
	String PLAYER_EMAIL1 = request.getParameter("PLAYER_EMAIL1");
	String PLAYER_EMAIL2 = request.getParameter("PLAYER_EMAIL2");
	
	//[방법-1]
	String PLAYER_EMAIL = null;
	
	if (!PLAYER_EMAIL1.trim().equals("")) {
		PLAYER_EMAIL = PLAYER_EMAIL1 + "@" + PLAYER_EMAIL2;
	}//else PLAYER_EMAIL = null;
	
	try {

		sql = "insert into PLAYER_TBL values(?,?,?,?,?,?,?)";
		ps = con.prepareStatement(sql);

		ps.setString(1, request.getParameter("PLAYER_NO"));
		ps.setString(2, request.getParameter("PLAYER_NAME"));
		ps.setString(3, request.getParameter("TEAM_NO"));
		ps.setString(4, request.getParameter("PLAYER_PHONE"));
		ps.setString(5, request.getParameter("PLAYER_BIRTH"));
		ps.setString(6, PLAYER_EMAIL);//[방법-1]		
		//[방법-2]
		/*
		if(PLAYER_EMAIL1.equals("")) ps.setString(6, null);
	    else ps.setString(6, PLAYER_EMAIL1+"@"+PLAYER_EMAIL2 );		    
		*/
		ps.setString(7, request.getParameter("BACK_NO"));

		ps.executeUpdate();
%>
<script>
	alert("선수 등록이 완료되었습니다.");
	location = "insert.jsp";
</script>
<%
	} catch (Exception e) {
%>
<script>
	alert("선수 등록이 완료되지 않았습니다.");
	history.back();
</script>
<%
} finally {
		try {
			if (con != null)
				con.close();
			if (stmt != null)
				stmt.close();
			if (ps != null)
				ps.close();
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcon.jsp"%>
<%
String[] MEMBER_HOBBY=request.getParameterValues("MEMBER_HOBBY");
//String MEMBER_HOBBY2=String.join(",", MEMBER_HOBBY);//"독서,영화"

if(MEMBER_HOBBY != null){
	for(;;){
		
	}
}

switch(request.getParameter("proALL")){
case "insert":
	try{
		sql="insert into MEMBER_TBL_11 values(?,?,?,?,?,?)";
		ps=con.prepareStatement(sql);
		
		ps.setString(1, request.getParameter("MEMBER_NO"));
		ps.setString(2, request.getParameter("MEMBER_ID"));
		ps.setString(3, request.getParameter("MEMBER_NAME"));
		ps.setString(4, request.getParameter("MEMBER_GRADE"));
		ps.setString(5, MEMBER_HOBBY2);//취미		
		ps.setString(6, request.getParameter("MEMBER_DATE"));
		
		ps.executeUpdate();
	}catch(Exception e){
		
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
break;


}
%>
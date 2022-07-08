<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.util.ArrayList"%>

<!-- ★ 중요 : DB 연결 파일 포함 + 변수선언 -->
<%@ include file = "dbcon.jsp" %>

<%
ResultSet rs2 = null;//이 변수 선언하여 사용하지 않으면 경고가 뜸(45라인에서...)
try{
	
	sql = "SELECT student_no FROM student_tbl_01";
	rs = stmt.executeQuery(sql);
	boolean flag = false;

	ArrayList<String> stuList = new ArrayList<String>();

	System.out.println("\n입력된 학생번호 : " + request.getParameter("STUDENT_NO"));

	while(rs.next()){
		String snumber = rs.getString(1);
		stuList.add(snumber);
	}

	for(int i =0; i<stuList.size(); i++ ){
		System.out.println("학생번호 : " + stuList.get(i));
		if(stuList.get(i).equals(request.getParameter("STUDENT_NO"))){
			flag = true;
		}
	}
	
	if(flag == false){

	%>
	<script type="text/javascript">
			alert("등록되지 않은 수강생 번호입니다.");
			history.back();
			f.student_no.reset();		
	</script>
<%
	}else{
	
	sql = "SELECT NVL(max(register_seq), 0)+1  FROM register_tbl_01";
	//rs = stmt.executeQuery(sql);//경고 발생
	rs2 = stmt.executeQuery(sql);
	
	rs2.next();
	String REGISTER_SEQ = rs2.getString(1);
	System.out.println("- 수강신청번호 : " + REGISTER_SEQ);
	
	sql = "INSERT INTO register_tbl_01 VALUES(?,?,?,?,?)";
	
	ps = con.prepareStatement(sql); // sql문에 ?가 있으면 PreparedStatement문 사용
			
	ps.setString(1, REGISTER_SEQ);	
	ps.setInt(2, Integer.parseInt(request.getParameter("STUDENT_NO")));
	ps.setString(3, request.getParameter("SUBJECT_SEQ"));
	ps.setString(4, request.getParameter("REGISTER_DATE"));
	ps.setString(5, request.getParameter("REGISTER_STATUS"));
	
	ps.executeUpdate(); // 성공
	
	/*	
	[sql 실행문에 따른 함수사용]
	SELECT : executeQuery() 사용 -> SELECT문의 경우 결과로  resultset을 받음
	INSERT, UPDATE : executeUpdate() 사용 -> SELECT문처럼 값을 받는게 아니고 테이블 변경을 하는것이기 때문에 성공하면 성공했다고 1을 반환해줌	
	*/

%>
	<script type="text/javascript">
		alert("수강신청이 완료되었습니다.");
		location.href="select2.jsp";
	</script>
<%
	} // else 문 끝
} catch(Exception e){

%>
	<script type="text/javascript">
		alert("수강신청이 완료되지 않았습니다.");
		history.back(); //history.go(-1);
	</script>
<%

}finally{
	try{ 
		if(con != null) con.close();
		if(stmt != null) stmt.close();
		if(ps != null) ps.close();
		if(rs != null) rs.close();
		
		if(rs2 != null) rs2.close();
	} catch(Exception e){
		e.printStackTrace();
	}
}
%>
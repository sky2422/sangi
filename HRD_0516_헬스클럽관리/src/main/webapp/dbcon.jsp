<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");//한글 깨짐 방지
	
	//1. 오라클 드라이버(=OracleDriver) 로딩 : - ojdbc6.jar 안에 있음
	Class.forName("oracle.jdbc.OracleDriver");

	//2. Connection 객체 생성 - rt.jar(java.sql.*)안에 아래 클래스 파일들이 있음
	//String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");

	//3. 구문 객체 생성
	/*
	[Statement 객체]는 메모리에 동적 생성 
	- 넘겨주는 SQL문은 단순 문자열이기 때문에 DBMS로 넘겨주면	DBMS가 그"SQL문자열"을 쿼리로 컴파일하느라 오래 걸린다.
	- select(조회)일 때 사용하면 편리
	
	[PreparedStatement 객체]는 메모리에 상주 
	- "SQL문자열"을 컴파일된 채로 DBMS로 넘겨주기 때문에 Statement보다 속도가 빠르다.
	- insert(추가), update(수정), delete(삭제)일 때 사용하면 편리 
	*/
	
	Statement stmt = con.createStatement();//sql문 없는 빈 구문객체 생성
	PreparedStatement ps = null;//참조하는 객체가 없다
	
   /*---------------------옵션---------------------------------*/   
   //4. 결과셋 선언
	ResultSet rs = null;
   
   //5. 쿼리문 선언
	String sql = "";//값이 없는 String객체를 참조
%>

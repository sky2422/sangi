<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>

<%
//한글 깨짐 방지
request.setCharacterEncoding("utf-8");

//1. 오라클 드라이버 로딩 - ojdbc6.jar
Class.forName("oracle.jdbc.OracleDriver");

//2. Connection 객체 생성 - rt.jar (java.sql.*)
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
//3. 구문 객체 생성
Statement stmt=con.createStatement();//sql문 없는 빈 구문객체
PreparedStatement ps = null;
/*----옵션----------------------*/
//4.결과셋 선언
ResultSet rs = null;
//5.쿼리문 선언
String sql = "";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");

	Class.forName("oracle.jdbc.OracleDriver");

	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Connection con = DriverManager.getConnection(url, "system", "1234");

	Statement stmt = con.createStatement();
	PreparedStatement ps = null;
	
	ResultSet rs = null;
	String sql = "";
%>
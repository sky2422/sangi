<!-- [JSP 페이지의 인코딩과 pageEncoding 속성]
-JSP 파일을 읽을 때는 page 디렉티브의 pageEncoding 속성과 contentType 속성을 사용해서 캐릭터 인코딩을 결정한다.
-파일이 유니코드가 아닌 경우 또는 파일의 시작이 BOM 이 아닌 경우, 
우선 pageEncoding 속성을 검색하고 그 다음 contentType 속성의 charset의 값을 검색한다.

따라서 pageEncoding 속성을 지정하지 않고 
contentType 속성의 charset을 잘못 지정하면 파일을 잘못된 인코딩을 이용하여 읽어오게 된다.

pageEncoding 속성에서 명시한 인코딩과 contentType 속성에서 명시한 인코딩이 서로 다를 수 있다.
----------------------------------------------------------------------------------
※BOM(Byte Order Marker) : 해당파일이 어떤 인코딩을 사용했는지의 정보를 담고 있는 패턴.  
텍스트 파일의 맨 앞 부분에 이 패턴을 넣어둠으로써 인코딩방식을 감지할 수 있다.

텍스트 인코딩  	             BOM  
-----------------------------------
UTF-8  		            EF BB BF  
UTF-16 Big Endian  	    FE FF  
UTF-16 Little Endian  	FF FE  
UTF-32 Big Endian  	    00 00 FE FF  
UTF-32 Little Endian  	FF FE 00 00  
ASCII  		            no BOM

예를 들어서 문서 처음 2개의 바이트가 FE FF로 시작되면 그 문서는 UTF-16 Big Endian으로 해석되고, 
반대로 FF FE로 시작되면 UTF-16 Little Endian으로 해석되는 것이지요.

그런데 UTF-8은 다른 인코딩 방식과는 다르게 BOM의 순서가 EF BB BF로 정해져 있습니다. 
그래서 이 BOM은 바이트 순서와(Byte Order) 상관없기 때문에 UTF-8 Signature라고 불리지요. 
즉, 해당 문서가 UTF-8로 인코딩되었다는 사실을 알리는 사인(signature)입니다.

http://blog.wystan.net/2007/08/18/bom-byte-order-mark-problem
-->

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

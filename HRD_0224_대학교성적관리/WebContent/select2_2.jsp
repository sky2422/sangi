<!-- java.sql.ResultSetMetaData
메타 데이터란 저장된 데이터 그 자체는 아니지만, 해당 데이터에 대한 정보를 갖고 있는 데이터를 의미한다. 
즉, DB 내의 데이터에 대한 데이터의 소유, 데이터의 크기에 관련된 정보들이다.

ResultSetMetaData는 SQL로 받아온 데이터의 정보를 조회/출력하는 용도로 사용된다. 
ResultSet 인터페이스 객체의 getMetaData() 를 호출하여 ResultSetMetaData 인터페이스 객체를 얻으면 
해당 ResultSet과 관련된 메타 데이터를 얻을 수 있다.

String strQuery = "Select 필드_명  FROM 테이블_명";

ResultSet rs = stmt.executeQuery(strQuery); // stmt : Statement 객체
ResultSetMetaData resultMetaData = rs.getMetaData();
int cols = resultMetaData.getColumnCount(); // 필드 수 구하기
--------------------------------------------------------------------------
주요 메서드
getCatalogName(int column): 주어진 컬럼의 이름을 돌려준다.
getColumnClassName(int column): 주어진 컬럼의 객체를 저장할 때 사용되는 자바 클래스 이름을 돌려준다.
getColumnCount(): 컬럼의 개수를 돌려준다.
getColumnDisplaySize(int column): 주어진 컬럼의 최대 문자 개수를 돌려준다.
getColumnLabel(int column): 주어진 컬럼의 권장 타이틀을 돌려준다.
getColumnName(int column): 주어진 컬럼의 이름을 돌려준다.
getColumnType(int column): 주어진 컬럼의 SQL 타입을 돌려준다. 반환하는 값은 java.sql.Types에 정의된 상수이다.
getColumnTypeName(int column): 주어진 컬럼의 DB에 종속된 이름을 돌려준다.
getTableName(int column): 주어진 컬럼이 속한 테이블 이름을 돌려준다.
isReadOnly(int column): 주어진 컬럼이 읽기 전용인지 알려준다.
-------------------------------------------------------------------------
쿼리 결과의 메타데이터 출력
String sql = "select * from SCORE";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

ResultSetMetaData rsmd = rs.getMetaData();

int cols = rsmd.getColumnCount(); //컬럼의 총개수

for (int i = 1; i <= cols; i++) {
    System.out.print(rsmd.getColumnName(i) + "\t"); //컬럼명 출력
}

while (rs.next()) {
    for (int i = 1; i <= cols; i++) {
        System.out.print(rs.getString(i) + "\t");
    }
}
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대학교 성적 관리</title>
</head>
<body>
	<%@include file="header.jsp"%><!--header.jsp안에 dbcon.jsp(DB연결)  -->
	<section>
		<div>
			<h2>재수강대상자</h2>
		</div>
		<table border="1" width="600" style="margin: 0 auto;">
			<tr>
				<th>과목</th>
				<th>전공1</th>
				<th>전공2</th>
				<th>전공3</th>
				<th>교양1</th>
				<th>교양2</th>	
			</tr>
			
			<tr align="center">
				<th>성적 우수자</th>
				<%
				//ps = con.prepareStatement("select * from score_tbl");
				//rs = ps.executeQuery();
				rs = stmt.executeQuery("select * from score_tbl");
				
				//1.ResultSetMetaData객체를 얻어와
				ResultSetMetaData  rsmd = rs.getMetaData();
				
				//2.컬럼의 총수를 얻어와 numberOfColumns변수에 저장
				int numberOfColumns = rsmd.getColumnCount();//7
				
				//3.컬럼의 총수로 배열객체 생성함
				String[] sub = new String[numberOfColumns];
				
				//4.각 컬럼이름을 얻어와 배열에 저장
				//배열의 index는 0부터 시작. SQL의 index는 1부터 시작
				for(int i=1 ; i<=numberOfColumns ; i++){
					sub[i-1] = rsmd.getColumnName(i);//각 컬럼이름을 얻어와 배열에 저장
				}
				
				int hi=0;
				//i=2부터인 이유?sub는 배열이고 score_tbl테이블에서 3번째 컬럼부터 점수에 관련된 컬럼이므로
				for(int i=2;i<sub.length;i++){
					sql = "select count(*)";
					sql += " from score_tbl join grade_tbl";//비등가조인
					sql += " ON("+ sub[i] +" BETWEEN loscore AND hiscore)";//sub[i]:점수가 있는 컬럼명
					sql += " WHERE grade='A'";
					
					rs = stmt.executeQuery(sql);
					rs.next();
					hi = rs.getInt("count(*)");//성적 우수자 수
				
				%>
					<td><%=hi %>명</td>	
				<%} %> <!-- for문 끝 -->					
			</tr>
			
			<tr align="center">
				<th>재수강 대상자</th>
				<%				
				int low=0;
				//i=2부터인 이유?sub는 배열이고 score_tbl테이블에서 3번째 컬럼부터 점수에 관련된 컬럼이므로
				for(int i=2;i<sub.length;i++){
					sql = "select count(*)";
					sql += " from score_tbl join grade_tbl";//비등가조인
					sql += " ON("+ sub[i] +" BETWEEN loscore AND hiscore)";//sub[i]:점수가 있는 컬럼명
					sql += " WHERE grade='F'";
					
					rs = stmt.executeQuery(sql);
					rs.next();
					low = rs.getInt("count(*)");//재수강 대상자 수
				
				%>
					<td><%=low %>명</td>	
					
				<%} %> <!-- for문 끝 -->				
			</tr>
			
			
		</table>
	</section>
	<%@include file="footer.jsp"%><!-- DB연결 해제 -->
</body>
</html>








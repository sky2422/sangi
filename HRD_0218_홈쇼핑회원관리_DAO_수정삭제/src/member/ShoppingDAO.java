/*  [커넥션 풀=Connection Pool]-혜ppt-15,16 설명 -> 혜 443p~참조
☞ 커넥션 풀은 데이터베이스와 연결된 Connection 객체를 미리 생성하여 풀(Pool) 속에 저장

☞ 필요할 때마다 이 풀에 접근하여 Connection 객체를 사용한 후 다시 반환

☞ 객체를 재생성하지 않기 때문에 프로그램 효율과 성능 증가

------------------------------------------------------------------------
1. 먼저,WebContent\META-INF 안에 context.xml 파일을 생성해서 서버에 공유할 Resource를 정의한다.
 
 <Context> 
  <Resource 
   
   name="jdbc/OracleDB" //1.공유하는 리소스 이름. name으로 '커넥션 풀(DataSource)'에 접근
   
   auth="Container" //2.클라언트에서 리소스를 얻어갈 때 인증은 "Container"에서 하겠다.
   
   type="javax.sql.DataSource" //3.공유할 리소스 타입을 DataSource로 지정
   //클라이언트에서는 공유된 DataSource의 getConnection()메서드를 사용해서 Connection객체를 얻어갈 수 있다.
   
   //DB에 연결할 수 있는 설정 정보-4가지(username,password,driverClassName,url)
   username="system" //4.연동될 오라클서버의 계정과
   password="1234"   //5.비밀번호 지정하는 부분   
   driverClassName="oracle.jdbc.driver.OracleDriver"  //6
   url="jdbc:oracle:thin:@localhost:1521:XE"  //7.연동할 오라클 url 지정하는 부분
   //url="jdbc:oracle:thin:@127.0.0.1:1521:XE"
   
   //8.★★(이줄것만설명)즉, Factory : 연결할 DB종류에 따른 커넥션 풀인 DataSource객체를 생성해주는 클래스이름
   //톰캣에서는 톰캣 설치 경로의 lib 디렉토리에 Connection Pool 기능을 제공하기 위해 dbcp API를 제공한다.
   //Connection Pool 위치 : apache-tomcat-8.5.56 windows-x64\apache-tomcat-8.5.56\lib\tomcat-dbcp
   //dbcp API를 사용해서 클라이언트에 공유할 DataSource를 생성하도록 지정하는 부분
   //자바 API 클래스 중 이름이 Factory로 끝나는 클래스들은 특정 객체를 생성하여 반환하는 역할을 하는 클래스들이다.   
   factory="org.apache.tomcat.dbcp.dbcp2.BasicDataSourceFactory"
   
   //9.동시에 DB에 연결가능한 최대 Connection 수
   maxActive="500" 
   
   //10.★★(이줄만설명)새로운 연결이 생길때까지 기다릴 수 있는 최대시간(예)500개 다 사용중이면 501 생성까지 기다릴 수 있는 최대시간 (1/1000초=0.001초)
   //동시에 제공할 수 있는 Connection 개수 500개를 다 사용하고 있으면 1000분의 1초마다 다음의 Connection(501번째)을 생성한다. 
   //또, 1000분의 1초가 지나 Connection(502번째)을 생성...
   maxWait="1000"
   
   //11.★★(이줄만설명)동시에 idle상태로 대기할 수 있는 최대수 
   //현재 서비스되고 있는 Connection객체를 제외한 Connection Pool에 여유로 남길 수 있는 최대 Connection 개수를 지정한 부분
   maxIdle="100"
   
   />  
</Context>


2. (해당 프로젝트의 context.xml를 수정했으면 아래 내용 안하고 
   Servers의 context.xml를 수정했으면 아래 내용 하여 싱크맟추기)
   Servers 탭의 빨간버튼 클릭하여 멈추고 난후
   Publish to the Server (Ctrl + Alt + p)를 눌러
   이클립스의 context.xml을 수정한 것을 톰캣의 context.xml과 똑같이 싱크를 맞춘다.(즉, 일치시킨다.)
*/
package member;

import java.sql.*;

//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;

import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ShoppingDAO {
	/*******************************************
	 * 1. 필드
	 *******************************************/
	//private static String url = "jdbc:oracle:thin:@localhost:1521:xe";
	//private static String uid = "system";
	//private static String upw = "1234";
	
	Connection con;      //기본값 : null
	PreparedStatement ps;//기본값
	ResultSet rs;        //기본값
	
	String sql = "";
	
	/*******************************************
	 * 2. 생성자:기본생성자-필드에 기본값(수:0/0.0, boolean:false, 클래스 타입:null)을 주어 객체 생성
	 *******************************************/
	
	/*******************************************
	 * 3. 메서드
	 *******************************************/
	public static Connection getConnection() throws Exception{
		/*------첫 번째 방법----------------------------------------*/
		/*
		//1. 오라클 드라이버 로딩
		Class.forName("oracle.jdbc.OracleDriver");
		
		//2. Connection 객체 생성
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		Connection con= DriverManager.getConnection(url, "system", "1234");//지역변수 : 반드시 초기화
	
		return con;
		*/
		/*-------------------------------------------------------*/
		
		/*---두번째 방법 : 커넥션 풀 생성--------------------------------*/
		Connection con = null;
		try {
			Context init = new InitialContext();//javax.naming
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/OracleDB");//javax.sql
			con = ds.getConnection();
		} catch (Exception e) {		
			e.printStackTrace();
		}
		return con;
		/*-------------------------------------------------------*/
	}
	
	
	//1.다음 회원번호와 가입일 조회('회원등록'폼에서-insert.jsp) - 다음 번호 조회(단건조회) + 시스템으로부터 날짜
	public MemberBeans getMaxCustnoJoindate(){
		MemberBeans beans = new MemberBeans();//기본값으로 채워진 객체
		
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql
			sql = "select NVL(max(custno),0)+1 AS custno,";
			sql += " to_char(sysdate,'yyyymmdd') AS joindate";
			sql += " from member_tbl_02";
			
			//3. 실행
			ps = con.prepareStatement(sql);//컴파일된 sql을 가진 prepareStatement객체->속도가 빠르다.
			rs = ps.executeQuery();
			
			//4. 결과처리 -> '최대회원번호+1', '오늘날짜'로 셋팅된 객체로 변경 
			if(rs.next()) {
				beans.setCustno(rs.getString("custno"));//beans.setCustno(rs.getString(1));
				beans.setJoindate(rs.getString("joindate"));//beans.setJoindate(rs.getString(2));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}		
		return beans;
	}
	
	//2.회원등록(리턴타입:void)-insert.jsp에서 입력받은 데이터로 만든 MemberBeans객체를 DB의 member_tbl_02에 insert하는 작업
	/*
	public void insertMember(MemberBeans beans){
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql
			//sql = "insert into member_tbl_02(custno,custname,phone,address,joindate,grade,city) values(?,?,?,?,?,?,?)";
			//sql = "insert into member_tbl_02 values(?,?,?,?,to_char(?,'yyyy-mm-dd'),?,?)";
			sql = "insert into member_tbl_02 values(?,?,?,?,?,?,?)";
			
			//3. 실행
			ps = con.prepareStatement(sql);
			
			ps.setString(1, beans.getCustno());
			ps.setString(2, beans.getCustname());
			ps.setString(3, beans.getPhone());
			ps.setString(4, beans.getAddress());
			ps.setString(5, beans.getJoindate());
			ps.setString(6, beans.getGrade());
			ps.setString(7, beans.getCity());
			
			ps.executeUpdate();
			System.out.println("추가 성공");
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}		
	}
	*/
	
	//2.회원등록(리턴타입:int)-insert.jsp에서 입력받은 데이터로 만든 MemberBeans객체를 DB의 member_tbl_02에 insert하는 작업
	public int insertMember(MemberBeans beans){
		int result = 0;
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql
			//sql = "insert into member_tbl_02(custno,custname,phone,address,joindate,grade,city) values(?,?,?,?,?,?,?)";
			//sql = "insert into member_tbl_02 values(?,?,?,?,to_char(?,'yyyy-mm-dd'),?,?)";
			sql = "insert into member_tbl_02 values(?,?,?,?,?,?,?)";
			
			//3. 실행
			ps = con.prepareStatement(sql);
			
			ps.setString(1, beans.getCustno());
			ps.setString(2, beans.getCustname());
			ps.setString(3, beans.getPhone());
			ps.setString(4, beans.getAddress());
			ps.setString(5, beans.getJoindate());
			ps.setString(6, beans.getGrade());
			ps.setString(7, beans.getCity());
			
			result = ps.executeUpdate();//성공하면 1
			System.out.println("추가 성공");
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		
		return result;
	}
	
	//3. 회원전체조회-select.jsp
	public ArrayList<MemberBeans> getMembers(){
		ArrayList<MemberBeans> list = new ArrayList<MemberBeans>();//기본값인 null로 채워짐
		
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql
			sql += "select custno,custname,phone,address,";
			sql += " to_char(joindate,'yyyy-mm-dd') as joindate,";
			sql += " decode(grade,'A','VIP','B','일반','C','직원') as grade,";
			sql += " city";
			sql += " from member_tbl_02";
			
			//3. 실행
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();			
			
			//4. 결과처리
			while(rs.next()) {
				MemberBeans beans = new MemberBeans();//기본값으로 채워진 객체
				
				//beans객체의 멤버변수에 기본값이 아닌 ResultSet의 레코드의 값들로 채움
				beans.setCustno(rs.getString(1));
				beans.setCustname(rs.getString(2));
				beans.setPhone(rs.getString(3));
				beans.setAddress(rs.getString(4));
				beans.setJoindate(rs.getString(5));
				beans.setGrade(rs.getString(6));
				beans.setCity(rs.getString(7));
				
				list.add(beans);
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		
		
		return list;
	}
	
	//4.회원조회 - '회원번호(custno)를 매개값으로 받아 조회한 회원객체를 리턴 
	public MemberBeans getMember(String custno){//"100001"
		MemberBeans beans = new MemberBeans();//기본값으로 채워진 객체
		
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql
			sql += "select custname,phone,address,";
			sql += " to_char(joindate,'yyyy-mm-dd') as joindate,";
			sql += " grade, city";	
			sql += " from member_tbl_02";
			//sql += " where custno='"+custno+"'";//[방법-1] Statment
			sql += " where custno=?";//[방법-2] PrepareStatement
			
			//3. 실행
			ps = con.prepareStatement(sql);
			ps.setString(1, custno);//custno:매개변수
			rs = ps.executeQuery();			
			
			//4. 결과처리
			if(rs.next()) {//결과가 1개는 if문으로 처리					
				//beans객체의 멤버변수에 기본값이 아닌 ResultSet의 값들로 채움
				beans.setCustno(rs.getString(1));
				beans.setCustname(rs.getString(2));
				beans.setPhone(rs.getString(3));
				beans.setAddress(rs.getString(4));
				beans.setJoindate(rs.getString(5));
				beans.setGrade(rs.getString(6));
				beans.setCity(rs.getString(7));				
			}		
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		
		return beans;		
	}
	
	//5.회원수정(리턴타입:void)
	/*
	public void updateMember(MemberBeans beans){
		try {
			//1.connect (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2.sql			
			sql = "update member_tbl_02 set custname=?,phone=?,address=?,joindate=?,grade=?,city=? where custno=?";
			
			//3.실행
			ps = con.prepareStatement(sql);			
			
			ps.setString(1, beans.getCustname());
			ps.setString(2, beans.getPhone());
			ps.setString(3, beans.getAddress());
			ps.setString(4, beans.getJoindate());
			ps.setString(5, beans.getGrade());
			ps.setString(6, beans.getCity());
			ps.setString(7, beans.getCustno());
			
			ps.executeUpdate();
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			//5.연결해제
			try{
				if(con != null) con.close();				
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	*/
		
	//5. 회원수정 (리턴타입:int)
	public int updateMember(MemberBeans beans){
		int result = 0;
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql			
			sql = "update member_tbl_02 set custname=?,phone=?,address=?,joindate=?,grade=?,city=? where custno=?";
			
			//3. 실행
			ps = con.prepareStatement(sql);			
			
			ps.setString(1, beans.getCustname());
			ps.setString(2, beans.getPhone());
			ps.setString(3, beans.getAddress());
			ps.setString(4, beans.getJoindate());
			ps.setString(5, beans.getGrade());
			ps.setString(6, beans.getCity());
			ps.setString(7, beans.getCustno());
			
			result = ps.executeUpdate();//성공하면 1
			System.out.println("수정 성공");//콘솔창에 출력
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		
		return result;
	}
	
	//6.회원삭제 (리턴타입:void)
	/*
	public void deleteMember(MemberBeans beans){
		try {
			//1.connect (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2.sql			
			sql = "delete member_tbl_02 where custno=?";
			
			//3.실행
			ps = con.prepareStatement(sql);	
			ps.setString(1, beans.getCustno());
			
			ps.executeUpdate();
			
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			//5.연결해제
			try{
				if(con != null) con.close();				
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	*/
	
	//5. 회원삭제 (리턴타입:int)
	public int deleteMember(MemberBeans beans){
		int result = 0;
		try {
			//1. DB연결(=connect) (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2. sql			
			sql = "delete from member_tbl_02 where custno=?";
			
			//3. 실행
			ps = con.prepareStatement(sql);					
			ps.setString(1, beans.getCustno());
			
			result = ps.executeUpdate();//성공하면 1
			System.out.println("삭제 성공");//콘솔창에 출력
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			//5. 연결해제
			try {
				if(con != null) con.close();
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}	
		
		return result;
	}
	
	//7.매출전체조회 - select2.jsp
	public ArrayList<SalesBeans> getSales(){
		ArrayList<SalesBeans> list=new ArrayList<SalesBeans>();
		
		try {
			//1.connect (con:멤버변수)
			con = getConnection();//static 메서드이므로 바로 호출가능
			
			//2.sql
			sql += "select custno, custname, ";
			sql += " decode(grade,'A','VIP','B','일반','C','직원') as grade, ";
			//sql+=" sum(price) as totalprice	";
			sql += " to_char(sum(price),'L999,999,999') as totalprice";//L:지역통화,$
			sql += " from member_tbl_02 NATURAL JOIN money_tbl_02";
			sql += " group by custno, custname, decode(grade,'A','VIP','B','일반','C','직원')";
			sql += " order by 4 desc";
			
			//3.실행
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			//4.결과처리 
			while (rs.next()) {
				SalesBeans beans = new SalesBeans();//기본값으로 채워진 객체
				
				//beans객체의 멤버변수에 기본값이 아닌 ResultSet의 레코드의 값들로 채움
				beans.setCustno(rs.getString(1));
				beans.setCustname(rs.getString(2));
				beans.setGrade(rs.getString(3));
				beans.setTotalprice(rs.getString(4));				
			
				list.add(beans);
			}
		} catch (Exception e) {			
			e.printStackTrace();
		} finally {
			//5.연결해제
			try{
				if(con != null) con.close();				
				if(ps != null) ps.close();
				if(rs != null) rs.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return list;
	}
}








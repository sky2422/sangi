<%-- 혜-249~ 참조 --%>

<!-- insertPro.jsp 역할 : ShoppingDAO로 데이터를 넘기는 역할
insert.jsp에서 넘어온 데이터를 MemberBeans(=DTO)에 셋팅하여 
ShoppingDAO로 MemberBeans(=DTO)를 넘기는 역할-->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file = "dbcon.jsp" %> --%>  <!-- 소스 그대로 복사하여 포함 -->  

<%@ page import="member.*" %>

<%-- ★★순서 중요(1.utf-8로 인코딩 후 -> 2. 속성에 값 저장):순서 바뀌면 한글이 깨져서 나옴 --%>
<%-- 1.먼저 인코딩 적용 후 --%>
<%
request.setCharacterEncoding("utf-8");
%>

<%--member.MemberBeans클래스를 id="beans"라는 간단한 이름으로 변경하여 사용하겠다.
MemberBeans beans=new MemberBeans();"기본값으로 채워진 객체"
scope="page"(기본값 생략가능)--%>
<jsp:useBean id="beans" class="member.MemberBeans" scope="page"/>

<%-- 2. insert.jsp로부터 전달된 매개변수 이름과 MemberBeans객체에서 같은 이름의 속성(멤버변수)에 전달된 값 저장.
"insert.jsp로부터 전달받은 값으로 채워진 객체 변경됨"--%>
<jsp:setProperty property="" name="beans" property="*"/>

<%
 ShoppingDAO dao = new ShoppingDAO();
 //dao.insertMember(beans); //리턴 타입 :void로 처리
 int result = dao.insertMember(beans); //리턴 타입 :int로 처리
 if(result > 0) {
%>
	<script>
		alert("회원등록이 완료되었습니다.");
		location.href="select.jsp";
	</script>
<%	 
 }else{
%>
	<script>
		alert("회원등록이 완료되지 않았습니다.");
		//location.href="insert.jsp";
		history.back();//history.go(-1);
	</script>
<%		 
 }
%>





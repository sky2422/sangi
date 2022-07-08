<%@page import="java.util.TreeSet"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>헬스클럽관리</title>
</head>
<script type="text/javascript">
	function check(){
		if(f.memno.value==""){
			alert("회원번호를 입력해주세요.");
			return f.memno.focus();
		}
		if(f.mname.value==""){
			alert("회원이름을 입력해주세요.");
			return f.mname.focus();
		}
		if(f.tno[0].checked==false
		&& f.tno[1].checked==false
		&& f.tno[2].checked==false
		&& f.tno[3].checked==false){
			alert("트레이너를 선택해주세요.");
			return ;
		}
		if(f.joindate[0].checked==false
		&& f.joindate[1].checked==false
		&& f.joindate[2].checked==false
		&& f.joindate[3].checked==false){
			alert("선택시간을 선택해주세요.");
			return ;
		}
		f.submit();
	}
</script>
<body>
	<%@ include file="header.jsp" %>
		
	<%
	String memno = request.getParameter("memno");
	String mname = request.getParameter("mname");
	
	sql = "select tname||' '||ttime AS tnametime from trainer_tbl";
	rs = stmt.executeQuery(sql);
	
	if(!rs.next()){
		//System.out.print("등록된 트레이너가 없습니다.");//콘솔에 출력
	%>
		<script>
			alert("등록된 트레이너가 없습니다.");
		</script>
	<%	
	}		
	%>
	
	<section>
		<div>
			<h2>트레이너신청</h2>
		</div>
		<form method="post" action="insert2Pro.jsp" name="f">
			<table style="margin: 0 auto;" width="500" border="1">
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="memno" value="<%=memno %>" size="15" maxlength="4" readonly>(자동생성)</td>
				</tr>
				<tr>
					<th>회원이름</th>
					<td><input type="text" name="mname" value="<%=mname %>" size="25" maxlength="20" readonly>(자동생성)</td>
				</tr>
				<tr>
					<th>트레이너</th>
					<td>
						<select name="tno">
							<!-- <option value="01">김헬스 09:00~12:00</option>
							<option value="02">이헬스 12:00~15:00</option>
							<option value="03">박헬스 15:00~18:00</option>
							<option value="04">최헬스 18:00~21:00</option> -->
							
							<!-- 주의 : 반드시 do~while()문만 사용가능 -->
							<%
							int i = 1;
							do{
							%>
								<option value="0<%=i++%>"><%=rs.getString("tnametime")%></option>
							<%
								//i++;//++i;
							}while(rs.next());
							%>
						</select>
					</td>
				</tr>
				<tr>
					<th>선택시간</th>
					<td>
						<select name="ttime">
							<!-- <option value="09:00~12:00">09:00~12:00</option>
							<option value="12:00~15:00">12:00~15:00</option>
							<option value="15:00~18:00">15:00~18:00</option>
							<option value="18:00~21:00">18:00~21:00</option>  -->
							
							<!-- TreeSet : 중복제거, 정렬 -->
							<%@ page import="java.util.TreeSet" %>
							<%@ page import="java.util.Iterator" %>
							<%
							sql = "select ttime from trainer_tbl";
							rs = stmt.executeQuery(sql);
							
							TreeSet<String> allTime = new TreeSet<String>();
							
							String ttime = null;
							while(rs.next()){	
								ttime = rs.getString("ttime");
								allTime.add(ttime);
								System.out.println(ttime);//콘솔에 출력
							}
							System.out.println();//구분위한 빈줄
							
							Iterator itr = allTime.iterator();//반복자 생성
							while(itr.hasNext()){
								ttime = (String)itr.next();
							%>	
								<option value="<%=ttime%>"><%=ttime%></option>
							<%
							}
							%>
							
						</select>
						<br>
						(선택 트레이너의 담당시간을 선택해주세요.)
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="신청" onclick="check(); return false">
						<input type="button" value="조회" onclick="location='select.jsp'">
					</th>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="footer.jsp" %>
</body>
</html>
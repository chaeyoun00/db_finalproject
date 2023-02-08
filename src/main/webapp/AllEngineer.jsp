<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 본부</title>
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="css/search.css">
<style>
body { margin: 0px; }

div { float: left; }

hr { width: 90%; }
</style>
</head>
<body>
<div class="menu">
	<div class="profile">
		<%=session.getAttribute("id") %>
		<button onClick="location.href='Login.jsp'">로그아웃</button>
	</div>
	<hr color="#f1f1f1">
	<div class="menulist">
		<button type="button" id="Operation" class="menubutton" onClick="change_btn(event); location.href='Operation.jsp'">본부 관리</button><br>
		<button type="button" id="All" class="menubuttonactive" onClick="change_btn(event); location.href='AllEngineer.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileEngineer.jsp'">회원 정보 관리</button>
	</div>
</div>
<div class="main">
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "SELECT * FROM operation";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
	%>
	<div class="inform" style="padding-top: 10%;">
		<table id="headquarterTable">
		<tr>
			<th class="tableleft">Id</th>
			<th>Status</th>
			<th>Departure Status</th>
			<th>Arrival Status</th>
			<th>Update Time</th>
			<th>Train ID</th>
			<th>Engineer ID</th>
			<th class="tableright">TrainCode ID</th>
		</tr>
		<% while(result.next()) { %>
		<tr align="center">
			<td><%=result.getString("id") %></td>
			<td>
				<% if (result.getString("status").equals("1")) { %>
					정상
				<% } else {
				%> 고장 <%} %>
			</td>
			<td>
				<% if (result.getString("deptStatus").equals("0")) { %>
					준비중
				<% } else if (result.getString("deptStatus").equals("1")) {
				%> 정시 출발 
				<% } else {%> 지연 출발 <%} %>
			</td>
			<td>
				<% if (result.getString("arvStatus").equals("0")) { %>
					출발 전
				<% } else if (result.getString("arvStatus").equals("1")) {
				%> 운행 중 
				<% } else if (result.getString("arvStatus").equals("2")) {
				%> 정시 도착
				<% } else {%> 지역 도착 
				<% } %>
			</td>
			<td><%=result.getString("updateTime") %></td>
			<td><%=result.getString("trainId") %></td>
			<td><%=result.getString("engineerId") %></td>
			<td><%=result.getString("trainCodeId") %></td>
		</tr>
		<% } %>
		</table>
	</div>
</div>
<script>
function change_btn(e) {
	var btns = document.querySelectorAll(".menubutton");
 	btns.forEach(function (btn, i) {
		if (e.currentTarget == btn) {
			btn.classList.add("active");
		} else {
			btn.classList.remove("active");
		}
	});
	console.log(e.currentTarget);
}
</script>
</body>
</html>
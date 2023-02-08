<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
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
		<button type="button" id="Headquarter" class="menubutton" onClick="change_btn(event); location.href='Headquarter.jsp'">본부 관리</button><br>
		<button type="button" id="Station" class="menubutton" onClick="change_btn(event); location.href='Station.jsp'">역 관리</button><br>
		<button type="button" id="Train" class="menubutton" onClick="change_btn(event); location.href='Train.jsp'">기차 관리</button><br>
		<button type="button" id="Traincode" class="menubutton" onClick="change_btn(event); location.href='TrainCode.jsp'">기차 코드 관리</button><br>
		<button type="button" id="Line" class="menubutton" onClick="change_btn(event); location.href='Line.jsp'">라인 관리</button><br>
		<button type="button" id="Line" class="menubutton" onClick="change_btn(event); location.href='Connect.jsp'">연결 관리</button><br>
		<button type="button" id="Vehicle" class="menubutton" onClick="change_btn(event); location.href='Vehicle.jsp'">차량 관리</button><br>
		<button type="button" id="Engineer" class="menubutton" onClick="change_btn(event); location.href='Engineer.jsp'">엔지니어 관리</button><br>
		<button type="button" id="All" class="menubuttonactive" onClick="change_btn(event); location.href='All.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileManager.jsp'">회원 정보 관리</button>
	</div>
</div>
<div class="main">
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "SELECT id FROM Headquarter";
		String query1 = "";
		String query2 = "";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		ResultSet result1 = null;
		ResultSet result2 = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
	%>
	<div class="inform" style="font-size: small; color: #002366;">
		<h2>본부별 소속된 엔지니어의 수와 할당된 역의 개수</h2>
		<table id="headquartertable">
			<tr>
				<th class="tableleft">Headquarter ID</th>
				<th>Engineer의 수</th>
				<th class="tableright">Station의 수</th>
			</tr>
			<%
				while(result.next()) {
					query1 = "SELECT count(*) FROM engineer WHERE headquarterId=" + result.getString("id");
					result1 = stmt.executeQuery(query1);
					result1.next();
					query2 = "SELECT count(*) FROM station WHERE headquarterId=" + result.getString("id");
					result2 = stmt.executeQuery(query1);
					result2.next(); %>
			<tr align="center">
				<td><%=result.getString("id") %></td>
				<td><%=result1.getString("count(*)") %></td>
				<td><%=result2.getString("count(*)") %></td>
			</tr>
			<% } %>
		</table><br>
		<h2>라인별 역의 개수</h2>
		<%
			query = "SELECT id from line";
			result = stmt.executeQuery(query);
		%>
		<table id="lineid">
			<tr>
				<th class="tableleft">Line ID</th>
				<th class="tableright">Station의 수</th>
			</tr>
			<% while(result.next()) {
				query1 = "SELECT count(*) FROM connect WHERE lineid=" + result.getString("id");
				result1 = stmt.executeQuery(query1);
				result1.next();
				%>
			<tr align="center">
				<td><%=result.getString("id") %></td>
				<td><%=result1.getString("count(*)") %></td>
			</tr>
			<% } %>
		</table><br>
		<h2>기차에 연결된 차량의 수</h2>
		<%
		query = "SELECT id from train";
		result = stmt.executeQuery(query);
		%>
		<table id="train">
			<tr>
				<th class="tableleft">Train ID</th>
				<th class="tableright">Vehicle의 수</th>
			</tr>
			<% while(result.next()) {
				query1 = "SELECT count(*) FROM vehicle WHERE trainid=" + result.getString("id");
				result1 = stmt.executeQuery(query1);
				result1.next();
				%>
			<tr align="center">
				<td><%=result.getString("id") %></td>
				<td><%=result1.getString("count(*)") %></td>
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
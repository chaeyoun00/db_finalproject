<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="member.Encrypt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 관리자</title>
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="css/regist.css">
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
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='All.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubuttonactive" onClick="change_btn(event); location.href='ProfileManager.jsp'">회원 정보 관리</button>
	</div>
</div>
<%	
	Encrypt en = new Encrypt();

	String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
	String dbUser = "root";
	String dbPass = "1234";
	String query = "SELECT * FROM user WHERE id = '" + session.getAttribute("id") + "'";
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	result = stmt.executeQuery(query);
	
	result.next();
	String Userid = result.getString("id");
	String pw = result.getString("pw");
	pw = en.decrypt(pw);
	String role = result.getString("role");
	String name = result.getString("name");
%>
<div class="regist">
	<div class="backsearch">
		<button type="button" onClick="location.href='ProfileManager.jsp'"><</button>
	</div>
	<div class="registform">
		<form action="ProfileManagerModifyAction.jsp" method="post">
			ID<br>
			<input name="id" type="text" autocomplete="off" value="<%=Userid%>" readonly><br>
			Password<br>
			<input name="pw" type="password" autocomplete="off" value="<%=pw%>"><br>
			Role<br>
			<input name=role type="text" autocomplete="off" value="<%=role%>" readonly><br>
			Name<br>
			<input name="name" type="text" autocomplete="off" value="<%=name%>"><br>
			<button>수정하기</button>
		</form>
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
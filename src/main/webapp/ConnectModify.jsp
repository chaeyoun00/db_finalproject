<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 연결 등록</title>
<link rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="css/regist.css">
<link rel="stylesheet" href="css/popup.css">
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
		<button type="button" id="Line" class="menubuttonactive" onClick="change_btn(event); location.href='Connect.jsp'">연결 관리</button><br>
		<button type="button" id="Vehicle" class="menubutton" onClick="change_btn(event); location.href='Vehicle.jsp'">차량 관리</button><br>
		<button type="button" id="Engineer" class="menubutton" onClick="change_btn(event); location.href='Engineer.jsp'">엔지니어 관리</button><br>
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='All.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileManager.jsp'">회원 정보 관리</button>
	</div>
</div>
<%
	int lineid = Integer.parseInt(request.getParameter("lineid"));
	int stationid = Integer.parseInt(request.getParameter("stationid"));
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
	String dbUser = "root";
	String dbPass = "1234";
	String query = "SELECT * FROM connect WHERE " + lineid + "=" + lineid + " and stationId = " + stationid;
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	result = stmt.executeQuery(query);
	
	result.next();
	String line = result.getString("lineid");
	String station = result.getString("stationId");
%>
<div class="regist">
	<div class="backsearch">
		<button type="button" onClick="location.href='Connect.jsp'"><</button>
	</div>
	<div class="registform" style="margin-top: -5%">
		<form action="ConnectModifyAction.jsp" method="post">
			<input name="line" value="<%=line %>" style="visibility: hidden;">
			<input name="station" value="<%=station %>" style="visibility: hidden;">
			Line ID
			<div class="choose">
				<input name="lineId" id="lineId" type="text" autocomplete="off" value="<%=line %>" readonly>
				<a href="#popinfo" class="open">라인 목록</a>
				
				<div id="popinfo" class="modal">
					<div class="modal-content">
             			<span class="close">&times;</span>
             			<%
             				String query0 = "SELECT id, name FROM line";
	             			result = stmt.executeQuery(query0);             			
             			%>
             			<table id="lineTable" style="width: 95%; padding-top: 5px;">
							<tr>
								<th class="tableleft">Id</th>
								<th>Name</th>
								<th class="tableright">선택</th>
							</tr>
							<% while(result.next()) { %>
							<tr align="center">
								<td><%=result.getString("id") %></td>
								<td><%=result.getString("name") %></td>
								<td>
									<a href="#" onClick="choose_inform()">선택</a>
								</td>
							</tr>
							<% } %>
							</table>
		             </div>
				</div>
			</div>
			<br>
			Station ID
			<div class="choose">
				<input name="stationId" id="stationId" type="text" autocomplete="off" value="<%=station %>" readonly>
				<a href="#popinfo1" class="open1" style="padding: 6px 22px;">역 목록</a>
				
				<div id="popinfo1" class="modal1">
					<div class="modal-content">
						<span class="close1">&times;</span>
						<%
							String query2 = "SELECT id, name, address, tel FROM station";
							result = stmt.executeQuery(query2);	
						%>
						<table id="stationTable" style="width: 95%; padding-top: 5px;">
							<tr>
								<th class="tableleft">Id</th>
								<th>Name</th>
								<th>Address</th>
								<th>Tel</th>
								<th class="tableright">선택</th>
							</tr>
							<% while(result.next()) { %>
							<tr align="center">
								<td><%=result.getString("id") %></td>
								<td><%=result.getString("name") %></td>
								<td><%=result.getString("address") %></td>
								<td><%=result.getString("tel") %></td>
								<td>
									<a href="#" onClick="choose_station()">선택</a>
								</td>
							</tr>
							<% } %>
						</table>
					</div>
				</div>
			</div>
			<br>
			<button>등록하기</button>
		</form>
	</div>
</div>
<script>
var modal = document.querySelector(".modal");
var trigger = document.querySelector(".open");
var closeButton = document.querySelector(".close");

var modal1 = document.querySelector(".modal1");
var trigger1 = document.querySelector(".open1");
var closeButton1 = document.querySelector(".close1");

function toggleModal() {
    modal.classList.toggle("show-modal");
}

function toggleModal1() {
    modal1.classList.toggle("show-modal");
}

trigger.addEventListener("click", toggleModal);
closeButton.addEventListener("click", toggleModal);

trigger1.addEventListener("click", toggleModal1);
closeButton1.addEventListener("click", toggleModal1);

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

function choose_inform() {
	var table = document.getElementById('lineTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var number =this.cells[0].innerHTML;
				console.log(number);
				
				document.getElementById('lineId').value = number;
				modal.classList.toggle("show-modal");
			};
		}(row);
	} 
}

function choose_station() {
	var table = document.getElementById('stationTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var number =this.cells[0].innerHTML;
				console.log(number);
				
				document.getElementById('stationId').value = number;
				toggleModal1();
			};
		}(row);
	} 
}

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
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
<title>연세철도 연결</title>
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
		<button type="button" id="Line" class="menubuttonactive" onClick="change_btn(event); location.href='Connect.jsp'">연결 관리</button><br>
		<button type="button" id="Vehicle" class="menubutton" onClick="change_btn(event); location.href='Vehicle.jsp'">차량 관리</button><br>
		<button type="button" id="Engineer" class="menubutton" onClick="change_btn(event); location.href='Engineer.jsp'">엔지니어 관리</button><br>
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='All.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileManager.jsp'">회원 정보 관리</button>
	</div>
</div>
<div class="main">
	<div class="search">
		<form action="ConnectSearch.jsp" method="post">
			<select name="searchSelect">
				<option value="lineid">Line ID</option>
				<option value="stationid">Station ID</option>
			</select>
			<input name="keyword" type="number" autocomplete="off">
			<button>검색</button>
		</form>
	</div>
	<div class="goregist">
		연결 추가<button type="button" onClick="location.href='ConnectRegist.jsp'">+</button>
	</div>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "SELECT * FROM connect";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
	%>
	<div class="inform">
		<table id="connectTable">
		<tr>
			<th class="tableleft">Line ID</th>
			<th>Station ID</th>
			<th class="tableright">Setting</th>
		</tr>
		<% while(result.next()) { %>
		<tr align="center">
			<td><%=result.getString("lineId") %></td>
			<td><%=result.getString("stationId") %></td>
			<td>
				<button type="button" onClick="modify_inform()">수정</button>
				<button type="button" onClick="delete_inform()">삭제</button>
			</td>
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

function modify_inform() {
	var table = document.getElementById('connectTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var line =this.cells[0].innerHTML;
				var station =this.cells[1].innerHTML;
				console.log(line, station);
				
				location.href='ConnectModify.jsp?lineid=' + line + '&stationid=' + station;
			};
		}(row);
	}      
}

function delete_inform() {
	var check = confirm('정말로 삭제하시겠습니까?');
	if (check == true) {
		var table = document.getElementById('connectTable');
		var rowList = table.rows;
		
		for (i=1; i<rowList.length; i++) {    
			var row = rowList[i];
		      
			row.onclick = function(){ 
				return function(){ 
					var line =this.cells[0].innerHTML;
					var station =this.cells[1].innerHTML;
					console.log(line, station);
					
					location.href='ConnectDelete.jsp?lineid=' + line + '&stationid=' + station;
				};
			}(row);
		}    	
	}      
}
</script>
</body>
</html>
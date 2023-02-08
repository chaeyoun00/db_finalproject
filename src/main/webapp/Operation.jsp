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
		<button type="button" id="Operation" class="menubuttonactive" onClick="change_btn(event); location.href='Operation.jsp'">운행 기록 관리</button><br>
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='AllEngineer.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileEngineer.jsp'">회원 정보 관리</button>
	</div>
</div>
<div class="main">
	<div class="goregist">
		운행 기록 추가<button type="button" onClick="location.href='OperationRegist.jsp'">+</button>
	</div>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "SELECT * FROM engineer WHERE loginId = '" + session.getAttribute("id") + "'";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
		result.next();
		String id = result.getString("id");
		
		String query1 = "SELECT * FROM operation WHERE engineerId = " + id;
			
		Connection conn1 = null;
		Statement stmt1 = null;
		ResultSet result1 = null;
		
		conn1 = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt1 = conn1.createStatement();
		result1 = stmt1.executeQuery(query1);
	%>
	<div class="inform">
		<table id="operationTable">
		<tr>
			<th class="tableleft">Id</th>
			<th>Status</th>
			<th>Departure Status</th>
			<th>Arrival Status</th>
			<th>Update Time</th>
			<th>Train ID</th>
			<th>Engineer ID</th>
			<th>TrainCode ID</th>
			<th class="tableright">Setting</th>
		</tr>
		<% while(result1.next()) { %>
		<tr align="center">
			<td><%=result1.getString("id") %></td>
			<td>
				<% if (result1.getString("status").equals("1")) { %>
					정상
				<% } else {
				%> 고장 <%} %>
			</td>
			<td>
				<% if (result1.getString("deptStatus").equals("0")) { %>
					준비중
				<% } else if (result1.getString("deptStatus").equals("1")) {
				%> 정시 출발 
				<% } else {%> 지연 출발 <%} %>
			</td>
			<td>
				<% if (result1.getString("arvStatus").equals("0")) { %>
					출발 전
				<% } else if (result1.getString("arvStatus").equals("1")) {
				%> 운행 중 
				<% } else if (result1.getString("arvStatus").equals("2")) {
				%> 정시 도착
				<% } else {%> 지역 도착 
				<% } %>
			</td>
			<td><%=result1.getString("updateTime") %></td>
			<td><%=result1.getString("trainId") %></td>
			<td><%=result1.getString("engineerId") %></td>
			<td><%=result1.getString("trainCodeId") %></td>
			<td>
				<button type="button" onClick="modify_inform()">수정</button>
				<button type="button" onClick="delete_inform()">종료</button>
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
	var table = document.getElementById('operationTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var number =this.cells[0].innerHTML;
				console.log(number);
				
				location.href='OperationModify.jsp?id=' + number;
			};
		}(row);
	}      
}

function delete_inform() {
	var check = confirm('정말로 종료하시겠습니까?');
	if (check == true) {
		var table = document.getElementById('operationTable');
		var rowList = table.rows;
		
		for (i=1; i<rowList.length; i++) {    
			var row = rowList[i];
		      
			row.onclick = function(){ 
				return function(){ 
					var number =this.cells[0].innerHTML;
					console.log(number);
					
					location.href='OperationDelete.jsp?id=' + number;
				};
			}(row);
		}    	
	}      
}
</script>
</body>
</html>
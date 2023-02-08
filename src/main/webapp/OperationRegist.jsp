<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		<button type="button" id="Operation" class="menubuttonactive" onClick="change_btn(event); location.href='Operation.jsp'">운행 기록 관리</button><br>
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='AllEngineer.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileEngineer.jsp'">회원 정보 관리</button>
	</div>
</div>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
	String dbUser = "root";
	String dbPass = "1234";
	String query = "SELECT id from operation order by id asc";
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	result = stmt.executeQuery(query);
	
	String flag = "";
	while(result.next()) {
		flag = result.getString("id");
	}
	int id = 1 + Integer.parseInt(flag);
	
%>
<div class="regist">
	<div class="backsearch">
		<button type="button" onClick="location.href='Operation.jsp'"><</button>
	</div>
	<div class="registform">
		<form action="OperationRegistAction.jsp" method="post">
			ID<br>
			<input name="id" type="text" autocomplete="off" value="<%=id%>" readonly><br>
			Status<br>
			<select name="status">
				<option value="">--선택하시오--</option>
				<option value="0">고장</option>
				<option value="1">정상</option>
			</select>
			Departure Status<br>
			<select name="deptStatus">
				<option value="">--선택하시오--</option>
				<option value="0">준비 중</option>
				<option value="1">정시 출발</option>
				<option value="2">지연 출발</option>
			</select>
			Arrival Status<br>
			<select name="arvStatus">
				<option value="">--선택하시오--</option>
				<option value="0">출발 전</option>
				<option value="1">운행 중</option>
				<option value="2">정시 도착</option>
				<option value="3">지연 도착</option>
			</select>
			Update Time<br>
			<input name="updateTime" type="text" autocomplete="off">
			Train ID<br>
			<div class="choose">
				<input name="train" id="train" type="text" autocomplete="off" readonly>
				<a href="#popinfo" class="open">기차 목록</a>
				
				<div id="popinfo" class="modal">
					<div class="modal-content">
						<span class="close">&times;</span>
						<%
	             			String query0 = "SELECT trainid FROM operation";
	             			String query1 = "SELECT * FROM train";
	             			
	             			result = stmt.executeQuery(query0);
	             			
	             			ArrayList<String> list = new ArrayList<>();
	             			while (result.next()) {
	             				list.add(result.getString("trainid"));
	             			}
	             			
	             			result = stmt.executeQuery(query1);
             			%>
             			
             			<table id="trainTable" style="width: 95%; padding-top: 5px;">
             				<tr>
								<th class="tableleft">Id</th>
								<th>Type</th>
								<th>Status</th>
								<th class="tableright">선택</th>
							</tr>
							<% while(result.next()) { 
								if (list.contains(result.getString("id"))) {
									continue;
								}
								else {
							%>
								<tr align="center">
									<td><%=result.getString("id") %></td>
									<td><%=result.getString("type") %></td>
									<td><%=result.getString("status") %></td>
									<td>
										<a href="#" onClick="choose_inform()">선택</a>
									</td>
								</tr>
							<% }
							} %>
             			</table>
					</div>
				</div>
			</div>
			<%
				query1 = "SELECT * FROM engineer WHERE loginId = '" + session.getAttribute("id") + "'";
				result = stmt.executeQuery(query1);				
				result.next();
			%>
			Engineer ID
			<input name="engineerId" type="text" autocomplete="off" value="<%=result.getString("id")%>" readonly><br>
			TrainCode ID
			<div class="choose">
				<input name="trainCode" id="trainCode" type="text" autocomplete="off" readonly>
				<a href="#popinfo1" class="open1">코드 목록</a>
				
				<div id="popinfo1" class="modal1">
					<div class="modal-content">
						<span class="close1">&times;</span>
						<%
							String query2 = "SELECT id, code, startStation, endStation FROM TrainCode";
							result = stmt.executeQuery(query2);	
						%>
						<table id="trainCodeTable" style="width: 95%; padding-top: 5px;">
							<tr>
								<th class="tableleft">Id</th>
								<th>Code</th>
								<th>Start Station</th>
								<th>End Station</th>
								<th class="tableright">선택</th>
							</tr>
							<% while(result.next()) { %>
							<tr align="center">
								<td><%=result.getString("id") %></td>
								<td><%=result.getString("code") %></td>
								<td><%=result.getString("startStation") %></td>
								<td><%=result.getString("endStation") %></td>
								<td>
									<a href="#" onClick="choose_trainCode()">선택</a>
								</td>
							</tr>
							<% } %>
						</table>
					</div>
				</div>
			</div><br>
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

function choose_inform() {
	var table = document.getElementById('trainTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var number =this.cells[0].innerHTML;
				console.log(number);
				
				document.getElementById('train').value = number;
				modal.classList.toggle("show-modal");
			};
		}(row);
	} 
}

function choose_trainCode() {
	var table = document.getElementById('trainCodeTable');
	var rowList = table.rows;
	
	for (i=1; i<rowList.length; i++) {    
		var row = rowList[i];
	      
		row.onclick = function(){ 
			return function(){ 
				var number =this.cells[0].innerHTML;
				console.log(number);
				
				document.getElementById('trainCode').value = number;
				/* modal1.classList.toggle("show-modal1"); */
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
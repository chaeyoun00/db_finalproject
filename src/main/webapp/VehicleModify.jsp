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
<title>연세철도 차량 수정</title>
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
		<button type="button" id="Line" class="menubutton" onClick="change_btn(event); location.href='Connect.jsp'">연결 관리</button><br>
		<button type="button" id="Vehicle" class="menubuttonactive" onClick="change_btn(event); location.href='Vehicle.jsp'">차량 관리</button><br>
		<button type="button" id="Engineer" class="menubutton" onClick="change_btn(event); location.href='Engineer.jsp'">엔지니어 관리</button><br>
		<button type="button" id="All" class="menubutton" onClick="change_btn(event); location.href='All.jsp'">전체 보기</button>
		<button type="button" id="Profile" class="menubutton" onClick="change_btn(event); location.href='ProfileManager.jsp'">회원 정보 관리</button>
	</div>
</div>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
	String dbUser = "root";
	String dbPass = "1234";
	String query = "SELECT * FROM vehicle WHERE id = " + id;
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	result = stmt.executeQuery(query);
	
	result.next();
	String Userid = result.getString("id");
	String type = result.getString("type");
	String model = result.getString("model");
	String year = result.getString("year");
	String status = result.getString("status");
	String train = result.getString("trainid");
%>
<div class="regist">
	<div class="backsearch">
		<button type="button" onClick="location.href='Vehicle.jsp'"><</button>
	</div>
	<div class="registform">
		<form action="VehicleModifyAction.jsp" method="post">
			ID<br>
			<input name="id" type="text" autocomplete="off" value="<%=Userid%>"><br>
			Type<br>
			<input name="type" type="text" autocomplete="off" value="<%=type%>"><br>
			Model<br>
			<input name="model" type="text" autocomplete="off" value="<%=model%>"><br>
			Year<br>
			<input name="year" type="text" autocomplete="off" value="<%=year%>"><br>
			Status<br>
			<select name="status">
				<option>--선택하시오--</option>
				<option value="0" <% if (status.equals("0")) {%>selected<%}%>>고장</option>
				<option value="1" <% if (status.equals("1")) {%>selected<%}%>>정상</option>
			</select><br>
			Train<br>
			<div class="choose">
				<input name="train" id="train" type="text" autocomplete="off" value="<%=train%>" readonly>
				<a href="#popinfo" class="open">기차 목록</a>
				
				<div id="popinfo" class="modal">
					<div class="modal-content">
             			<span class="close">&times;</span>
             			<%
	             			query = "SELECT id, type FROM train";
	             			result = stmt.executeQuery(query);           			
             			%>
             			<table id="trainTable" style="width: 95%; padding-top: 5px;">
							<tr>
								<th class="tableleft">Id</th>
								<th>Type</th>
								<th class="tableright">선택</th>
							</tr>
							<% while(result.next()) { %>
							<tr align="center">
								<td><%=result.getString("id") %></td>
								<td><%=result.getString("type") %></td>
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
			<button>수정하기</button>
		</form>
	</div>
</div>
<script>
var modal = document.querySelector(".modal");
var trigger = document.querySelector(".open");
var closeButton = document.querySelector(".close");

function toggleModal() {
    modal.classList.toggle("show-modal");
}

function windowOnClick(event) {
    if (event.target === modal) {
        toggleModal();
    }
}

trigger.addEventListener("click", toggleModal);
closeButton.addEventListener("click", toggleModal);
window.addEventListener("click", windowOnClick);

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
</script>
</body>
</html>
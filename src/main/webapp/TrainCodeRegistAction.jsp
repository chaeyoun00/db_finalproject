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
<title>연세철도 기차코드 등록</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		String code = request.getParameter("code");
		String day = request.getParameter("day");
		String line = request.getParameter("lineId");
		String startStation = request.getParameter("startStation");
		String startTime = request.getParameter("startTime");
		String endStation = request.getParameter("endStation");
		String endTime = request.getParameter("endTime");
		
		if (code == "") {
			script.println("<script>");
			script.println("alert('코드가 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (day == "") {
			script.println("<script>");
			script.println("alert('요일이 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (line == "") {
			script.println("<script>");
			script.println("alert('라인이 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (startStation == "") {
			script.println("<script>");
			script.println("alert('시작 역이 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (startTime == "") {
			script.println("<script>");
			script.println("alert('시작 시간이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (endStation == "") {
			script.println("<script>");
			script.println("alert('종착 역이 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (endTime == "") {
			script.println("<script>");
			script.println("alert('마지막 시간이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		if (startStation.equals(endStation)) {
			script.println("<script>");
			script.println("alert('시작 역과 종착역이 같으면 안됩니다. 다시 선택해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "INSERT INTO trainCode VALUES(" + id + ", '" + code + "', '" + 
				day + "', '" + line + "', '" + startStation + "', '" + startTime + 
				"', '" + endStation + "', '" + endTime + "')";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
	} catch (Exception e) {
		script.println("<script>");
		script.println("alert('입력이 완료되지 않았거나 오류가 생겼습니다. 다시 시도해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} finally {
		try {
			result.close();
			stmt.close();
			conn.close();
			response.sendRedirect("TrainCode.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
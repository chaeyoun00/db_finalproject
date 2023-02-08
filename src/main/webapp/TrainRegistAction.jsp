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
<title>연세철도 기차 등록</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	ResultSet result1 = null;
	
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		String type = request.getParameter("type");
		String status = request.getParameter("status");
		
		if (type == "") { 
			script.println("<script>");
			script.println("alert('type이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (status == "") { 
			script.println("<script>");
			script.println("alert('상태가 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "INSERT INTO train VALUES(" + id + ", '" + type + "', " + status + ")";
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
		query = "SELECT count(*) from vehicle";
		result = stmt.executeQuery(query);
		
		result.next();
		int vehicleid = 1 + Integer.parseInt(result.getString("count(*)"));
		
		query = "INSERT INTO vehicle (id, type, status, trainid) VALUES(" + vehicleid  + ", '기관차', 1, " + id + ")";
		result1 = stmt.executeQuery(query);
		
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
			response.sendRedirect("Train.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
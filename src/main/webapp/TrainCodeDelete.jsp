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
<title>연세철도 기차코드 삭제</title>
</head>
<body>
	<%
		int id = Integer.parseInt(request.getParameter("id"));
	
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "DELETE FROM traincode WHERE id = " + id;
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
		response.sendRedirect("TrainCode.jsp");
	%>
<script>
</script>
</body>
</html>
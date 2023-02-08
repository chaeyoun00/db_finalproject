<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 엔지니어 수정 Action</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		int year = Integer.parseInt(request.getParameter("year"));
		String variety = request.getParameter("variety");
		String amount = request.getParameter("amount");
		String headquarter = request.getParameter("headquarter");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "UPDATE engineer SET name = '" + name + "', year = " + year + 
				", variety = '" + variety + "', amount = '" + amount +
				"', headquarterId = '" + headquarter + "' " + "WHERE id = " + id;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		script.println("<script>");
		script.println("alert('입력이 완료되지 않았거나 오류가 생겼습니다. 다시 시도해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} finally {
		try {
			pstmt.close();
			conn.close();
			response.sendRedirect("Engineer.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
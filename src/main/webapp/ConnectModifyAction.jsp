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
<title>연세철도 본부 수정 Action</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		String line = request.getParameter("line");
		String station = request.getParameter("station");
		String lineId = request.getParameter("lineId");
		String stationId = request.getParameter("stationId");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "UPDATE Connect SET lineId=" + lineId + ", stationId=" + stationId +
				" WHERE lineId=" + line + " and stationId=" + station;

		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		script.println("<script>");
		script.println("alert('이미 등록된 내용이거나 오류가 생겼습니다. 다시 시도해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} finally {
		try {
			pstmt.close();
			conn.close();
			response.sendRedirect("Connect.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
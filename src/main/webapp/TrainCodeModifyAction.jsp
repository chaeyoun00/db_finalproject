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
		int id = Integer.parseInt(request.getParameter("id"));
		String code = request.getParameter("code");
		String day = request.getParameter("day");
		String line = request.getParameter("lineId");
		String startStation = request.getParameter("startStation");
		String startTime = request.getParameter("startTime");
		String endStation = request.getParameter("endStation");
		String endTime = request.getParameter("endTime");
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "UPDATE trainCode SET code = '" + code + "', day = '" + day + 
				"', lineId = '" + line + "', startStation = '" + startStation + "', startTime = '" +
				startTime + "', endStation = '" + endStation + "', endTime = '" + endTime + "' WHERE id = " + id;
		
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
			response.sendRedirect("TrainCode.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
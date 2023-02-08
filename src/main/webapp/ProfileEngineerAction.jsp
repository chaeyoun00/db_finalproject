<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.PreparedStatement" %>
<%@page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="member.Encrypt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 엔지니어</title>
</head>
<body>
<%
	Encrypt en = new Encrypt();
	
	PrintWriter script = response.getWriter();
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt1 = null;
	
	try {		
		String id = request.getParameter("id");
		String year = request.getParameter("year");
		String variety = request.getParameter("variety");
		String amount = request.getParameter("amount");
		String headquarter = request.getParameter("headquarter");
		
		String login = request.getParameter("login");
		String loginid = request.getParameter("loginid");
		String pw = request.getParameter("pw");
		String role = request.getParameter("role");
		String name = request.getParameter("name");
		
		String enpw = en.encrypt(pw);
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "UPDATE user SET id = '" + loginid + "', pw = '" + enpw + "', role = '" + role + 
				"', name = '" + name + "' WHERE id = '" + login + "'";
		
		String query1 = "UPDATE engineer SET name = '" + name + "', year = " + year + 
				", variety = '" + variety + "', amount = '" + amount +
				"', headquarterId = '" + headquarter + "', loginid ='" + loginid + "' WHERE id = " + id;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		pstmt = conn.prepareStatement(query);
		pstmt.executeUpdate();
		
		pstmt1 = conn.prepareStatement(query1);
		pstmt1.executeUpdate();
	
		
	} catch (Exception e) {
		script.println("<script>");
		script.println("alert('입력이 완료되지 않았거나 오류가 생겼습니다. 다시 시도해주세요.')");
		script.println("history.back()");
		script.println("</script>");
	} finally {
		try {
			pstmt.close();
			conn.close();
			script.println("<script>");
			script.println("alert('회원 정보가 변경되었습니다.')");
			script.println("location.href='Logout.jsp'");
			script.println("</script>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
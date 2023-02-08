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
<title>연세철도 본부 등록</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		String planet = request.getParameter("planet");
		String continent = request.getParameter("continent");
		String mName = request.getParameter("managerName");
		String tel = request.getParameter("tel");
		String budget = request.getParameter("budget");
		
		if (name == "") { 
			script.println("<script>");
			script.println("alert('이름이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (planet == "") { 
			script.println("<script>");
			script.println("alert('행성이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (mName == "") { 
			script.println("<script>");
			script.println("alert('매니저 이름이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (tel == "") { 
			script.println("<script>");
			script.println("alert('전화번호가 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (budget == "") { 
			script.println("<script>");
			script.println("alert('예산이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "INSERT INTO headquarter VALUES(" + id + ", '" + name + "', '" + 
		planet + "', '" + continent + "', '" + mName + "', '" + tel + "', " + budget + ")";
		
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
			response.sendRedirect("Headquarter.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>
</body>
</html>
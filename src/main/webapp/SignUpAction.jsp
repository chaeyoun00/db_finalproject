<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="member.Encrypt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 엔지니어 등록</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	Encrypt en = new Encrypt();
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	try {
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
	    String dbUser = "root";
	    String dbPass = "1234";
		String query = "";
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		
		if (id == "") { 
	         script.println("<script>");
	         script.println("alert('이름이 입력되지 않았습니다.')");
	         script.println("history.back()");
	         script.println("</script>");
		}
		else if (pw == "") { 
	         script.println("<script>");
	         script.println("alert('년도가 입력되지 않았습니다.')");
	         script.println("history.back()");
	         script.println("</script>");
		}
		else if (name == "") { 
	         script.println("<script>");
	         script.println("alert('연봉이 입력되지 않았습니다.')");
	         script.println("history.back()");
	         script.println("</script>");
		}
		
		pw = en.encrypt(pw);
		query = "INSERT INTO user VALUES('" + id + "', '" + pw + "', 'm', '" + name + "')";		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
	} catch (Exception e) {
		script.println("<script>");
		script.println("alert('중복된 아이디가 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} finally {
		try {
			result.close();
			stmt.close();
			conn.close();
			response.sendRedirect("Login.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
%>
</body>
</html>
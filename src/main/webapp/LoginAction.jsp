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
<title>연세철도 로그인 Action</title>
</head>
<body>
	<%
		Encrypt en = new Encrypt();
	
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		if (id == "" || pw == "") {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID 또는 PW를 입력하세요.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "SELECT id, pw, role FROM user WHERE id = '" + id + "'";
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		result = stmt.executeQuery(query);
		
		String redirect = null;
		String enpw = null;
		while (result.next()) {
			enpw = en.decrypt(result.getString("pw"));
			if (result.getString("id").equals(id) && enpw.equals(pw)) {
				session.setAttribute("id", id);
				if (result.getString("role").equals("m")) {
					redirect = "Headquarter.jsp";
					session.setAttribute("role", "m");
				}
				else if (result.getString("role").equals("e")) {
					redirect = "Operation.jsp";
				}
				break;
			}
		}
		
		if (redirect != null) {
			response.sendRedirect(redirect);
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID 또는 PW가 틀렸습니다. 다시 입력해주세요.')");
			script.println("location.href='Login.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>
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
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
    String dbUser = "root";
    String dbPass = "1234";
	String query = "";
	
	int id = Integer.parseInt(request.getParameter("id"));
	String name = request.getParameter("name");
	String year = request.getParameter("year");
	String variety = request.getParameter("variety");
	String amount = request.getParameter("amount");
	String headquarter = request.getParameter("headquarter");
	
	if (name == "") { 
         script.println("<script>");
         script.println("alert('이름이 입력되지 않았습니다.')");
         script.println("history.back()");
         script.println("</script>");
	}
	else if (year == "") { 
         script.println("<script>");
         script.println("alert('년도가 입력되지 않았습니다.')");
         script.println("history.back()");
         script.println("</script>");
	}
	else if (variety == "") {
		script.println("<script>");
		script.println("alert('부서가 입력되지 않았습니다.')");
		script.println("history.back()");
		script.println("</script>");

	}
	else if (amount == "") { 
         script.println("<script>");
         script.println("alert('연봉이 입력되지 않았습니다.')");
         script.println("history.back()");
         script.println("</script>");
	}
	else if (headquarter == "") { 
         script.println("<script>");
         script.println("alert('본부가 선택되지 않았습니다.')");
         script.println("history.back()");
         script.println("</script>");
	}
	
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	
	String pw = en.encrypt("0000");
	
	query = "INSERT INTO user VALUES('" + id + "', '" + pw + "', 'e', '" + name + "')";		
	result = stmt.executeQuery(query);
	
	query = "INSERT INTO engineer VALUES(" + id + ", '" + name + "', '" + year + "', '" +
		variety + "', '" + amount + "', '" + headquarter + "', '" + id + "')";
	result = stmt.executeQuery(query);

	response.sendRedirect("Engineer.jsp");
	
%>
</body>
</html>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>����ö�� �α׾ƿ�</title>
</head>
<body>
	<%
		session.removeAttribute("id");
		session.removeAttribute("role");
		response.sendRedirect("Login.jsp");
	%>
</body>
</html>
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
<title>연세철도 차량 등록</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	
	try {
		int id = Integer.parseInt(request.getParameter("id"));
		String type = request.getParameter("type");
		String model = request.getParameter("model");
		String year = request.getParameter("year");
		String status = request.getParameter("status");
		String train = request.getParameter("train");
		
		if (type == "") { 
			script.println("<script>");
			script.println("alert('유형이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (model == "") { 
			script.println("<script>");
			script.println("alert('모델이 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (year == "") { 
			script.println("<script>");
			script.println("alert('년도가 입력되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (status == "") { 
			script.println("<script>");
			script.println("alert('상태가 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if (train == "") { 
			script.println("<script>");
			script.println("alert('기차가 선택되지 않았습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/yonseirail";
		String dbUser = "root";
		String dbPass = "1234";
		String query = "INSERT INTO vehicle VALUES(" + id  + ", '" + type + "', '" + model + "', '" + year + "','" +  status + "','" + train + "');";
		
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
			response.sendRedirect("Vehicle.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%>

</body>
</html>
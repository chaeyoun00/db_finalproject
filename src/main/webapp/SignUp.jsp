<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>연세철도 회원가입</title>
<style>
body {
  margin: 0;
  background: url(train.jpg) no-repeat center center fixed;
  background-size: cover;
}

.wrapper {
	 display: flex;
	 justify-content: center;
	 align-items: center;
	 min-height: 100vh;
}

.logincard {
	box-shadow: 0px 1px 5px #0000004D;
	border-radius: 13px;
	
	width: 400px;
	height: 500px;
 	padding: 50px;
 	
  	font-weight: 900;
  	font-size: 20px;
  	text-align: center;
  	background-color: #ffffff;
  	color: #002366;
}

.logincard button {
	margin: 0;
	padding: 0.5rem 1rem;
	
	font-family: "Noto Sans KR", sans-serif;
	font-size: 1rem;
	font-weight: 400;
	text-align: center;
	text-decoration: none;
	
	display: inline-block;
	width: 300px;
	height: 50px;
	
	border: none;
	border-radius: 4px;
	
	box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
	cursor: pointer;
	transition: 0.5s;
	
	background: #002366;
	color: #ffffff;
}

.logincard input {
	font-family: "Noto Sans KR", sans-serif;
	font-size: 15px;
	width: 300px;
	height: 40px;
	background-color: #f1f1f1;
	border: 0px;
}

hr {
	width: 350px;
	margin-top: 30px;
	margin-bottom: 20px;
}

.logincard .signup {
	background: #ffffff;
	color: #a3a3a3;
	box-shadow: 0 0 0 0;
	padding: 0px;
	width: 100px;
	height: 30px;
}
</style>
</head>
<body>
<div class="wrapper">
  <div class="logincard">
  	<h3>SIGN UP</h3><br>
  	<form action="SignUpAction.jsp" method="post">
  		<input name="id" type="text" autocomplete="off" placeholder="ID"><br><br>
  		<input name="pw" type="password" placeholder="PW"><br><br>
  		<input name="role" type="text" value="관리자" readonly><br><br>
  		<input name="name" type="text" autocomplete="off" placeholder="Name"><br><br>
  		<button>가입하기</button>
  	</form>
  	<hr color="#cdcdcd">
  	<button type="button" class="signup" onClick="location.href='Login.jsp'">취소</button>
  </div>
</div>
</body>
</html>
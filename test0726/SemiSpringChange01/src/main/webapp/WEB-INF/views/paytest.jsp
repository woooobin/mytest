<%@page import="com.spring.poosil.bookduck.paydto.PayDto"%>
<%@page import="com.spring.poosil.logindto.LoginDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</head>


<body>
	<form action="insertpay.do" method="post">
	
	<div>
		<h3>ID</h3>
		<span> 
			<input type="text" id="memberid" name="memberid" class="int" value="유저아이디" />
		</span>
	</div>
	<div>
		<h3>결제 금액</h3>
		<span> 
			<input id="pay_price" name="pay_price"value="1000" />
		</span>
	</div>
	<div >
		<input type="submit" value="결제" />
	</div>
</form>

</body>
</html>
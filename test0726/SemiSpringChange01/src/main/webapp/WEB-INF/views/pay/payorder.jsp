
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
			<input type="text" name="pay_id" />
		</span>
	</div>
	<div>
		<h3>결제 금액</h3>
		<span> 
			<input name="pay_price" value="5000" />
			<input type="button" value="취소" onclick="location.href='paycancel.do'"/>
		</span>
	</div>
	<div >
		<input type="submit" value="결제" />
	</div>
</form>

</body>
</html>
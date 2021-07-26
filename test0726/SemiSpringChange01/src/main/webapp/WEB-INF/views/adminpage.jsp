<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1">
			<tr>
				<th>ID</th>
				<td>${dto.userid }</td>
			</tr>
			<tr>
				<th>NAME</th>
				<td>${dto.username }</td>
			</tr>
			<tr>
				<th>NICKNAME</th>
				<td>${dto.usernickname }</td>
			</tr>
			
		</table>
		<a href="logout.do">logout</a>
</body>
</html>
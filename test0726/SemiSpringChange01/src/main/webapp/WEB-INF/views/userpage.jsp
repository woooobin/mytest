<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
	response.setHeader("Cache-Control","no-store"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader("Expires",0); 
	if (request.getProtocol().equals("HTTP/1.1")) 
		response.setHeader("Cache-Control", "no-cache"); 
%>


<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ page session="false" %>


<%
 HttpSession session = request.getSession(false);//세션이 없으면 새로 자동 생성 못하게 한다.

 if(session==null){                //세션이 없는 경우. 혹은 해제된 경우
%>
 <script type="text/javascript">
  location.href="loginfrom.do";     //로그인 창을 띄울 수있도록 페이지를 이동.
 </script>
<%}else{%>                          <!-- //세션이 있는 경우 -->
 <script type="text/javascript">
  location.href="login.do";  //간략한 사용자의 정보를 표시 할수 있도록 페이지를 이동. 
 </script>
<%}%>

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
	<a href="enabledout.do?userid=${dto.userid }">회원탈퇴</a>


</body>
</html>
<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>addPlaylist</title>
<base href ="${pageContext.servletContext.contextPath }/">
</head>
<body>
<form:form action="/SpotifyWeb/audience/library/addplaylist.htm" method="POST">
	<input type="text" name="namePlaylist">
	<input type="radio" id="Public" name="isPublic?" value= True>
	<input type="radio" id="Private" name="isPublic?" value= False>
	<input type="text" name="status">
	<input type="submit">
</form:form>
</body>
</html>
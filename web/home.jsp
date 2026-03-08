<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <%@include file="head.jspf"%>
    </head>
    <body class="darkmode">
        <c:set var="activePage" value="home"/>
        <%@include file="navbar.jspf"%>
    </body>
</html>

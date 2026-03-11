<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <%@include file="../head.jspf"%>
    </head>
    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="dashboard"/>
        <div class="container-fluid">
            <div class="row">
                <%@include file="sidebar.jspf"%>

                <!--Main content-->
                <div style="margin-left:180px;" class="col p-4">
                    
                </div>
            </div
        </div>
    </body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Choose Destination</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gateway.css"/>
        <%@include file="../head.jspf"%>
    </head>
    <body class="darkmode">

        <c:set var="activePage" value="hub"/>
        <%@include file="../navbar.jspf"%>

        <div class="gateway-page">

            <div class="gateway-main-card">

                <!-- HEADER -->
                <div class="gateway-header">

                    <img src="${pageContext.request.contextPath}/images/icons/admin-icon.png" width="60">

                    <h2>Admin Portal</h2>

                    <p class="text-secondary">
                        Choose where you want to go
                    </p>

                </div>


                <!-- OPTIONS -->
                <div class="gateway-options">

                    <!-- STORE -->
                    <a href="${pageContext.request.contextPath}/home" class="gateway-option">

                        <img src="${pageContext.request.contextPath}/images/icons/store-icon.png">

                        <div>
                            <h4>Visit Store</h4>
                            <p>Take a look at the website</p>
                        </div>

                    </a>


                    <!-- MANAGEMENT -->
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="gateway-option">

                        <img src="${pageContext.request.contextPath}/images/icons/admin-icon.png">

                        <div>
                            <h4>Management Dashboard</h4>
                            <p>Manage products, orders and users</p>
                        </div>

                    </a>

                </div>

            </div>

        </div>

    </body>
</html>
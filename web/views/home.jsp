<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="darkmode">
        <c:set var="activePage" value="home"/>
        <%@include file="navbar.jspf"%>
        <div class="container mt-5">
            <div class="p-4 rounded-4 shadow-sm bg-dark text-center mb-4">
                <img src="${pageContext.request.contextPath}/images/welcome.png"
                     class="img-fluid mb-4"
                     alt="Welcome illustration">

                <h1 class="fw-bold mb-4">Welcome to the Product Manager!</h1>
                <p class="fs-6">
                    Manage products, categories, and accounts in one place
                </p>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/auth?type=product&action=list"
                       class="text-decoration-none text-white">
                        <div class="card card-hover bg-dark h-100 shadow-sm text-white rounded-3">
                            <div class="card-body text-center">
                                <h5 class="card-title">Products</h5>
                                <p class="card-text">
                                    View, add, update, and manage products
                                </p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/auth?type=category&action=list"
                       class="text-decoration-none text-white">
                        <div class="card card-hover bg-dark h-100 shadow-sm text-white rounded-3">
                            <div class="card-body text-center">
                                <h5 class="card-title">Categories</h5>
                                <p class="card-text">
                                    View, add, update, and manage categories
                                </p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/auth?type=account&action=list"
                       class="text-decoration-none text-white">
                        <div class="card card-hover bg-dark h-100 shadow-sm text-white rounded-3">
                            <div class="card-body text-center">
                                <h5 class="card-title">Accounts</h5>
                                <p class="card-text">
                                    Manage user accounts and roles
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
            <div class='text-center mt-4'>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <p class="fs-5 fw-bold">Please log in to manage your products. <span><a href='${pageContext.request.contextPath}/login'>Sign in here</a></span></p>
                    </c:when>
                    <c:otherwise>
                        <p class="fs-5 fw-bold">
                            Glad to see you back, ${sessionScope.user.firstName}!
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>
    </body>
</html>

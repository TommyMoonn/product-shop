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
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid">
            <div class="row">
                <%@include file="sidebar.jspf"%>

                <!--Main content-->
                <div style="margin-left:180px;" class="col p-4">
                    <div class="p-4 rounded-4 shadow-sm bg-dark text-center mb-4">
                        <img src="${pageContext.request.contextPath}/images/welcome.png"
                             class="img-fluid mb-4"
                             alt="Welcome illustration">

                        <h1 class="fw-bold mb-4">Shop Management Dashboard</h1>
                        <p class="fs-6">
                            Manage products, categories, and accounts in one place
                        </p>
                    </div>

                    <div class="row g-4">

                        <div class="col-12 col-md">
                            <a href="${pageContext.request.contextPath}/admin/product?action=list"
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

                        <div class="col-12 col-md">
                            <a href="${pageContext.request.contextPath}/admin/category?action=list"
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
                        <c:if test="${sessionScope.user.roleInSystem == 1}">
                            <div class="col-12 col-md">
                                <a href="${pageContext.request.contextPath}/admin/account?action=list"
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
                        </c:if>
                    </div>
                    <div class='text-center mt-4'>
                        <c:choose>
                            <c:when test="${empty sessionScope.user}">
                                <p class="fs-5 fw-bold">
                                    Welcome, Guest!
                                </p>
                            </c:when>
                            <c:when test="${sessionScope.user.roleInSystem == 1}">
                                <p class="fs-5 fw-bold">
                                    Welcome back <span style="color:red;">admin</span>, ${sessionScope.user.firstName}!
                                </p>
                            </c:when>
                            <c:when test="${sessionScope.user.roleInSystem == 2}">
                                <p class="fs-5 fw-bold">
                                    Welcome back <span style="color:orange;">manager</span>, ${sessionScope.user.firstName}!
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="fs-5 fw-bold">
                                    Welcome back staff, ${sessionScope.user.firstName}!
                                </p>
                            </c:otherwise>    
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

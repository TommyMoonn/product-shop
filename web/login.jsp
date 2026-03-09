<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <%@include file="head.jspf"%>
    </head>
    <body style="background-color: #121212">
        <%@include file="navbar.jspf"%>
        <section class="">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card bg-dark text-white" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-center">

                                <div class="mt-md-4">  
                                    <div>
                                        <h2 class ="fw-bold mb-2 d-flex justify-content-center align-items-center gap-2">
                                            <img src="${pageContext.request.contextPath}/images/icons/store-icon.png"
                                                 width="30" height="30">
                                            Product Shop
                                        </h2>
                                        <p>Please enter your credentials</p>
                                    </div>
                                    <h2 class="fw-bold mb-3">
                                        <img src="${pageContext.request.contextPath}/images/img_avatar2.png" alt="placeholder" style="width:250px;" class="rounded-pill">
                                    </h2>
                                    <!--<p class="text-white-50 mb-5">Please enter your login and password!</p>-->
                                    <form action="${pageContext.request.contextPath}/login" method="POST">
                                        <div class="form-outline mt-4 mb-4">
                                            <div class="input-group">
                                                <span class="input-group-text bg-success border-success">
                                                    <img src="${pageContext.request.contextPath}/images/icons/profile-icon.png"
                                                         width="20" height="20">
                                                </span>
                                                <input type="text"
                                                       id="account"
                                                       name="account"
                                                       class="form-control form-control-md" 
                                                       placeholder="Username" autocomplete="off"/>
                                            </div>
                                        </div>

                                        <div class="form-outline mb-4">
                                            <div class="input-group">
                                                <span class="input-group-text bg-success border-success">
                                                    <img src="${pageContext.request.contextPath}/images/icons/lock-icon.png"
                                                         width="20" height="20">
                                                </span>
                                                <input type="password"
                                                       id="password"
                                                       name="pass"
                                                       class="form-control form-control-md" 
                                                       placeholder="Password" autocomplete="off"/>
                                            </div>
                                        </div>
                                        <button class="btn btn-success w-100 p-2 mt-4" type="submit">Sign in</button>
                                    </form>
                                    <p class="mt-4 mb-0">
                                        Don't have an account?
                                        <a href="${pageContext.request.contextPath}/register.jsp" 
                                           class="text-success fw-bold card-hover">
                                            Sign up
                                        </a>
                                    </p>
                                </div>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger mt-3 mb-0">
                                        <strong>Failed!</strong> ${error}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>

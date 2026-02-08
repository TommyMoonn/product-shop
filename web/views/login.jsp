<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css"/>
        <!-- Latest compiled and minified CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body style="background-color: #121212">
        <section class="">
            <div class="container py-5 h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card bg-dark text-white" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-center">

                                <div class="mb-md-5 mt-md-4 pb-5">  
                                    <div>
                                        <h2 class ="fw-bold mb-2">
                                            Welcome back
                                        </h2>
                                        <p>Please enter your credentials</p>
                                    </div>
                                    <h2 class="fw-bold mb-3">
                                        <img src="${pageContext.request.contextPath}/images/img_avatar1.png" alt="placeholder" style="width:300px;" class="rounded-pill">
                                    </h2>
                                    <!--<p class="text-white-50 mb-5">Please enter your login and password!</p>-->
                                    <form action="login" method="POST">
                                        <div data-mdb-input-init class="form-outline mb-4">
                                            <label class="form-label" for="account">Name</label>
                                            <input type="text"
                                                   id="account"
                                                   name="account"
                                                   class="form-control form-control-md" 
                                                   placeholder="Enter your account name" autocomplete="off"/>
                                            <a href="../../../../../../../../Downloads/login-form.html"></a>
                                        </div>

                                        <div data-mdb-input-init class="form-outline mb-4">
                                            <label class="form-label" for="password">Password</label>
                                            <input type="password"
                                                   id="password"
                                                   name="pass"
                                                   class="form-control form-control-md" 
                                                   placeholder="Enter you password" autocomplete="off"/>
                                        </div>
                                        <button data-mdb-button-init data-mdb-ripple-init class="btn btn-outline-light btn-md px-5 mt-1 mb-4" type="submit">Login</button>
                                    </form>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger">
                                            ${error}
                                        </div>
                                    </c:if>
                                </div>
                                <a href="${pageContext.request.contextPath}"
                                   class="btn btn-outline-light">
                                    ← Back to Home
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>

<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unsupported</title>
        <%@include file="head.jspf"%>
    </head>
    <body class="darkmode">
        <%@include file="navbar.jspf"%>
            <div class="container text-center mt-4 bg-dark text-white rounded-5">
                <img src="${pageContext.request.contextPath}/images/access-denied.png"
                     class="img-fluid mb-4"
                     alt="Unsupported feature">

                <h2 class="fw-bold mb-4"><strong>You aren't authorized to peform this action!</strong></h2>

                <a href="${pageContext.request.contextPath}/home.jsp"
                   class="btn btn-outline-light mt-4 mb-4">
                    ← Back to home
                </a>
            </div>
    </body>
</html>

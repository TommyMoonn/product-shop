<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Unsupported</title>
        <%@include file="head.jspf"%>
    </head>
    <body class="darkmode">
        <div class="container text-center mt-5">
            <img src="${pageContext.request.contextPath}/images/unavailable-feature.png"
                 class="img-fluid mb-4"
                 alt="Unsupported feature">

            <h2 class="fw-bold">This feature isn’t available yet</h2>
            <p class="text-white mt-2">
                We’re still working on it. Check back later!
            </p>

            <a href="${pageContext.request.contextPath}/views/home.jsp"
               class="btn btn-outline-light mt-1">
                ← Back to home
            </a>
        </div>
    </body>
</html>

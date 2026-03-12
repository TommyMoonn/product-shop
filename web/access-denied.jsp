<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <%@include file="head.jspf"%>
</head>

<body class="darkmode">
    <%@include file="navbar.jspf"%>

    <div class="container d-flex justify-content-center align-items-center" style="min-height:80vh;">
        <div class="card bg-dark text-white text-center shadow-lg border-0 rounded-4 p-5" style="max-width:520px;">

            <img src="${pageContext.request.contextPath}/images/access-denied.png"
                 class="img-fluid mx-auto mb-4"
                 style="max-height:280px;"
                 alt="Access denied">

            <h3 class="fw-bold text-danger mb-3">
                Access Denied
            </h3>

            <p class="text-secondary mb-4">
                You don't have permission to perform this action.
                <br>
                If you believe this is a mistake, please contact support.
            </p>

            <div class="d-flex justify-content-center gap-3">
                <button onclick="history.back()" class="btn btn-outline-light px-4">
                    ← Go Back
                </button>

                <a href="${pageContext.request.contextPath}/home.jsp"
                   class="btn btn-primary px-4">
                    Home
                </a>
            </div>

        </div>
    </div>

</body>
</html>
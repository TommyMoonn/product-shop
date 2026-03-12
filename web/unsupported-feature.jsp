<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feature Unavailable</title>
    <%@include file="head.jspf"%>
</head>

<body class="darkmode">
    <%@include file="navbar.jspf"%>

    <div class="container d-flex justify-content-center align-items-center" style="min-height:80vh;">
        <div class="card bg-dark text-white text-center shadow-lg border-0 rounded-4 p-5" style="max-width:520px;">

            <img src="${pageContext.request.contextPath}/images/unavailable-feature.png"
                 class="img-fluid mx-auto mb-4"
                 style="max-height:280px;"
                 alt="Feature unavailable">

            <h3 class="fw-bold mb-2">Feature Not Available Yet</h3>

            <p class="text-secondary mb-4">
                We're still working on this feature.<br>
                Please check back later.
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
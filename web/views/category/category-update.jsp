<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Details</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="categories" />
        <%@include file="../navbar.jspf"%>

        <div class="container py-5">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card bg-dark text-white" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-start">
                            <form action="${pageContext.request.contextPath}/category/update" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="typeId" value="${category.typeId}">
                                <div class="mb-md-5 mt-md-3 pb-5">

                                    <h2 class="fw-bold mb-4">Updating ${category.categoryName}</h2>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="name">Category name</label>
                                        <input type="text" 
                                               id="name" 
                                               name="categoryName" 
                                               value="${category.categoryName}" 
                                               class="form-control form-control-md" placeholder="Enter category name"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="memo">Memo</label>
                                        <input type="text" 
                                               id="memo" 
                                               name="memo" 
                                               value="${category.memo}" 
                                               class="form-control form-control-md" placeholder="Enter a memo"/>
                                    </div>

                                    <button class="btn btn-primary btn-md mt-3 px-6"
                                            type="submit" onclick="return confirm('Save new changes?')">
                                        Update Category
                                    </button>

                                </div>
                                <a href="${pageContext.request.contextPath}/category/list"
                                   class="btn btn-outline-light">
                                    ← Back
                                </a>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>New Category</title>
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
                <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                    <div class="card bg-dark text-white" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-start">
                            <form action="${pageContext.request.contextPath}/main" method="post" accept-charset="UTF-8">
                                <input type="hidden" name="type" value="category">
                                <input type="hidden" name="action" value="add">

                                <h2 class="fw-bold mb-4">
                                    Create a new category
                                    <img src="${pageContext.request.contextPath}/images/icons/category-icon.png" alt="product"
                                         width="35" height="35" class="align-middle"/>
                                </h2>
                                <hr>
                                
                                <!--Category name and memo section-->
                                <div class="form-outline form-white mb-3">
                                    <label class="form-label" for="name">Category name</label>
                                    <input type="text" 
                                           id="name" 
                                           name="categoryName" 
                                           required
                                           pattern="[\p{L} ]+"
                                           minlength="2"
                                           maxlength="100"
                                           title="Only letters and spaces"
                                           class="form-control form-control-md" placeholder="e.g. Thiết bị điện tử"/>
                                </div>

                                <div class="form-outline form-white mb-3">
                                    <label class="form-label" for="memo">Memo</label>
                                    <textarea type="text" 
                                              id="memo" 
                                              name="memo"
                                              rows="4"
                                              class="form-control form-control-md" placeholder="Enter a memo for the category"></textarea>
                                </div>

                                <!--Submit and back button-->
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="${pageContext.request.contextPath}/category?action=list"
                                       class="btn btn-outline-light">
                                        ← Back
                                    </a>

                                    <button class="btn btn-primary px-4"
                                            type="submit">
                                        Create category
                                    </button>
                                </div>
                            </form>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-3">
                                    <strong>Failed!</strong> ${error}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

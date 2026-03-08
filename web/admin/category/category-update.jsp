<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Details</title>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="categories" />
        <%@include file="../../navbar.jspf"%>
        <div class="container-fluid row">
            <%@include file="../sidebar.jspf"%>
            <div class="col py-5">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                        <div class="card bg-dark text-white" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-start">
                                <form action="${pageContext.request.contextPath}/admin/category?action=update" method="post">
                                    <input type="hidden" name="typeId" value="${category.typeId}">

                                    <h2 class="fw-bold mb-4">
                                        Updating category information
                                        <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="product"
                                             width="30" height="30" class="align-middle"/>
                                    </h2>
                                    <h3>${category.categoryName}</h3>
                                    <hr>

                                    <!--Category name and memo section-->
                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="name">Category name</label>
                                        <input type="text" 
                                               id="name" 
                                               name="categoryName" 
                                               value="${category.categoryName}"
                                               required
                                               pattern="[\p{L} ]+"
                                               minlength="2"
                                               maxlength="88"
                                               title="Only letters and spaces"
                                               class="form-control form-control-md" placeholder="Enter category name"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="memo">Memo</label>
                                        <textarea id="memo" 
                                                  name="memo" 
                                                  rows="4"
                                                  title="Brief introduction for the category"
                                                  class="form-control form-control-md" placeholder="Enter a memo for the category">${category.memo}</textarea>
                                    </div>

                                    <!--Submit and back button-->
                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/category?action=list"
                                           class="btn btn-outline-light">
                                            ← Back
                                        </a>

                                        <button class="btn btn-primary btn-md px-4"
                                                type="submit" onclick="return confirm('Save new changes?')">
                                            Update Category 
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
        </div>
    </body>
</html>

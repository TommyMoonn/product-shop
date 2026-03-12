<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>New Category</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="categories"/>
        <div class="container-fluid row">
            <%@include file="../sidebar.jspf"%>
            <div class="col admin-content">
                <div class="row justify-content-center">
                    <div class="col-xl-8 col-lg-9">
                        <div class="admin-card">
                            <div class="admin-header">
                                <h2>
                                    Create a new category
                                </h2>
                                <p class="text-white">Add a new category to the system</p>
                            </div>
                            <hr>
                            <form action="${pageContext.request.contextPath}/admin/category?action=add"
                                  method="post"
                                  accept-charset="UTF-8">
                                <div class="form-section">
                                    <h5 class="section-title">Category Information</h5>
                                    <div class="mb-3">
                                        <label class="form-label" for="name">Category name</label>
                                        <input type="text"
                                               id="name"
                                               name="categoryName"
                                               required
                                               pattern="[\p{L} ]+"
                                               minlength="2"
                                               maxlength="88"
                                               title="Only letters and spaces"
                                               class="form-control"
                                               placeholder="e.g. Thiết bị điện tử"/>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="memo">Memo</label>
                                        <textarea
                                            id="memo"
                                            name="memo"
                                            rows="4"
                                            class="form-control"
                                            placeholder="Enter a memo for the category"></textarea>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <a class="btn btn-outline-light"
                                       onclick="history.back()">
                                        Back
                                    </a>
                                    <button class="btn btn-primary px-4" type="submit">
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
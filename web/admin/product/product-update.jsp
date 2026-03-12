<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Edit</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="products" />
        <div class="container-fluid row">
            <div data-bs-theme="dark">
                <%@include file="../sidebar.jspf"%>
                <div class="col admin-content">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 col-lg-9">
                            <div class="admin-card">
                                <!-- Page Header -->
                                <div class="admin-header">
                                    <h2>
                                        Update product information
                                    </h2>
                                    <p class="text-white">
                                        ${product.productName}
                                        <small class="fs-6">#${product.productId}</small>
                                    </p>
                                </div>
                                <hr>
                                <form action="${pageContext.request.contextPath}/admin/product?action=update"
                                      method="post"
                                      accept-charset="UTF-8">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <!-- PRODUCT INFORMATION -->
                                    <div class="form-section">
                                        <h5 class="section-title">Product Information</h5>
                                        <div class="mb-3">
                                            <label class="form-label" for="proName">Product name</label>
                                            <input type="text"
                                                   id="proName"
                                                   name="productName"
                                                   value="${product.productName}"
                                                   required
                                                   minlength="2"
                                                   maxlength="500"
                                                   class="form-control"
                                                   placeholder="e.g. HD001, TS012,..."/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label" for="brief">Brief</label>
                                            <textarea id="brief"
                                                      name="brief"
                                                      rows="4"
                                                      maxlength="2000"
                                                      class="form-control"
                                                      placeholder="Brief introduction for the product">${product.brief}</textarea>
                                        </div>
                                    </div>
                                    <!-- CATEGORY & UNIT -->
                                    <div class="form-section">
                                        <h5 class="section-title">Category & Unit</h5>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="typeId">Category</label>
                                                <select id="typeId"
                                                        name="typeId"
                                                        required
                                                        class="form-select">
                                                    <option value="" disabled selected>Choose category</option>
                                                    <c:forEach var="c" items="${categories}">
                                                        <option value="${c.typeId}"
                                                                ${c.typeId == product.type.typeId ? 'selected' : ''}>
                                                            ${c.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label" for="unit">Unit</label>
                                                <input type="text"
                                                       id="unit"
                                                       name="unit"
                                                       value="${product.unit}"
                                                       required
                                                       pattern="[\p{L} ]+"
                                                       maxlength="32"
                                                       title="Only letters and spaces"
                                                       class="form-control"
                                                       placeholder="e.g. Cái,..."/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- PRICING -->
                                    <div class="form-section">
                                        <h5 class="section-title">Pricing</h5>
                                        <div class="mb-3">
                                            <label class="form-label" for="price">Price</label>
                                            <input type="number"
                                                   id="price"
                                                   name="price"
                                                   value="${product.price}"
                                                   required
                                                   min="0"
                                                   step="0.1"
                                                   class="form-control"
                                                   placeholder="e.g. 350000, 270000,..."/>
                                        </div>

                                        <div class="mb-3">
                                            <label class="form-label" for="discount">Discount</label>
                                            <input type="number"
                                                   id="discount"
                                                   name="discount"
                                                   value="${product.discount}"
                                                   required
                                                   min="0"
                                                   max="100"
                                                   step="1"
                                                   class="form-control"
                                                   placeholder="e.g. 5, 10, 15,..."/>
                                        </div>
                                    </div>
                                    <!-- IMAGE -->
                                    <div class="form-section">
                                        <h5 class="section-title">Product Image</h5>
                                        <div class="mb-3">
                                            <label class="form-label" for="productImage">Product Image</label>
                                            <input type="text"
                                                   id="productImage"
                                                   name="productImage"
                                                   value="${imageFileName}"
                                                   pattern="^[a-zA-Z0-9_-]+\.(jpg|jpeg|png)$"
                                                   class="form-control"
                                                   title="Image file name, supported extensions: jpg, jpeg, png"
                                                   placeholder="e.g. hoodie.jpg, shirt.png,..."/>
                                        </div>
                                    </div>
                                    <!-- ACTION BUTTONS -->
                                    <div class="form-actions">
                                        <a class="btn btn-outline-light"
                                           onclick="history.back()">
                                            Back
                                        </a>
                                        <button class="btn btn-primary px-4"
                                                type="submit"
                                                onclick="return confirm('Save new changes?')">
                                            Update Product
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
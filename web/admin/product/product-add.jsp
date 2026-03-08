<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>New Product</title>
        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="products" />
        <%@include file="../../navbar.jspf"%>
        <div class="container-fluid row">
            <%@include file="../sidebar.jspf"%>
            <div class="col py-5">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                        <div class="card bg-dark text-white" style="border-radius: 1rem;">
                            <div class="card-body p-5 text-start">
                                <form action="${pageContext.request.contextPath}/admin/product?action=add" method="post" accept-charset="UTF-8">

                                    <h2 class="fw-bold mb-3"> 
                                        Create a new product
                                        <img src="${pageContext.request.contextPath}/images/icons/box-icon.png" alt="product"
                                             width="35" height="35" class="align-middle"/>
                                    </h2>
                                    <hr>

                                    <!--Product ID and Product Name section-->
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="proId">Product ID</label>
                                            <input type="text" 
                                                   id="proId" 
                                                   name="productId" 
                                                   required
                                                   maxLength="10"
                                                   pattern="[A-Z0-9_-]{3,20}"
                                                   title="3–20 characters, uppercase letters, numbers, _ or -"
                                                   class="form-control form-control-md" 
                                                   placeholder="e.g. HD001, TS012,..."/>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="proName">Product name</label>
                                            <input type="text" 
                                                   id="proName" 
                                                   name="productName" 
                                                   required
                                                   minlength="2"
                                                   maxlength="500"
                                                   class="form-control form-control-md" 
                                                   placeholder="e.g. Hoodie, Áo thun,..."/>
                                        </div>
                                    </div>

                                    <!--Brief section-->
                                    <div class="mb-3">
                                        <label class="form-label" for="brief">Brief</label>
                                        <textarea 
                                            id="brief" 
                                            name="brief" 
                                            rows="4"
                                            maxlength="2000"
                                            class="form-control form-control-md" 
                                            placeholder="Brief introduction for the product"></textarea>
                                    </div>

                                    <!--Category and Unit section-->
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="typeId">Category</label>
                                            <select 
                                                id="typeId"
                                                name="typeId"
                                                required
                                                class="form-select form-select-md">
                                                <option value="" disabled selected>Choose category</option>
                                                <c:forEach var="c" items="${categories}">
                                                    <option value="${c.typeId}">
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
                                                   required
                                                   pattern="[\p{L} ]+"
                                                   maxlength="32"
                                                   title="Only letters and spaces"
                                                   class="form-control form-control-md" 
                                                   placeholder="e.g. Cái,..."/>
                                        </div>
                                    </div>

                                    <!--Price and Discount section-->
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="price">Price</label>
                                            <input type="number" 
                                                   id="price" 
                                                   name="price" 
                                                   required
                                                   min="0"
                                                   step="0.1"
                                                   class="form-control form-control-md" 
                                                   placeholder="e.g. 350000, 270000,..."/>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label" for="discount">Discount</label>
                                            <input type="number" 
                                                   id="discount" 
                                                   name="discount" 
                                                   required
                                                   min="0"
                                                   max="100"
                                                   step="1"
                                                   class="form-control form-control-md" 
                                                   placeholder="e.g. 5, 10, 15,..."/>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label" for="productImage">Product Image</label>
                                        <input type="text" 
                                               id="productImage" 
                                               name="productImage" 
                                               pattern="^[a-zA-Z0-9_-]+\.(jpg|jpeg|png)$"
                                               class="form-control form-control-md"
                                               title="Image file name, supported extensions: jpg, jpeg, png"
                                               placeholder="e.g. hoodie.jpg, shirt.png,..."/>
                                    </div>

                                    <!--Submit and back button-->
                                    <div class="d-flex justify-content-between mt-4">
                                        <a href="${pageContext.request.contextPath}/admin/product?action=list"
                                           class="btn btn-outline-light">
                                            ← Back
                                        </a>

                                        <button class="btn btn-primary btn-md px-3" type="submit">Create product</button>
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

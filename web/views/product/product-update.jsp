<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Edit</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="products" />
        <%@include file="../navbar.jspf"%>

        <div class="container py-5">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                    <div class="card bg-dark text-white" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-start">
                            <form action="${pageContext.request.contextPath}/auth" method="post" accept-charset="UTF-8">
                                <input type="hidden" name="type" value="product">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="${product.productId}">
                                
                                <div class="mb-md-5 mt-md-3 pb-5">
                                    <h2 class="fw-bold mb-4">Updating: ${product.productName}
                                        <small class='fs-6'> 
                                            #${product.productId}
                                        </small></h2>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="proName">Product name</label>
                                        <input type="text" 
                                               id="proName" 
                                               name="productName"
                                               value='${product.productName}'
                                               required
                                               minlength="2"
                                               maxlength="100"
                                               class="form-control form-control-md" placeholder="Enter product name"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="brief">Brief</label>
                                        <input type="text" 
                                               id="brief" 
                                               name="brief"
                                               value='${product.brief}'
                                               name="brief" 
                                               maxlength="255"
                                               title="Brief introduction for the product"
                                               class="form-control form-control-md" placeholder="Enter a brief for the product"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="typeId">Category</label>
                                        <select 
                                            id="typeId"
                                            name="typeId"
                                            required
                                            class="form-select form-select-md">
                                            <option value="" disabled selected>Choose category</option>
                                            <c:forEach var="c" items="${categories}">
                                                <option value="${c.typeId}" selected>
                                                    ${c.categoryName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="unit">Unit</label>
                                        <input type="text" 
                                               id="unit" 
                                               name="unit"
                                               value='${product.unit}'
                                               required
                                               pattern="[\p{L} ]+"
                                               maxlength="20"
                                               title="Only letters and spaces"
                                               class="form-control form-control-md" placeholder="Enter unit"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="price">Price</label>
                                        <input type="number" 
                                               id="price" 
                                               name="price"
                                               value='${product.price}'
                                               required
                                               min="0"
                                               step="0.1"
                                               class="form-control form-control-md" placeholder="Enter product price"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="discount">Discount</label>
                                        <input type="number" 
                                               id="discount" 
                                               name="discount"
                                               value='${product.discount}'
                                               required
                                               min="0"
                                               max="100"
                                               step="1"
                                               class="form-control form-control-md" placeholder="Enter discount percentage"/>
                                    </div>

                                    <button class="btn btn-primary btn-md mt-3 px-3"
                                            type="submit" onclick="return confirm('Save new changes?')">
                                        Update Product
                                    </button>

                                </div>
                            </form>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
                                    <strong>Failed!</strong> ${error}
                                </div>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/product/list"
                               class="btn btn-outline-light"
                               >
                                ← Back
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>New Product</title>
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
                            <form action="${pageContext.request.contextPath}/product/add" method="post" accept-charset="UTF-8">
                                <div class="mb-md-5 mt-md-3 pb-5">

                                    <h2 class="fw-bold mb-4">Create a new product</h2>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="proId">Product ID</label>
                                        <input type="text" 
                                               id="proId" 
                                               name="productId" 
                                               required
                                               class="form-control form-control-md" placeholder="Enter product id"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="proName">Product name</label>
                                        <input type="text" 
                                               id="proName" 
                                               name="productName" 
                                               required
                                               class="form-control form-control-md" placeholder="Enter product name"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="brief">Brief</label>
                                        <input type="text" 
                                               id="brief" 
                                               name="brief" 
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
                                                <option value="${c.typeId}">
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
                                               required
                                               class="form-control form-control-md" placeholder="Enter unit"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="price">Price</label>
                                        <input type="number" 
                                               id="price" 
                                               name="price" 
                                               required
                                               class="form-control form-control-md" placeholder="Enter product price"/>
                                    </div>

                                    <div class="form-outline form-white mb-3">
                                        <label class="form-label" for="discount">Discount</label>
                                        <input type="number" 
                                               id="discount" 
                                               name="discount" 
                                               required
                                               class="form-control form-control-md" placeholder="Enter product discount"/>
                                    </div>

                                    <button class="btn btn-primary btn-md mt-3 px-3" type="submit">Create product</button>

                                </div>
                                <a href="${pageContext.request.contextPath}/product/list"
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

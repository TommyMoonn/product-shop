<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css"/>
        <%@include file="head.jspf"%>
    </head>
    <body class="darkmode">
        <c:set var="activePage" value="home"/>
        <%@include file="navbar.jspf"%>
        <div class="container-fluid hero-section text-white d-flex justify-content-center align-items-center text-center">
            <div>
                <h1 class="display-5 fw-bold">Discover Great Products</h1>
                <p class="lead">Find amazing deals and explore our latest items</p>

                <a href="${pageContext.request.contextPath}/product?action=list"
                   class="btn btn-primary btn-lg mt-3">
                    Browse Products
                </a>
            </div>
        </div>

        <!-- CATEGORIES -->
        <div class="container mt-5">
            <h3 class="mb-4">Shop by Category</h3>
            <div class="row g-4">
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/product?action=list&typeId=5"
                       class="text-decoration-none text-white">
                        <div class="card category-card bg-dark text-white h-100">
                            <img src="${pageContext.request.contextPath}/images/preview/electronics.jpg"
                                 class="card-img-top">
                            <div class="card-body text-center">
                                <h5>Electronics</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/product?action=list&typeId=4"
                       class="text-decoration-none text-white">
                        <div class="card category-card bg-dark text-white h-100">
                            <img src="${pageContext.request.contextPath}/images/preview/sport-equipment.jpg"
                                 class="card-img-top">
                            <div class="card-body text-center">
                                <h5>Sports Equipment</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/product?action=list&typeId=3"
                       class="text-decoration-none text-white">
                        <div class="card category-card bg-dark text-white h-100">
                            <img src="${pageContext.request.contextPath}/images/preview/home-decor.jpg"
                                 class="card-img-top">
                            <div class="card-body text-center">
                                <h5>Home Decoration</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/product?action=list&typeId=6"
                       class="text-decoration-none text-white">
                        <div class="card category-card bg-dark text-white h-100">
                            <img src="${pageContext.request.contextPath}/images/preview/fashion-items.jpg"
                                 class="card-img-top">

                            <div class="card-body text-center">
                                <h5>Fashion</h5>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <!-- FEATURED PRODUCTS -->
        <div class="container mt-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3>Featured Products</h3>
                <a href="${pageContext.request.contextPath}/product?action=list"
                   class="btn btn-outline-light btn-sm">
                    View All
                </a>
            </div>

            <div class="row g-4">
                <c:forEach var="p" items="${featuredProducts}">
                    <div class="col-md-3">
                        <div class="card product-card bg-dark text-white h-100">
                            <img src="${pageContext.request.contextPath}${p.productImage}"
                                 class="card-img-top">
                            <div class="card-body d-flex flex-column">
                                <h6 class="mb-2">${p.productName}</h6>
                                <p class="text-success fw-bold mb-3">
                                    <fmt:formatNumber value="${p.price}" type="number"/> VND
                                </p>
                                <a href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}"
                                   class="btn btn-outline-light btn-sm mt-auto">
                                    View Product
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- STORE BENEFITS -->
        <div class="container mt-5 mb-5">
            <div class="row text-center g-4">
                <div class="col-md-4">
                    <div class="benefit-box">
                        <h5 class="d-flex align-items-center justify-content-center gap-2">
                            <img src="${pageContext.request.contextPath}/images/icons/truck-color-icon.png"
                                 width="25">
                            Fast Delivery</h5>
                        <p class="text-secondary mb-0">
                            Quick nationwide shipping
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-box">
                        <h5 class="d-flex align-items-center justify-content-center gap-2">
                            <img src="${pageContext.request.contextPath}/images/icons/credit-card-color-icon.png"
                                 width="25">
                            Secure Payment</h5>
                        <p class="text-secondary mb-0">
                            Safe and reliable checkout
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="benefit-box">
                        <h5 class="d-flex align-items-center justify-content-center gap-2">
                            <img src="${pageContext.request.contextPath}/images/icons/star-color-icon.png"
                                 width="25">
                            Quality Products
                        </h5>
                        <p class="text-secondary mb-0">
                            Carefully selected items
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Account</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="accounts" />
        <%@include file="../navbar.jspf"%>

        <div class="container py-5">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                    <div class="card bg-dark text-white" style="border-radius: 1rem;">
                        <div class="card-body p-5 text-start">
                            <form action="${pageContext.request.contextPath}/main" method="post" accept-charset="UTF-8">
                                <input type="hidden" name="type" value="account">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="account" value="${account.account}">

                                <h2 class="fw-bold mb-3">
                                    Updating account information
                                    <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="product"
                                         width="30" height="30" class="align-middle"/>
                                </h2>
                                <h3>
                                    Username: ${account.account}
                                </h3>
                                <hr>
                                
                                <!--Password section-->
                                <div class="form-outline form-white mb-3">
                                    <label class="form-label" for="pass">Password</label>
                                    <input type="password" 
                                           id="pass" 
                                           name="pass"
                                           value="${account.pass}"
                                           required
                                           maxlength="20"
                                           class="form-control form-control-md" placeholder="Enter account password"/>
                                </div>

                                <!--First name and last name section-->
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="firstName">First name</label>
                                        <input type="text" 
                                               id="firstName" 
                                               name="firstName"
                                               value="${account.firstName}"
                                               required
                                               pattern="[\p{L} ]+"
                                               maxlength="30"
                                               class="form-control form-control-md" placeholder="Enter first name"/>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="lastName">Last name</label>
                                        <input type="text" 
                                               id="lastName" 
                                               name="lastName"
                                               value="${account.lastName}"
                                               required
                                               pattern="[\p{L} ]+"
                                               maxlength="50"
                                               class="form-control form-control-md" placeholder="Enter last name"/>
                                    </div>
                                </div>

                                <!--Birthday and gender section-->
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="birthday">Birthday</label>
                                        <input
                                            type="date"
                                            id="birthday"
                                            name="birthday"
                                            <fmt:formatDate value="${account.birthday}" pattern="yyyy-MM-dd" var="birthdayFormatted"/>
                                            value="${birthdayFormatted}"
                                            required
                                            max="${requestScope.today}"
                                            class="form-control form-control-md"/>
                                    </div>

                                    <div class="col-md-6 mb-3">
                                        <label class="form-label" for="gender">Gender</label>
                                        <select 
                                            id="gender"
                                            name="gender"
                                            required
                                            class="form-select form-select-md">
                                            <option value="true" ${account.gender ? "selected" : ""}>Male</option>
                                            <option value="false" ${!account.gender ? "selected" : ""}>Female</option>
                                        </select>
                                    </div>
                                </div>

                                <!--Phone number and role section-->            
                                <div class="form-outline form-white mb-3">
                                    <label class="form-label" for="phone">Phone number</label>
                                    <input type="tel" 
                                           id="phone" 
                                           name="phone" 
                                           value="${account.phone}"
                                           required
                                           pattern="0[0-9]{9}"
                                           title="Phone number must start with 0 and have 10 digits"
                                           class="form-control form-control-md" placeholder="Enter phone number"/>
                                </div>

                                <div class="form-outline form-white mb-3">
                                    <label class="form-label" for="role">Role</label>
                                    <select 
                                        id="role"
                                        name="role"
                                        required
                                        class="form-select form-select-md">
                                        <option value="1" ${account.roleInSystem == 1 ? "selected" : ""}>Admin</option>
                                        <option value="2" ${account.roleInSystem == 2 ? "selected" : ""}>Manager</option>
                                        <option value="3" ${account.roleInSystem == 3 ? "selected" : ""}>Staff</option>
                                    </select>
                                </div>

                                <!--Submit and back button-->
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="${pageContext.request.contextPath}/account?action=list"
                                       class="btn btn-outline-light">
                                        ← Back
                                    </a>

                                    <button class="btn btn-primary btn-md px-3" 
                                            type="submit" onclick="return confirm('Save new changes?')">
                                        Update Account information
                                    </button>
                                </div>
                            </form>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">
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

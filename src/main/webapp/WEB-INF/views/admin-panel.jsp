<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Panel administratora</title><meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-10 text-center">
            <c:if test="${tabNumber == 0}">
                <a href="/admin-panel/add-scheme" class="btn btn-primary"><i class="fa fa-plus-circle"></i> Dodaj schemat</a>
                <br>
                <br>
            </c:if>
            <c:if test="${tabNumber == 1}">
                <br>
                <br>
                <br>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-1">
            <a href="/admin-panel?tab=0" class="btn btn-primary float-right d-none d-lg-block">
                <i class="fa fa-map"></i> Schematy
            </a>
            <a href="/admin-panel?tab=0" class="btn btn-primary float-right d-block d-lg-none">
                <i class="fa fa-map"></i>
            </a>
            <br>
            <br>
            <a href="/admin-panel?tab=1" class="btn btn-primary float-right d-none d-lg-block">
                <i class="fa fa-users"></i> Użytkownicy
            </a>
            <a href="/admin-panel?tab=1" class="btn btn-primary float-right d-block d-lg-none">
                <i class="fa fa-users"></i>
            </a>
        </div>
        <div class="col-1"></div>
        <div class="col-10 text-center">
            <c:if test="${tabNumber == 0}">
                <table class="table table-hover table-bordered text-center">
                    <thead>
                        <tr class="thead-dark">
                            <th>Lp.</th>
                            <th>Aktywny</th>
                            <th>Nazwa</th>
                            <th>Szczegóły</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${allSchemeDTOs}" var="scheme" varStatus="schemeStatus">
                        <tr>
                            <td class="align-middle">${schemeStatus.count}</td>
                            <c:if test="${scheme.active == true}">
                                <td class="align-middle">TAK</td>
                            </c:if>
                            <c:if test="${scheme.active != true}">
                                <td class="align-middle">NIE</td>
                            </c:if>
                            <td class="align-middle">${scheme.name}</td>
                            <td><a href="/scheme-details?id=${scheme.id}" class="btn btn-primary btn-sm">Zobacz</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${tabNumber == 1}">
                <table class="table table-hover table-bordered text-center">
                    <thead>
                    <tr class="thead-dark">
                        <th>Lp.</th>
                        <th>Aktywny</th>
                        <th>Login</th>
                        <th>Uprawnienia</th>
                        <th>Szczegóły</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${allUserDTOs}" var="user" varStatus="userStatus">
                        <tr>
                            <td class="align-middle">${userStatus.count}</td>
                            <c:if test="${user.active == true}">
                                <td class="align-middle">TAK</td>
                            </c:if>
                            <c:if test="${user.active != true}">
                                <td class="align-middle">NIE</td>
                            </c:if>
                            <td class="align-middle">${user.username}</td>
                            <td class="align-middle">${user.role}</td>
                            <td><a href="/user-panel?id=${user.id}" class="btn btn-primary btn-sm">Zobacz</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>

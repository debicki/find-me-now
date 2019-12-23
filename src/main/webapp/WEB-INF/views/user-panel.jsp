<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Panel użytkownika</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-10">
            <c:if test="${activeTab == 0}">
                <p class="h3">Nazwa użytkownika: ${userDTO.username}</p>
                <br>
            </c:if>
            <c:if test="${activeTab == 1}">
                <div class="text-center">
                    <a href="/user-panel/take-place" class="btn btn-primary"><i class="fa fa-arrow-down"></i> Zajmij miejsce</a>
                    <br>
                    <br>
                </div>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class="col-1">
            <c:if test="${loggedUserDTO.role.equals('ROLE_ADMIN')}">
                <a href="/user-panel?id=${userDTO.id}&tab=0" class="btn btn-primary float-right d-none d-lg-block">
                    <i class="fa fa-info-circle"></i> Informacje
                </a>
                <a href="/user-panel?id=${userDTO.id}&tab=0" class="btn btn-primary float-right d-block d-lg-none">
                    <i class="fa fa-info-circle"></i>
                </a>
            </c:if>
            <c:if test="${!loggedUserDTO.role.equals('ROLE_ADMIN')}">
                <a href="/user-panel?tab=0" class="btn btn-primary float-right d-none d-lg-block">
                    <i class="fa fa-info-circle"></i> Informacje
                </a>
                <a href="/user-panel?tab=0" class="btn btn-primary float-right d-block d-lg-none">
                    <i class="fa fa-info-circle"></i>
                </a>
            </c:if>
            <br>
            <br>
            <c:if test="${loggedUserDTO.role.equals('ROLE_ADMIN')}">
                <a href="/user-panel?id=${userDTO.id}&tab=1" class="btn btn-primary float-right d-none d-lg-block">
                    <i class="fa fa-table"></i> Rezerwacje
                </a>
                <a href="/user-panel?id=${userDTO.id}&tab=1" class="btn btn-primary float-right d-block d-lg-none">
                    <i class="fa fa-table"></i>
                </a>
            </c:if>
            <c:if test="${!loggedUserDTO.role.equals('ROLE_ADMIN')}">
                <a href="/user-panel?tab=1" class="btn btn-primary float-right d-none d-lg-block">
                    <i class="fa fa-table"></i> Rezerwacje
                </a>
                <a href="/user-panel?tab=1" class="btn btn-primary float-right d-block d-lg-none">
                    <i class="fa fa-table"></i>
                </a>
            </c:if>
        </div>
        <div class="col-1"></div>
        <div class="col-10 text-left">
            <c:if test="${activeTab == 0}">
                <p class="h5">Imię: ${userDTO.firstName}</p>
                <p class="h5">Nazwisko: ${userDTO.lastName}</p>
                <br>
                <c:if test="${userDTO.role.equals('ROLE_USER')}">
                    <p class="h5">Uprawnienia: Użytkownik</p>
                </c:if>
                <c:if test="${userDTO.role.equals('ROLE_ADMIN')}">
                    <p class="h5">Uprawnienia: Administrator</p>
                </c:if>
                <br>
                <c:if test="${!loggedUserDTO.role.equals('ROLE_ADMIN') || userDTO.username.equals(loggedUserDTO.username)}">
                    <p class="h5">
                        <a href="/user-panel/deactivate-user?id=${userDTO.id}" class="btn btn-primary btn-sm">Wyłącz konto</a>
                        <br>
                        <span class="h6"> Uwaga: konto włączyć ponownie może tylko administrator!</span>
                    </p>
                </c:if>
                <c:if test="${loggedUserDTO.role.equals('ROLE_ADMIN') && !userDTO.username.equals(loggedUserDTO.username)}">
                    <c:if test="${userDTO.active == true}">
                        <p class="h5">
                            <span>Konto aktywne: TAK <a href="/admin-panel/deactivate-user?id=${userDTO.id}" class="btn btn-primary btn-sm">Wyłącz</a></span>
                        </p>
                    </c:if>
                    <c:if test="${userDTO.active == false}">
                        <p class="h5">
                            <span>Konto aktywne: NIE <a href="/admin-panel/activate-user?id=${userDTO.id}" class="btn btn-primary btn-sm">Włącz</a></span>
                        </p>
                    </c:if>
                </c:if>
            </c:if>
            <c:if test="${activeTab == 1}">
                <div class="h1 text-center">
                    <c:if test="${placeDTOS.size() == 0}">
                        <div class="h1 text-center">
                            Tu kiedyś będą rezerwacje użytkownika.
                            <br>
                            <br>
                            Jak coś zarezerwuje oczywiście. ;)
                        </div>
                    </c:if>
                    <c:if test="${placeDTOS.size() > 0}">
                        <table class="table table-hover table-bordered text-center">
                            <thead>
                            <tr class="thead-dark">
                                <th>Lp.</th>
                                <th>Aktywna</th>
                                <th>Nazwa schematu</th>
                                <th>Nazwa miejsca</th>
                                <th>Akcje</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${placeDTOS}" var="placeDTO" varStatus="placeDTOStatus">
                                <tr>
                                    <td class="align-middle">${placeDTOStatus.count}</td>
                                    <td class="align-middle">TAK</td>
                                    <td class="align-middle">${schemeNameList.get(placeDTO.schemeId)}</td>
                                    <td class="align-middle">${placeDTO.name}</td>
                                    <td><a href="#" class="btn btn-primary btn-sm disabled">Zobacz</a>
                                        <a href="#" class="btn btn-primary btn-sm disabled">Zwolnij</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Pomoc</title>
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
        <div class="col-8">
            <div class="h1">
                <i class="fa fa-users"></i>Find me now!
            </div>
            <hr>
        </div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-1">
            <a href="/help?tab=0" class="btn btn-primary float-right d-none d-lg-block"><i class="fa fa-eye"></i> O programie</a>
            <a href="/help?tab=0" class="btn btn-primary float-right d-block d-lg-none"><i class="fa fa-eye"></i></a>
            <br>
            <br>
            <a href="/help?tab=1" class="btn btn-primary float-right d-none d-lg-block"><i class="fa fa-list"></i> Jak używać?</a>
            <a href="/help?tab=1" class="btn btn-primary float-right d-block d-lg-none"><i class="fa fa-list"></i></a>
        </div>
        <div class="col-1"></div>
        <div class="col-10 text-left">
            <br>
            <br>
            <c:if test="${tabNumber == 0}">
                <div class="h3">
                    Aplikacja służy do zarządzania miejscami w organizacji. Umożliwia również odnalezienie pracownika,
                    jeżeli ten wykorzystuje któreś z zarządzanych w aplikacji miejsc.
                </div>
            </c:if>
            <c:if test="${tabNumber == 1}">
                <div class="h3">
                    <p class="h2">Strona główna</p>
                    <hr>
                    Strona główna wyświetla dostępne schematy na których można wyszukiwać osoby, które zadeklarowały
                    swoją obecność. Po wpisaniu nazwiska szukanej osoby, jeżeli została ona znaleziona, jej
                    zadeklarowana lokalizacja zostanie zaznaczona na schemacie.
                    <br>
                    <br>
                    <p class="h2">Panel użytkownika</p>
                    <hr>
                    Panel użytkownika umożliwia zarejestrowanemu użytkownikowi zadeklarowanie swojej lokalizacji,
                    dzięki czemu będzie go można wyszukać na stronie głównej.
                    <br>
                    <br>
                    <p class="h2">Panel administratora</p>
                    <hr>
                    Panel administratora umożliwia dodawanie schematów, zarządzanie schematami, dodawanie miejsc
                    dostępnych do rezerwacji oraz zarządzanie użytkownikami.
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>

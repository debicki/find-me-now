<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Rezerwacja miejsca</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<br>
<c:if test="${allActiveSchemeDTOS.size() == 0}">
    <div class="row">
        <div class="col-12 display-4 text-center">Baza danych nie zawiera aktywnych schematów!</div>
    </div>
</c:if>
<c:if test="${allActiveSchemeDTOS.size() > 0}">
    <div class="row">
        <div class="col-1"></div>
        <div class="col-1"></div>
        <div class="col-8 text-center">
            <form method="post" action="/user-panel/take-place">
                <div class="form-row">
                    <div class="col-6 form-group float-right">
                        <label for="schemes">Schemat</label>
                        <select required name="schemeId" id="schemes" class="custom-select" onchange="showScheme()">
                            <c:forEach items="${allActiveSchemeDTOS}" var="schemeDTO">
                                <c:if test="${visibleSchemeId == schemeDTO.id}">
                                    <option value="${schemeDTO.id}" selected>${schemeDTO.name}</option>
                                </c:if>
                                <c:if test="${visibleSchemeId != schemeDTO.id}">
                                    <option value="${schemeDTO.id}">${schemeDTO.name}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-6 form-group float-left">
                        <label for="places">Miejsce</label>
                        <select required name="placeId" id="places" class="custom-select" onchange="showPlace()">
                            <c:forEach items="${availablePlaceDTOS}" var="placeDTO">
                                <option value="${placeDTO.id}" data-position-x="${placeDTO.coordinateX}"
                                data-position-y="${placeDTO.coordinateY}">${placeDTO.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-12 form-group text-center">
                        <button class="btn btn-primary" type="submit">
                            <i class="fa fa-arrow-circle-o-down"></i> Zajmij</button>
                    </div>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
        <div class="col-1"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <img src="/scheme?id=${visibleSchemeId}" class="img-fluid w-100" alt="Scheme" id="image">
            <div class="h2">
                <i class="fa fa-flag-checkered" id="selectedPlace" style="display: none"></i>
            </div>
            <div>
                <c:forEach items="${availablePlaceDTOS}" var="place">
                    <i class="fa fa-times" id="${place.id}" style="display: none">
                        <span class="badge badge-pill badge-light"> ${place.name}</span>
                    </i>
                    <script>
                        (function() {
                            var schemeWidth = document.getElementById("image").clientWidth;
                            var schemeHeight = document.getElementById("image").clientHeight;
                            var place = document.getElementById(${place.id});
                            place.style.display = '';
                            place.style.color = 'black';
                            place.style.position = 'absolute';
                            place.style.left = Number(${place.coordinateX}) / 100 * schemeWidth + 10 + '';
                            place.style.top = Number(${place.coordinateY}) / 100 * schemeHeight - 4 + '';
                        })();
                    </script>
                </c:forEach>
            </div>
        </div>
        <div class="col-1"></div>
    </div>
</c:if>
</div>
<script>
    function showScheme() {
        var schemesList = document.getElementById("schemes");
        var selectedOption = schemesList.options[schemesList.selectedIndex].value;
        window.location.replace("/user-panel/take-place?id=" + selectedOption);
    }
    function showPlace() {
        var schemeWidth = document.getElementById("image").clientWidth;
        var schemeHeight = document.getElementById("image").clientHeight;
        var placesList = document.getElementById("places");
        var positionX = placesList.options[placesList.selectedIndex].getAttribute("data-position-x");
        var positionY = placesList.options[placesList.selectedIndex].getAttribute("data-position-y");
        var selectedPlace = document.getElementById("selectedPlace");
        selectedPlace.style.display = '';
        selectedPlace.style.color = 'red';
        selectedPlace.style.position = 'absolute';
        selectedPlace.style.left = Number(positionX) / 100 * schemeWidth + 13 + '';
        selectedPlace.style.top = Number(positionY) / 100 * schemeHeight - 25 + '';
        selectedPlace.style.zIndex = '1';
        console.log(document.getElementById("image").clientHeight);
    }
</script>
</body>
</html>

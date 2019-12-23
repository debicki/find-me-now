<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Panel administratora</title><meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <script>
        function userClicked(event) {
            var schemeWidth = document.getElementById("image").clientWidth;
            var schemeHeight = document.getElementById("image").clientHeight;
            var schemeX = Math.floor(event.offsetX / schemeWidth * 100);
            var schemeY = Math.floor(event.offsetY / schemeHeight * 100);
            var positionX = document.getElementById("positionX");
            var positionY = document.getElementById("positionY");
            var pointer = document.getElementById("X");
            positionX.value = schemeX;
            positionY.value = schemeY;
            pointer.style.display = '';
            pointer.style.color = 'red';
            pointer.style.position = 'absolute';
            pointer.style.left = schemeX / 100 * schemeWidth + 10 + '';
            pointer.style.top = schemeY / 100 * schemeHeight - 4 + '';
        }
        function test() {
            console.log("AAAAAAAAAAA");
        }
    </script>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-12 text-center h1">
            Zaznacz miejsce na schemacie
        </div>
    </div>
    <div class="row">
        <div class="col-1"></div>
        <div class="col-10">
            <form method="post" action="/admin-panel/add-places?id=${schemeId}">
                <div class="form-group">
                    <label for="name"></label>
                    <input type="text" required name="name" id="name" class="form-control" placeholder="Wpisz nazwę miejsca"/>
                </div>
                <div class="form-row">
                    <div class="col-6">
                        <div class="form-group float-right">
                            <label for="positionX"></label>
                            <input type="text" required name="positionX" id="positionX" class="form-control" placeholder="Kliknij w schemat"/>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group float-left">
                            <label for="positionY"></label>
                            <input type="text" required name="positionY" id="positionY" class="form-control" placeholder="Kliknij w schemat"/>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col-8">
                        <button class="btn btn-primary" type="submit">Dodaj punkt</button>
                        <button class="btn btn-secondary" type="reset">Wyczyść dane</button>
                    </div>
                    <div class="col-4">
                        <a href="/scheme-details?id=${schemeId}" class="btn btn-primary float-right">Zakończ</a>
                    </div>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
        <div class="col-1"></div>
    </div>
    <div class="row">
        <div class="col-12 text-center">
            <div>
                <img src="/scheme?id=${schemeId}" class="img-fluid border w-100" alt="Scheme" onclick="userClicked(event)" id="image">
                <div>
                    <i class="fa fa-times" id="X" style="display: none"></i>
                    <c:forEach items="${allPlacesDTOs}" var="place" varStatus="placeStatus">
                        <i class="fa fa-times" id="${place.id}" style="display: none"></i>
                        <script>
                            (function() {
                                var schemeWidth = document.getElementById("image").clientWidth;
                                var schemeHeight = document.getElementById("image").clientHeight;
                                var place = document.getElementById(${place.id});
                                place.style.display = '';
                                place.style.color = 'yellow';
                                place.style.position = 'absolute';
                                place.style.left = Number(${place.coordinateX}) / 100 * schemeWidth + 10 + '';
                                place.style.top = Number(${place.coordinateY}) / 100 * schemeHeight - 4 + '';
                            })();
                        </script>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

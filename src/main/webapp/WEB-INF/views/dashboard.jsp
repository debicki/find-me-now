<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Find me now!</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<div class="container-fluid">
    <div class="row">
        <div class="col-2"></div>
        <div class="col-8">
            <form method="post" action="/?id=${visibleSchemeId}">
                <div class="form-row">
                    <div class="col-11 form-group">
                        <c:if test="${lastName == null}">
                            <input type="text" required name="search" id="search" class="form-control"
                                   placeholder="Podaj nazwisko"/>
                        </c:if>
                        <c:if test="${lastName != null}">
                        <input type="text" required name="search" id="search" class="form-control"
                               placeholder="${lastName}"/>
                        </c:if>
                    </div>
                    <div class="col-1 form-group">
                        <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i> Szukaj</button>
                    </div>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <c:if test="${allActiveSchemeDTOS.size() == 0}">
            <div class="col-12 display-4 text-center">Baza danych nie zawiera aktywnych schematów!</div>
        </c:if>
        <c:if test="${allActiveSchemeDTOS.size() > 0}">
            <div class="col-1"></div>
            <div class="col-1">
                <c:forEach items="${allActiveSchemeDTOS}" var="schemeDTO" varStatus="schemeDAOStatus">
                        <c:if test="${schemeIds.contains(schemeDTO.id) || activeSearch == false}">
                            <a href="/?id=${schemeDTO.id}&search=${lastName}" class="btn btn-primary float-right">${schemeDTO.name}</a>
                            <br>
                            <br>
                        </c:if>
                        <c:if test="${!schemeIds.contains(schemeDTO.id) && activeSearch == true}">
                            <a href="/?id=${schemeDTO.id}&search=${lastName}" class="btn btn-secondary float-right">${schemeDTO.name}</a>
                            <br>
                            <br>
                        </c:if>
                </c:forEach>
            </div>
            <div class="col-8">
                    <img src="/scheme?id=${visibleSchemeId}" class="img-fluid w-100" alt="Scheme" id="image">
                <c:forEach items="${placeDTOS}" var="placeDTO">
                    <c:if test="${placeDTO.getSchemeId() == visibleSchemeId}">
                        <div class="h1">
                            <i class="fa fa-street-view" style="display: none" id="${placeDTO.id}"></i>
                            <script>
                                (function() {
                                    var schemeWidth = document.getElementById("image").clientWidth;
                                    var schemeHeight = document.getElementById("image").clientHeight;
                                    var place = document.getElementById("${placeDTO.id}");
                                    place.style.display = '';
                                    place.style.color = 'red';
                                    place.style.position = 'absolute';
                                    place.style.left = Number(${placeDTO.coordinateX}) / 100 * schemeWidth + 5 + '';
                                    place.style.top = Number(${placeDTO.coordinateY}) / 100 * schemeHeight - 25 + '';
                                })();
                            </script>
                        </div>
                    </c:if>
                </c:forEach>
            </div></div>
        </c:if>
    </div>
</div>
</body>
</html>

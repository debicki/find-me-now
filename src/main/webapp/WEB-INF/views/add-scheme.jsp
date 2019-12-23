<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Panel administratora</title><meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="/bootstrap.min.css">
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
</head>
<body>
<jsp:include page="fragments/header.jsp"/>
<jsp:include page="fragments/menu.jsp"/>
<div class="container">
    <div class="row">
        <div class="col-1"></div>
        <div class="col-6">
            <form method="post" enctype="multipart/form-data" action="/admin-panel/add-scheme">
                <div class="form-group">
                    <label for="file">Plik ze schematem</label>
                    <input type="file" required name="file" id="file" class="form-control"/>
                </div>
                <div class="form-group">
                    <label for="name">Nazwa schematu</label>
                    <input type="text" required name="name" id="name" class="form-control" placeholder="Podaj nazwę dla schematu"/>
                </div>
                <div class="form-group">
                    <label for="description">Opis schematu</label>
                    <input type="text" name="description" id="description" class="form-control" placeholder="Podaj opis schematu (opcjonalne)"/>
                </div>
                <button class="btn btn-primary" type="submit">Wyślij</button>
                <button class="btn btn-secondary" type="reset">Wyczyść dane</button>
                <sec:csrfInput/>
            </form>
        </div>
        <div class="col-5"></div>
    </div>
</div>
</body>
</html>

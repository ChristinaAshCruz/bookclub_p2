<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>View Book</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/style.css" />
    <!-- change to match your file/naming structure -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script>
    <!-- change to match your file/naming structure -->
  </head>
  <body>
    <div
      class="d-flex justify-content-between align-items-baseline mb-3"
      id="header"
    >
      <h1>
        <em><c:out value="${book.title}"></c:out></em>
      </h1>
      <span
        ><a href="/dashboard" class="btn btn-primary"
          >Back to Dashboard</a
        ></span
      >
    </div>
    <div class="card mb-3 p-3" id="info-row">
      <h4>
        <c:choose>
          <c:when test="${book.ownedBy.id == sessionScope.userId}">
            <span class="text-danger">You</span>
          </c:when>
          <c:when test="${book.ownedBy.id != sessionScope.userId}">
            <span class="text-danger"
              ><c:out value="${book.ownedBy.name}"></c:out
            ></span>
          </c:when>
        </c:choose>
        read
        <span class="text-success"><c:out value="${book.title}"></c:out></span>
        by
        <span class="text-primary"><c:out value="${book.author}"></c:out></span>
      </h4>
    </div>

    <div class="card p-3 mb-3">
      <h4>Here are <c:out value="${book.ownedBy.name}"></c:out>'s thoughts:</h4>
      <hr />
      <p>
        <c:out value="${book.thoughts}"></c:out>
      </p>
      <hr />
    </div>
    <c:if test="${book.ownedBy.id == sessionScope.userId}">
      <div class="d-flex justify-content-end">
        <a href="/book/${book.id}/edit" class="btn btn-primary me-2 col-1"
          >Edit</a
        >
        <a href="/book/${book.id}/delete" class="btn btn-danger col-1"
          >Delete</a
        >
      </div>
    </c:if>
  </body>
</html>

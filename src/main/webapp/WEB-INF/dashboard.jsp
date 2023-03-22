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
    <title>Dashboard</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/style.css" />
    <!-- change to match your file/naming structure -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script>
    <!-- change to match your file/naming structure -->
    <!-- FONTS -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito+Sans:ital,wght@0,400;0,700;1,400&family=Nunito:ital,wght@0,900;0,1000;1,900;1,1000&display=swap"
      rel="stylesheet"
    />
    <!--  -->
  </head>
  <body>
    <div
      class="d-flex justify-content-between align-items-baseline mb-3"
      id="header"
    >
      <h1>Welcome, <c:out value="${user.name}"></c:out>!</h1>
      <span><a href="/" class="btn btn-primary">Logout</a></span>
    </div>
    <hr />
    <div
      class="d-flex justify-content-between align-items-baseline mb-3"
      id="header"
    >
      <h4>Books from everyone's shelves</h4>
      <span
        ><a href="/book/new" class="btn btn-primary"
          >+ Add a book to my shelf!</a
        ></span
      >
    </div>
    <div class="col-10" id="body">
      <div class="card p-3 mb-3">
        <h3>Books</h3>
        <table class="table" id="directory">
          <thead>
            <tr id="header-row">
              <th scope="col">ID</th>
              <th scope="col">Title</th>
              <th scope="col">Author</th>
              <th scope="col">Posted By:</th>
              <th scope="col">Actions</th>
            </tr>
          </thead>
          <c:forEach var="book" items="${allBooks}">
            <tr>
              <td><c:out value="${book.id}"></c:out></td>
              <td>
                <a href="/book/${book.id}/view"
                  ><c:out value="${book.title}"
                /></a>
              </td>
              <td><c:out value="${book.author}"></c:out></td>
              <c:choose>
                <c:when test="${book.submittedBy.id == user.id}">
                  <td class="fw-bold text-primary">You</td>
                </c:when>
                <c:when test="${book.submittedBy.id != user.id}">
                  <td class="fw-bold">
                    <c:out value="${book.submittedBy.name}"></c:out>
                  </td>
                </c:when>
              </c:choose>
              <td>
                <c:if test="${book.submittedBy.id == sessionScope.userId}">
                  <a
                    href="/book/${book.id}/edit"
                    class="btn btn-primary col-3 me-2"
                    >Edit</a
                  >
                  <a href="/book/${book.id}/delete" class="btn btn-danger col-3"
                    >Delete</a
                  >
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </table>
      </div>
      <!-- <span
        ><a href="/book/new" class="btn btn-primary"
          >Add a new book entry!</a
        ></span
      > -->
    </div>
  </body>
</html>

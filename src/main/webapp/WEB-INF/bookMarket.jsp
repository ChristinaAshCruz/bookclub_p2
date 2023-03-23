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
    <title>Book Market</title>
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
      class="d-flex justify-content-between align-items-end mb-3"
      id="header"
    >
      <div>
        <h5>Hey, <c:out value="${user.name}"></c:out>...</h5>
        <h1>Welcome to the Book Market!</h1>
      </div>
      <div>
        <span
          ><a href="/dashboard" class="btn btn-primary">Back to Home</a></span
        >
        <span><a href="/logout" class="btn btn-primary">Logout</a></span>
      </div>
    </div>
    <hr class="mb-4" />
    <div class="col-10" id="body">
      <div class="card p-3 mb-3">
        <h3>Available Books:</h3>
        <hr class="mt-0" />
        <table class="table" id="directory">
          <thead>
            <tr id="header-row">
              <th scope="col">ID</th>
              <th scope="col">Title</th>
              <th scope="col">Author</th>
              <th scope="col">Owner:</th>
              <th scope="col">Actions</th>
            </tr>
          </thead>
          <c:forEach var="book" items="${allBooks}">
            <c:choose>
              <c:when
                test="${book.bookBorrower == null && book.ownedBy.id != sessionScope.userId}"
              >
                <tr>
                  <td>
                    <c:out value="${book.id}" />
                  </td>
                  <td>
                    <a href="/book/${book.id}/view">
                      <c:out value="${book.title}" />
                    </a>
                  </td>
                  <td><c:out value="${book.author}" /></td>
                  <td><c:out value="${book.ownedBy.name}" /></td>
                  <td>
                    <a href="/book/${book.id}/borrow" class="btn btn-success"
                      >Borrow</a
                    >
                  </td>
                </tr>
              </c:when>
              <c:when
                test="${book.bookBorrower == null && book.ownedBy.id == sessionScope.userId}"
              >
                <tr>
                  <td><c:out value="${book.id}" /></td>
                  <td>
                    <a href="/book/${book.id}/view">
                      <c:out value="${book.title}" />
                    </a>
                  </td>
                  <td><c:out value="${book.author}" /></td>
                  <td>
                    <em><strong>You</strong></em>
                  </td>
                  <td>
                    <a href="/book/${book.id}/edit" class="btn btn-primary"
                      >Edit</a
                    >
                    <a href="/book/${book.id}/delete" class="btn btn-danger"
                      >Delete</a
                    >
                  </td>
                </tr>
              </c:when>
            </c:choose>
          </c:forEach>
        </table>
      </div>
      <div class="card p-3 mb-3">
        <h3>Your Borrowed Books:</h3>
        <hr class="mt-0" />
        <table class="table" id="directory">
          <thead>
            <tr id="header-row">
              <th scope="col">ID</th>
              <th scope="col">Title</th>
              <th scope="col">Author</th>
              <th scope="col">Owner:</th>
              <th scope="col">Actions</th>
            </tr>
          </thead>
          <c:forEach var="book" items="${allBooks}">
            <c:if test="${book.bookBorrower.id == sessionScope.userId}">
              <tr>
                <td><c:out value="${book.id}" /></td>
                <td>
                  <a href="/book/${book.id}/view">
                    <c:out value="${book.title}" />
                  </a>
                </td>
                <td><c:out value="${book.author}" /></td>
                <td><c:out value="${book.ownedBy.name}" /></td>
                <td>
                  <a href="/book/${book.id}/return" class="btn btn-warning"
                    >Return</a
                  >
                </td>
              </tr>
            </c:if>
          </c:forEach>
        </table>
      </div>
    </div>
  </body>
</html>

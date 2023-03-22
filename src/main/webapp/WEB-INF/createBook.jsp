<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>New Book</title>
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
      <h1>Add a Book to Your Shelf!</h1>
      <span
        ><a href="/dashboard" class="btn btn-primary"
          >Back to Dashboard</a
        ></span
      >
    </div>
    <hr />
    <div class="col-10" id="body">
      <div class="mt-4">
        <form:form
          action="/book/new"
          method="POST"
          modelAttribute="book"
          class="mt-3"
        >
          <div class="card p-3 mb-3" id="form-card">
            <div class="mb-3">
              <form:label path="title" class="form-label">Title:</form:label>
              <form:input path="title" class="form-control" />
            </div>
            <div class="mb-3">
              <form:errors path="title" class="text-danger mb-3"></form:errors>
            </div>
            <div class="mb-3">
              <form:label path="author" class="form-label">Author:</form:label>
              <form:input path="author" class="form-control" />
            </div>
            <div class="mb-3">
              <form:errors path="author" class="text-danger mb-3"></form:errors>
            </div>
            <div class="mb-3">
              <form:label for="thoughts" class="mb-2" path="thoughts"
                >My Thoughts:</form:label
              >
              <form:textarea
                class="form-control"
                placeholder="Write your thoughts here..."
                name="thoughts"
                path="thoughts"
                style="height: 100px"
              ></form:textarea>
            </div>
            <div class="mb-3">
              <form:errors
                path="thoughts"
                class="text-danger mb-3"
              ></form:errors>
            </div>
            <!-- <form:input
              path="submittedBy"
              value="${book.submittedBy.id}"
              type="hidden"
            />
            <form:errors
              path="submittedBy"
              class="text-danger mb-3"
            ></form:errors>
            <form:input path="id" value="${book.id}" type="hidden" />
            <form:errors path="id" class="text-danger mb-3"></form:errors> -->
            <button class="btn btn-primary col-2">Submit</button>
          </div>
        </form:form>
      </div>
    </div>
  </body>
</html>

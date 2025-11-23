<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<html>
  <head>
    <title>Course Management</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      h1 {
        color: #333;
      }
      table {
        border-collapse: collapse;
        width: 80%;
      }
      th,
      td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
      }
      th {
        background-color: #f2f2f2;
      }
      a {
        text-decoration: none;
        color: #007bff;
      }
      a:hover {
        text-decoration: underline;
      }
      .btn {
        padding: 5px 10px;
        background-color: #28a745;
        color: white;
        border-radius: 3px;
      }
      .btn-secondary {
        background-color: #6c757d;
      }
    </style>
  </head>
  <body>
    <center>
      <h1>Course Management</h1>
      <h2>
        <a href="new_course" class="btn">Add New Course</a>
        &nbsp;&nbsp;&nbsp;
        <a href="list" class="btn btn-secondary">Back to Students</a>
      </h2>
    </center>
    <div align="center">
      <table border="1" cellpadding="5">
        <caption>
          <h2>List of Courses</h2>
        </caption>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Fees</th>
          <th>Actions</th>
        </tr>
        <c:forEach var="course" items="${listCourses}">
          <tr>
            <td><c:out value="${course.id}" /></td>
            <td><c:out value="${course.name}" /></td>
            <td><c:out value="${course.fees}" /></td>
            <td>
              <a href="edit_course?id=<c:out value='${course.id}' />">Edit</a>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="delete_course?id=<c:out value='${course.id}' />"
                >Delete</a
              >
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </body>
</html>

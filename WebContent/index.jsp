<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<html>
  <head>
    <title>Student Management Application</title>
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
        width: 100%;
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
      .btn-danger {
        background-color: #dc3545;
      }
      .btn-info {
        background-color: #17a2b8;
      }
    </style>
  </head>
  <body>
    <center>
      <h1>Student Management Application</h1>
      <h2>
        <a href="new" class="btn">Add New Student</a>
        &nbsp;&nbsp;&nbsp;
        <a href="list_courses" class="btn btn-info">Manage Courses</a>
      </h2>
    </center>
    <div align="center">
      <table border="1" cellpadding="5">
        <caption>
          <h2>List of Students</h2>
        </caption>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Email</th>
          <th>Course</th>
          <th>Actions</th>
        </tr>
        <c:forEach var="student" items="${listStudents}" varStatus="status">
          <tr>
            <td><c:out value="${status.count}" /></td>
            <td><c:out value="${student.name}" /></td>
            <td><c:out value="${student.email}" /></td>
            <td><c:out value="${student.courseName}" /></td>
            <td>
              <a href="edit?id=<c:out value='${student.id}' />">Edit</a>
              &nbsp;&nbsp;&nbsp;&nbsp;
              <a href="delete?id=<c:out value='${student.id}' />">Delete</a>
            </td>
          </tr>
        </c:forEach>
      </table>
    </div>
  </body>
</html>

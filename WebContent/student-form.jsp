<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>
        <c:if test="${student != null}">Edit Student</c:if>
        <c:if test="${student == null}">Add New Student</c:if>
    </title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        div { margin-bottom: 15px; }
        label { display: inline-block; width: 100px; }
        input[type="text"], input[type="email"], select { padding: 5px; width: 200px; }
        .btn { padding: 5px 15px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <center>
        <h1>
            <c:if test="${student != null}">Edit Student</c:if>
            <c:if test="${student == null}">Add New Student</c:if>
        </h1>
        <h2>
            <a href="list">List All Students</a>
        </h2>
    </center>
    <div align="center">
        <c:if test="${student != null}">
            <form action="update" method="post">
        </c:if>
        <c:if test="${student == null}">
            <form action="insert" method="post">
        </c:if>

        <table border="1" cellpadding="5">
            <c:if test="${student != null}">
                <input type="hidden" name="id" value="<c:out value='${student.id}' />" />
            </c:if>
            <tr>
                <th>Name: </th>
                <td>
                    <input type="text" name="name" size="45"
                        value="<c:out value='${student.name}' />" required />
                </td>
            </tr>
            <tr>
                <th>Email: </th>
                <td>
                    <input type="email" name="email" size="45"
                        value="<c:out value='${student.email}' />" required />
                </td>
            </tr>
            <tr>
                <th>Course: </th>
                <td>
                    <select name="course_id" required>
                        <option value="">--Select Course--</option>
                        <c:forEach var="course" items="${listCourses}">
                            <option value="${course.id}" <c:if test="${student.courseId == course.id}">selected</c:if>>
                                <c:out value="${course.name}" />
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Save" class="btn" />
                </td>
            </tr>
        </table>
        </form>
    </div>
</body>
</html>

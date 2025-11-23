<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>
        <c:if test="${course != null}">Edit Course</c:if>
        <c:if test="${course == null}">Add New Course</c:if>
    </title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        div { margin-bottom: 15px; }
        label { display: inline-block; width: 100px; }
        input[type="text"] { padding: 5px; width: 200px; }
        .btn { padding: 5px 15px; background-color: #007bff; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <center>
        <h1>
            <c:if test="${course != null}">Edit Course</c:if>
            <c:if test="${course == null}">Add New Course</c:if>
        </h1>
        <h2>
            <a href="list_courses">List All Courses</a>
        </h2>
    </center>
    <div align="center">
        <c:if test="${course != null}">
            <form action="update_course" method="post">
        </c:if>
        <c:if test="${course == null}">
            <form action="insert_course" method="post">
        </c:if>

        <table border="1" cellpadding="5">
            <c:if test="${course != null}">
                <input type="hidden" name="id" value="<c:out value='${course.id}' />" />
            </c:if>
            <tr>
                <th>Course Name: </th>
                <td>
                    <input type="text" name="name" size="45"
                        value="<c:out value='${course.name}' />" required />
                </td>
            </tr>
            <tr>
                <th>Fees: </th>
                <td>
                    <input type="text" name="fees" size="45"
                        value="<c:out value='${course.fees}' />" required />
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

package com.student.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.student.bean.Course;
import com.student.bean.Student;
import com.student.dao.CourseDAO;
import com.student.dao.StudentDAO;

public class ControllerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    private CourseDAO courseDAO;

    public void init() {
        studentDAO = new StudentDAO();
        courseDAO = new CourseDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                case "/insert":
                    insertStudent(request, response);
                    break;
                case "/delete":
                    deleteStudent(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateStudent(request, response);
                    break;
                case "/list_courses":
                    listCourses(request, response);
                    break;
                case "/new_course":
                    showNewCourseForm(request, response);
                    break;
                case "/insert_course":
                    insertCourse(request, response);
                    break;
                case "/delete_course":
                    deleteCourse(request, response);
                    break;
                case "/edit_course":
                    showEditCourseForm(request, response);
                    break;
                case "/update_course":
                    updateCourse(request, response);
                    break;
                default:
                    listStudents(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    // Student Methods
    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Student> listStudents = studentDAO.selectAllStudents();
        request.setAttribute("listStudents", listStudents);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Course> listCourses = courseDAO.selectAllCourses();
        request.setAttribute("listCourses", listCourses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("student-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student existingStudent = studentDAO.selectStudent(id);
        List<Course> listCourses = courseDAO.selectAllCourses();
        RequestDispatcher dispatcher = request.getRequestDispatcher("student-form.jsp");
        request.setAttribute("student", existingStudent);
        request.setAttribute("listCourses", listCourses);
        dispatcher.forward(request, response);
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int courseId = Integer.parseInt(request.getParameter("course_id"));
        Student newStudent = new Student(name, email, courseId);
        studentDAO.insertStudent(newStudent);
        response.sendRedirect("list");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        int courseId = Integer.parseInt(request.getParameter("course_id"));

        Student book = new Student(id, name, email, courseId, null);
        studentDAO.updateStudent(book);
        response.sendRedirect("list");
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        studentDAO.deleteStudent(id);
        response.sendRedirect("list");
    }

    // Course Methods
    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Course> listCourses = courseDAO.selectAllCourses();
        request.setAttribute("listCourses", listCourses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("list-courses.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewCourseForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("course-form.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditCourseForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Course existingCourse = courseDAO.selectCourse(id);
        RequestDispatcher dispatcher = request.getRequestDispatcher("course-form.jsp");
        request.setAttribute("course", existingCourse);
        dispatcher.forward(request, response);
    }

    private void insertCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String name = request.getParameter("name");
        double fees = Double.parseDouble(request.getParameter("fees"));
        Course newCourse = new Course(name, fees);
        courseDAO.insertCourse(newCourse);
        response.sendRedirect("list_courses");
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double fees = Double.parseDouble(request.getParameter("fees"));

        Course course = new Course(id, name, fees);
        courseDAO.updateCourse(course);
        response.sendRedirect("list_courses");
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        courseDAO.deleteCourse(id);
        response.sendRedirect("list_courses");
    }
}

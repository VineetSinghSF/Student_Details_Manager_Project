package com.student.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.student.bean.Student;
import com.student.util.DBConnection;

public class StudentDAO {

    private static final String INSERT_STUDENT_SQL = "INSERT INTO students (name, email, course_id) VALUES (?, ?, ?);";
    private static final String SELECT_STUDENT_BY_ID = "SELECT s.id, s.name, s.email, s.course_id, c.name as course_name FROM students s LEFT JOIN courses c ON s.course_id = c.id WHERE s.id =?";
    private static final String SELECT_ALL_STUDENTS = "SELECT s.id, s.name, s.email, s.course_id, c.name as course_name FROM students s LEFT JOIN courses c ON s.course_id = c.id";
    private static final String DELETE_STUDENT_SQL = "DELETE FROM students WHERE id = ?;";
    private static final String UPDATE_STUDENT_SQL = "UPDATE students SET name = ?, email = ?, course_id = ? WHERE id = ?;";

    public void insertStudent(Student student) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_STUDENT_SQL)) {
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getEmail());
            preparedStatement.setInt(3, student.getCourseId());
            preparedStatement.executeUpdate();
        }
    }

    public Student selectStudent(int id) {
        Student student = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_STUDENT_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                int courseId = rs.getInt("course_id");
                String courseName = rs.getString("course_name");
                student = new Student(id, name, email, courseId, courseName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return student;
    }

    public List<Student> selectAllStudents() {
        List<Student> students = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_STUDENTS)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                int courseId = rs.getInt("course_id");
                String courseName = rs.getString("course_name");
                students.add(new Student(id, name, email, courseId, courseName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }

    public boolean deleteStudent(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_STUDENT_SQL)) {
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateStudent(Student student) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_STUDENT_SQL)) {
            preparedStatement.setString(1, student.getName());
            preparedStatement.setString(2, student.getEmail());
            preparedStatement.setInt(3, student.getCourseId());
            preparedStatement.setInt(4, student.getId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}

package com.student.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.student.bean.Course;
import com.student.util.DBConnection;

public class CourseDAO {

    private static final String INSERT_COURSE_SQL = "INSERT INTO courses (name, fees) VALUES (?, ?);";
    private static final String SELECT_COURSE_BY_ID = "SELECT id, name, fees FROM courses WHERE id =?";
    private static final String SELECT_ALL_COURSES = "SELECT * FROM courses";
    private static final String DELETE_COURSE_SQL = "DELETE FROM courses WHERE id = ?;";
    private static final String UPDATE_COURSE_SQL = "UPDATE courses SET name = ?, fees = ? WHERE id = ?;";

    public void insertCourse(Course course) throws SQLException {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COURSE_SQL)) {
            preparedStatement.setString(1, course.getName());
            preparedStatement.setDouble(2, course.getFees());
            preparedStatement.executeUpdate();
        }
    }

    public Course selectCourse(int id) {
        Course course = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSE_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String name = rs.getString("name");
                double fees = rs.getDouble("fees");
                course = new Course(id, name, fees);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return course;
    }

    public List<Course> selectAllCourses() {
        List<Course> courses = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSES)) {
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                double fees = rs.getDouble("fees");
                courses.add(new Course(id, name, fees));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    public boolean deleteCourse(int id) throws SQLException {
        boolean rowDeleted;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COURSE_SQL)) {
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        }
        return rowDeleted;
    }

    public boolean updateCourse(Course course) throws SQLException {
        boolean rowUpdated;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COURSE_SQL)) {
            preparedStatement.setString(1, course.getName());
            preparedStatement.setDouble(2, course.getFees());
            preparedStatement.setInt(3, course.getId());

            rowUpdated = preparedStatement.executeUpdate() > 0;
        }
        return rowUpdated;
    }
}

package com.student.bean;

public class Student {
    private int id;
    private String name;
    private String email;
    private int courseId;
    private String courseName; // For display purposes

    public Student() {}

    public Student(int id, String name, String email, int courseId, String courseName) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.courseId = courseId;
        this.courseName = courseName;
    }

    public Student(String name, String email, int courseId) {
        this.name = name;
        this.email = email;
        this.courseId = courseId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
}

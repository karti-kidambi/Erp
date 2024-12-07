<%@page import="com.sdp.erp.model.Course"%>
<%@page import="com.sdp.erp.model.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty - Student List</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Students Enrolled in the Course</h1>
        
        <div class="students-list">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Courses</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        // Get the students list from the request
                        List<Student> students = (List<Student>) request.getAttribute("students");

                        // Check if the list is not empty and iterate over the students
                        if (students != null && !students.isEmpty()) {
                            for (Student student : students) {
                    %>
                    <tr>
                        <td><%= student.getStudentId() %></td>
                        <td><%= student.getName() %></td>
                        <td><%= student.getEmail() %></td>
                        <td>
                            <% 
                                // Iterate over the courses for each student
                                List<Course> studentCourses = student.getCourses();
                                if (studentCourses != null && !studentCourses.isEmpty()) {
                                    for (Course course : studentCourses) {
                            %>
                            <p><%= course.getCourseName() %> (<%= course.getDepartment() %>)</p>
                            <% 
                                    }
                                } else {
                            %>
                            <p>No courses enrolled</p>
                            <% 
                                }
                            %>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4">No students found for this course.</td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

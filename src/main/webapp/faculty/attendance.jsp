<%@page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.sdp.erp.model.Faculty"%>
<%
Faculty f = (Faculty) session.getAttribute("faculty");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty - Attendance Management</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Mark Attendance</h1>
        
        <form action="/faculty/attendance/save" method="POST">
            <div class="course-select">
                <label for="courseSelect">Select Course:</label>
                <select id="courseSelect" name="courseId" required>
                    <option value="">Select Course</option>
                    <% 
                        List<Course> courses = (List<Course>) request.getAttribute("courses");
                        if (courses != null) {
                            for (Course course : courses) { 
                    %>
                        <option value="<%= course.getCourseId() %>"><%= course.getCourseName() %></option>
                    <% 
                            }
                        }
                    %>
                </select>
                <label for="dateSelect">Date:</label>
                <input type="date" id="dateSelect" name="date" value="<%= request.getAttribute("currentDate") %>" required>
            </div>
            
            <div class="attendance-form">
                <table>
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>Student Name</th>
                            <th>Present</th>
                            <th>Absent</th>
                            <th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody id="studentsList">
                        <% 
                            List<Student> students = (List<Student>) request.getAttribute("students");
                            if (students != null) {
                                for (Student student : students) {
                        %>
                            <tr>
                                <td><%= student.getStudentId() %></td>
                                <td><%= student.getName() %></td>
                                <td><input type="radio" name="attendance-<%= student.getStudentId() %>" value="present" required></td>
                                <td><input type="radio" name="attendance-<%= student.getStudentId() %>" value="absent"></td>
                                <td><input type="text" name="remarks-<%= student.getStudentId() %>"></td>
                            </tr>
                        <% 
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
            <div class="action-buttons">
                <button type="submit">Save Attendance</button>
            </div>
        </form>
    </div>
</body>
</html>

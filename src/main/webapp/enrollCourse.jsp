<%@page import="com.sdp.erp.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.Student"%>
<%
Student s =  (Student)session.getAttribute("student");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("title") %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        .container {
            width: 80%;
            max-width: 1000px;
            margin: 2rem auto;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        h1 {
            background-color: #2c3e50;
            color: white;
            padding: 1rem;
            text-align: center;
            margin-bottom: 1rem;
        }

        .message {
            padding: 2rem;
            font-size: 1.2rem;
            color: #2ecc71;
            text-align: center;
        }

        .student-details {
            margin-top: 2rem;
            text-align: center;
        }

        .course-list {
            margin-top: 2rem;
            text-align: center;
        }

        .course-list ul {
            list-style-type: none;
            padding: 0;
        }

        .course-list li {
            margin: 8px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><%= request.getAttribute("title") %></h1>
        <div class="message">
            <%= request.getAttribute("message") %>
        </div>
        <div class="student-details">
            <p><strong>Student Name:</strong> <%= ((Student) request.getAttribute("student")).getName() %></p>
            <p><strong>Student ID:</strong> <%= ((Student) request.getAttribute("student")).getStudentId() %></p>
        </div>
        <div class="course-list">
            <h3>Enrolled Courses:</h3>
            <ul>
                <%
                    List<Course> courses = ((Student) request.getAttribute("student")).getCourses();
                    if (courses != null && !courses.isEmpty()) {
                        for (Course course : courses) {
                %>
                    <li><%= course.getCourseName() %></li>
                <%
                        }
                    } else {
                %>
                    <li>No courses enrolled yet.</li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</body>
</html>

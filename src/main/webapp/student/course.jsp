<%@page import="com.sdp.erp.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student - My Courses</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>My Courses</h1>

        <div class="courses-grid">
            <% 
                List<Course> courses = (List<Course>) request.getAttribute("courses");
                if (courses != null && !courses.isEmpty()) {
                    for (com.sdp.erp.model.Course course : courses) {
            %>
                        <div class="course-card">
                            <h2><%= course.getCourseName() %></h2>
                            <p><strong>Department:</strong> <%= course.getDepartment() %></p>
                            <p><strong>Credits:</strong> <%= course.getCredits() %></p>
                        </div>
            <% 
                    }
                } else {
            %>
                <p>No courses available at the moment.</p>
            <% 
                }
            %>
        </div>

        
    </div>
</body>
</html>

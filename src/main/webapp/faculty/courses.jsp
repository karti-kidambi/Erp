<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sdp.erp.model.Course"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty - My Courses</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>My Courses</h1>
        
        <div class="courses-grid">
            <%
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    if (courses != null && !courses.isEmpty()) {
        for (Course course : courses) {
%>
            <div class="course-card">
                <h3><%= course.getCourseName() %></h3>
                <p>Department: <%= course.getDepartment() %></p>
                <p>Credits: <%= course.getCredits() %></p>
                <a href="students?courseId=<%=course.getCourseId() %>">View Students</a>
            </div>
<%
        }
    } else {
%>
        <p>No courses assigned to you yet.</p>
<%
    }
%>

        </div>
        
        
    </div>
    <script>
 // Open the upload material modal
    function uploadMaterial() {
        document.getElementById('uploadModal').style.display = 'block';
    }

    // Close the modal
    function closeModal() {
        document.getElementById('uploadModal').style.display = 'none';
    }

    // Manage assignments (Navigate to assignments page)
    function manageAssignments() {
        window.location.href = '/faculty/assignments';
    }

    // View students enrolled in courses (Navigate to students list page)
    function viewStudentList() {
        window.location.href = '/faculty/students';
    }

    </script>
</body>
</html>

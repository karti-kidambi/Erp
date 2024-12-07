<%@page import="com.sdp.erp.model.Faculty"%>
<%@page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Course Management</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
    .modal {
    display: none; /* Hidden by default */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

.modal-content {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 50%; /* Width of modal */
}
    
    </style>
</head>
<body>
    <div class="container">
        <h1>Course Management</h1>
        
        <div class="action-buttons">
            <button onclick="showAddCourseModal()">Add New Course</button>
        </div>
        
        <div class="courses-table">
            <table>
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Registered Students</th>
                    </tr>
                </thead>
                <tbody>
    <% 
        List<Course> clist = (List<Course>) request.getAttribute("courselist"); 
        for (Course course : clist) {
    %>
        <tr>
            <td><%= course.getCourseId() %></td>
            <td><%= course.getCourseName() %></td>
            <td>
                <ul>
                    <% 
                        List<Student> students = course.getStudents(); 
                        if (students != null && !students.isEmpty()) {
                            for (Student student : students) { 
                    %>
                        <li><%= student.getStudentId() %> - <%= student.getName() %></li>
                    <% 
                            } 
                        } else { 
                    %>
                        <li>No students enrolled</li>
                    <% 
                        } 
                    %>
                </ul>
            </td>
        </tr>
    <% 
        } 
    %>
</tbody>

            </table>
        </div>
        
        <!-- Add/Edit Course Modal -->
<div id="courseModal" class="modal">
    <div class="modal-content">
        <h2>Course Details</h2>
        <form id="courseForm" action="/admin/addCourse" method="POST">
            <!-- Course Details -->
            <input type="text" name="courseName" placeholder="Course Name" required>
            <input type="text" name="department" placeholder="Department" required>
            <input type="number" name="credits" placeholder="Credits" required>
            
            <!-- Faculty Selection -->
            <label for="facultySelect">Select Faculty:</label>
            <select id="facultySelect" name="facultyId" required>
                <% 
                    List<Faculty> facultyList = (List<Faculty>) request.getAttribute("facultylist"); 
                    for (Faculty faculty : facultyList) { 
                %>
                    <option value="<%= faculty.getFacultyId() %>">
                        <%= faculty.getUsername() %> - <%= faculty.getEmail() %>
                    </option>
                <% 
                    } 
                %>
            </select>
            
            <!-- Buttons -->
            <button type="submit">Save</button>
            <button type="button" onclick="closeModal()">Cancel</button>
        </form>
    </div>
</div>
<script>
//Function to open the modal
function showAddCourseModal() {
    const modal = document.getElementById('courseModal');
    modal.style.display = 'block';
}

// Function to close the modal
function closeModal() {
    const modal = document.getElementById('courseModal');
    modal.style.display = 'none';
}

// Close the modal if the user clicks outside of it
window.onclick = function(event) {
    const modal = document.getElementById('courseModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
};

</script>
    
</body>
</html>
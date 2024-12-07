<%@page import="com.sdp.erp.model.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Student Management</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Student Management</h1>
        
        <div class="action-buttons">
            <button onclick="showAddStudentModal()">Add New Student</button>
        </div>
        
        <div class="search-filters">
            <input type="text" placeholder="Search students...">
            <select id="departmentFilter">
                <option value="">All Departments</option>
                <!-- Populate dynamically -->
            </select>
        </div>
        
        <div class="students-table">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="studentsData">
    <% 
        List<Student> studentsList = (List<Student>) request.getAttribute("studentsList"); 
        if (studentsList != null && !studentsList.isEmpty()) {
            for (Student student : studentsList) { 
    %>
    <tr>
        <td><%= student.getStudentId() %></td>
        <td><%= student.getName() %></td>
        <td><%= student.getEmail() %></td>
        <td>
            <a href="/admin/student/edit/<%=student.getStudentId() %>">Edit</a>
            <form action="student/delete/<%= student.getStudentId() %>" method="POST" style="display:inline;">
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% 
            } 
        } else { 
    %>
    <tr>
        <td colspan="4">No students found.</td>
    </tr>
    <% 
        } 
    %>
</tbody>

            </table>
        </div>
         <!-- Add/Edit Student Modal -->
        <div id="studentModal" class="modal">
            <div class="modal-content">
                <h2>Student Details</h2>
                <form id="studentForm" action="addstudent" method="POST">
                    <input type="text" name="name" placeholder="Full Name" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="tel" name="phone" placeholder="Phone" required>
                    <select id="deptSelect" name="department" required>
                    <option value="">--Select--</option>
                        <option value="CSE">CSE</option>
                        <option value="ECE">ECE</option>
                    </select>
                    <button type="submit">Save</button>
                    <button type="button" onclick="closeModal()">Cancel</button>
                </form>
            </div>
        </div>
    </div>
        
        
</body>
<script>
//Function to open the modal
function showAddStudentModal() {
    const modal = document.getElementById('studentModal');
    modal.style.display = 'block';
}

// Function to close the modal
function closeModal() {
    const modal = document.getElementById('studentModal');
    modal.style.display = 'none';
}

// Close the modal if the user clicks outside of it
window.onclick = function (event) {
    const modal = document.getElementById('studentModal');
    if (event.target === modal) {
        modal.style.display = 'none';
    }
};

// Optional: Close modal with the "Escape" key
document.addEventListener('keydown', function (event) {
    const modal = document.getElementById('studentModal');
    if (event.key === 'Escape' && modal.style.display === 'block') {
        modal.style.display = 'none';
    }
});



</script>
</html>

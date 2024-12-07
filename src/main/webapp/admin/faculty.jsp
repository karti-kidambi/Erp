<%@page import="com.sdp.erp.model.Faculty"%>
<%@page import="com.sdp.erp.model.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Faculty Management</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Faculty Management</h1>
        
        <div class="action-buttons">
            <button onclick="showAddStudentModal()">Add New Faculty</button>
        </div>
        
        <div class="search-filters">
            <input type="text" placeholder="Search Facultys...">
            <select id="departmentFilter">
                <option value="">All Departments</option>
                <!-- Populate dynamically -->
            </select>
        </div>
        
        <div class="students-table">
            <table>
                <thead>
                    <tr>
                        <th>Faculty ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="StudentsData">
                    <% 
                    List<Faculty> facultyList = (List<Faculty>) request.getAttribute("facultylist"); 
                    for (Faculty faculty : facultyList) { 
                %>
                
                    <tr>
                        <td><%= faculty.getFacultyId() %></td>
                        <td><%= faculty.getUsername() %></td>
                        <td><%= faculty.getEmail() %></td>
                        <td>
                            <a href="/admin/edit/<%=faculty.getFacultyId()%>">Edit</a>
                            <form action="faculty/delete/<%= faculty.getFacultyId() %>" method="POST" style="display:inline;">
                			<button type="submit">Delete</button>
            				</form>
                        </td>
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
                <h2>Faculty Details</h2>
                <form id="studentForm" action="faculties" method="POST">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <select id="deptSelect" name="department" required>
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
//Open the modal with pre-filled data for editing
function editStudent(facultyId) {
    fetch(`/admin/faculty/edit/${facultyId}`)
        .then((response) => response.json())
        .then((faculty) => {
            if (faculty) {
                const modal = document.getElementById('studentModal');
                modal.style.display = 'block';

                document.querySelector('#studentForm input[name="username"]').value = faculty.username;
                document.querySelector('#studentForm input[name="email"]').value = faculty.email;
                document.querySelector('#studentForm select[name="department"]').value = faculty.department;

                // Update form action for edit
                document.getElementById('studentForm').action = `/admin/faculty/update/${facultyId}`;
            }
        })
        .catch((error) => console.error('Error fetching faculty details:', error));
}





</script>
</html>

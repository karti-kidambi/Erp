<%@page import="com.sdp.erp.model.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Student</title>
    <style>
    body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.container {
    width: 80%;
    margin: 20px auto;
    background: #fff;
    padding: 20px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    color: #333;
}

.form-group {
    margin-bottom: 15px;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

input, select, button, a.cancel-button {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
}

button, a.cancel-button {
    background-color: #007bff;
    color: white;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
}

button:hover, a.cancel-button:hover {
    background-color: #0056b3;
}

a.cancel-button {
    display: inline-block;
    text-align: center;
    color: white;
    text-decoration: none;
}

button[type="submit"] {
    background-color: #28a745;
}

button[type="submit"]:hover {
    background-color: #218838;
}

.cancel-button {
    background-color: #dc3545;
}

.cancel-button:hover {
    background-color: #c82333;
}
    
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Student</h1>
        <form action="/admin/updatestudent" method="POST">
            <!-- Hidden field to pass student ID -->
            <input type="hidden" name="studentId" value="<%= ((Student) request.getAttribute("student")).getStudentId() %>" required>
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" value="<%= ((Student) request.getAttribute("student")).getName() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= ((Student) request.getAttribute("student")).getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="gradepoint">CGPA :</label>
                <input type="number" step="0.1" max="10" min="1" id="gradepoint" name="gradepoint" value="<%= ((Student) request.getAttribute("student")).getGradepoint() %>" required>
            </div>
            <button type="submit">Update</button>
            <a href="students" class="cancel-button">Cancel</a>
        </form>
    </div>
</body>
</html>

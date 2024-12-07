<%@page import="com.sdp.erp.model.Faculty"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Faculty</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
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
        button {
            background-color: #28a745;
            color: white;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #218838;
        }
        a.cancel-button {
            display: inline-block;
            text-align: center;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            padding: 10px;
            margin-top: 10px;
            border-radius: 4px;
        }
        a.cancel-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Edit Faculty</h1>
        <form action="/admin/update/<%= ((Faculty) request.getAttribute("faculty")).getFacultyId() %>" method="POST">
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" 
                       value="<%= ((Faculty) request.getAttribute("faculty")).getUsername() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" 
                       value="<%= ((Faculty) request.getAttribute("faculty")).getEmail() %>" required>
            </div>
            <div class="form-group">
                <label for="department">Department:</label>
                <select id="department" name="department" required>
                    <option value="CSE" <%= "CSE".equals(((Faculty) request.getAttribute("faculty")).getDepartment()) ? "selected" : "" %>>CSE</option>
                    <option value="ECE" <%= "ECE".equals(((Faculty) request.getAttribute("faculty")).getDepartment()) ? "selected" : "" %>>ECE</option>
                </select>
            </div>
            <button type="submit">Update</button>
            <a href="/admin/faculty" class="cancel-button">Cancel</a>
        </form>
    </div>
</body>
</html>

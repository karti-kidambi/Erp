<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sdp.erp.model.GradePoints"%>
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
            width: 90%;
            max-width: 1200px;
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

        .grade-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 1rem;
        }

        .grade-table th, .grade-table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        .grade-table th {
            background-color: #3498db;
            color: white;
        }

        .grade-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .grade-table tbody tr:hover {
            background-color: #e6f2ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><%= request.getAttribute("title") %></h1>
        <table class="grade-table">
            <thead>
                <tr>
                    <th>Course Name</th>
                    <th>Grade</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<GradePoints> gradePoints = (List<GradePoints>) request.getAttribute("gradePoints");
                    if (gradePoints != null && !gradePoints.isEmpty()) {
                        for (GradePoints grade : gradePoints) {
                %>
                    <tr>
                        <td><%= grade.getStudentId() %></td>
                        <td><%= grade.getGrade() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="3">No grades available.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>

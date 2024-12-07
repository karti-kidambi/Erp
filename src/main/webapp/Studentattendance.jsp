<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sdp.erp.model.Attendance"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
    <style>
        /* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f4;
    line-height: 1.6;
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

.attendance-details {
    padding: 1rem;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table thead {
    background-color: #3498db;
    color: white;
}

table th, table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
}

table tbody tr:hover {
    background-color: #e6f2ff;
    transition: background-color 0.3s ease;
}

/* Responsive design */
@media screen and (max-width: 600px) {
    .container {
        width: 95%;
        margin: 1rem auto;
    }

    table {
        font-size: 0.9rem;
    }

    table th, table td {
        padding: 8px;
    }
}

/* Status color coding */
table .present {
    color: green;
    font-weight: bold;
}

table .absent {
    color: red;
    font-weight: bold;
}

table .late {
    color: orange;
    font-weight: bold;
}

/* Empty state styling */
tbody tr:only-child {
    text-align: center;
    color: #7f8c8d;
    font-style: italic;
}
    </style>
</head>
<body>
    <div class="container">
        <h1>My Attendance Record</h1>       
        <div class="attendance-details">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Course Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="attendanceData">
                    <% 
                        // Get the attendance list and course map from the request
                        List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attlist");
                        Map<Long, String> courseMap = (Map<Long, String>) request.getAttribute("courseMap");
                        
                        if (attendanceList != null) {
                            for (Attendance attendance : attendanceList) {
                                String courseName = "Course not found";
                                if (attendance.getCourseId() != null) {
                                    courseName = courseMap.getOrDefault(attendance.getCourseId(), "Course not found");
                                }
                    %>
                    <tr>
                        <td><%= attendance.getDate() %></td>
                        <td><%= courseName %></td> <!-- Display course name -->
                        <td><%= attendance.getStatus() %></td>
                    </tr>
                    <% 
                            }
                        } else { 
                    %>
                    <tr>
                        <td colspan="4">No attendance records found.</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

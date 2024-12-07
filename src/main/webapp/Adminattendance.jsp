<%@page import="com.sdp.erp.model.Attendance"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Attendance Management</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>Attendance Management</h1>
        <div class="attendance-table">
            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Course</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
               <tbody id="attendanceData">
    <% 
        List<Attendance> attlist = (List<Attendance>) request.getAttribute("attlist"); 
        for (com.sdp.erp.model.Attendance attendance : attlist) {
    %>
        <tr>
            <td><%= attendance.getId() %></td>
            <td><%= attendance.getStudentId() %></td>
            <td><%= attendance.getDate() %></td>
            <td><%= attendance.getStatus() != null && attendance.getStatus().equals("present") ? "Present" : "Absent" %></td>
        </tr>
    <% 
        } 
    %>
</tbody>

            </table>
        </div>
        
    </div>
</body>
</html>
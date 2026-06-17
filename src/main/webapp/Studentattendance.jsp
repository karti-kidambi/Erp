<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.sdp.erp.model.Attendance"%>
<%@ page import="com.sdp.erp.model.Student"%>
<%
Student s = (Student) session.getAttribute("student");
List<Attendance> attendanceList = (List<Attendance>) request.getAttribute("attlist");
Map<Long, String> courseMap = (Map<Long, String>) request.getAttribute("courseMap");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Attendance Logs - DonK-University ERP</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #0f172a;
            --primary-light: #1e293b;
            --accent: #d97706;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --glass: rgba(15, 23, 42, 0.65);
            --glass-border: rgba(255, 255, 255, 0.08);
            --success: #10b981;
            --danger: #ef4444;
            --font-sans: 'Outfit', sans-serif;
            --transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: var(--font-sans);
        }

        body {
            background-color: #0b0f19;
            color: var(--text-main);
            min-height: 100vh;
            padding: 40px 24px;
        }

        .container {
            width: 100%;
            max-width: 960px;
            margin: 0 auto;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .back-btn:hover {
            color: #ffffff;
            transform: translateX(-4px);
        }

        /* Card container */
        .logs-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .logs-header {
            text-align: center;
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 2rem;
            margin-bottom: 2rem;
        }

        .logs-header h1 {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 4px;
        }

        .logs-header p {
            color: var(--accent);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1.5px;
        }

        .student-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 2.5rem;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.2rem;
        }

        .meta-item {
            display: flex;
            flex-direction: column;
        }

        .meta-label {
            font-size: 0.75rem;
            color: var(--text-muted);
            text-transform: uppercase;
            font-weight: 600;
            margin-bottom: 2px;
        }

        .meta-value {
            font-size: 1rem;
            font-weight: 500;
            color: #ffffff;
        }

        /* Attendance Table */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            padding: 14px 18px;
            border-bottom: 2px solid var(--glass-border);
            text-align: left;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 1rem;
        }

        .subject-name {
            font-weight: 600;
            color: #ffffff;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }

        .status-badge.present {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-badge.absent {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/student/" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

        <div class="logs-card">
            <div class="logs-header">
                <h1>Attendance History Logs</h1>
                <p>Complete Daily Attendance Log</p>
            </div>

            <% if (s != null) { %>
            <div class="student-meta">
                <div class="meta-item">
                    <span class="meta-label">Name of Student</span>
                    <span class="meta-value"><%= s.getName() %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Roll Number</span>
                    <span class="meta-value"><%= s.getRollNumber() != null ? s.getRollNumber() : "N/A" %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Department</span>
                    <span class="meta-value"><%= s.getDepartment() != null ? s.getDepartment() : "N/A" %></span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Current Semester</span>
                    <span class="meta-value">Semester <%= s.getSemester() %></span>
                </div>
            </div>
            <% } %>

            <table>
                <thead>
                    <tr>
                        <th>Date of Lecture</th>
                        <th>Subject Name</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (attendanceList != null && !attendanceList.isEmpty()) {
                            for (Attendance attendance : attendanceList) {
                                String courseName = "Subject not found";
                                if (attendance.getCourseId() != null && courseMap != null) {
                                    courseName = courseMap.getOrDefault(attendance.getCourseId(), "Subject not found");
                                }
                                String status = attendance.getStatus();
                                String badgeClass = "present";
                                if ("Absent".equalsIgnoreCase(status)) {
                                    badgeClass = "absent";
                                }
                    %>
                    <tr>
                        <td><%= attendance.getDate() %></td>
                        <td class="subject-name"><%= courseName %></td>
                        <td>
                            <span class="status-badge <%= badgeClass %>">
                                <%= status %>
                            </span>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="3" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                            No attendance logs recorded yet.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>

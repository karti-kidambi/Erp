<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sdp.erp.model.Student"%>
<%
Integer totalStudents = (Integer) request.getAttribute("totalStudents");
Integer totalFaculty = (Integer) request.getAttribute("totalFaculty");
Integer totalCourses = (Integer) request.getAttribute("totalCourses");
Integer shortageCount = (Integer) request.getAttribute("shortageCount");
List<Student> shortageStudents = (List<Student>) request.getAttribute("shortageStudents");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - DonK-University ERP</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --warning: #f59e0b;
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
            line-height: 1.6;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(16px);
            padding: 1.2rem 5%;
            border-bottom: 1px solid var(--glass-border);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--text-main);
        }

        .navbar-brand span {
            color: var(--accent);
        }

        .navbar-links {
            display: flex;
            gap: 25px;
        }

        .navbar-links a {
            text-decoration: none;
            color: var(--text-muted);
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar-links a:hover {
            color: var(--text-main);
        }

        .main-container {
            max-width: 1280px;
            margin: 40px auto;
            padding: 0 24px;
        }

        /* Welcome Section */
        .welcome-header {
            margin-bottom: 2.5rem;
        }

        .welcome-header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .welcome-header p {
            color: var(--text-muted);
            font-weight: 300;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2rem;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            border-color: rgba(255,255,255,0.15);
        }

        .stat-icon {
            font-size: 2.2rem;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 14px;
        }

        .stat-icon.students { color: #3b82f6; background: rgba(59, 130, 246, 0.1); }
        .stat-icon.faculty { color: #ec4899; background: rgba(236, 72, 153, 0.1); }
        .stat-icon.courses { color: #10b981; background: rgba(16, 185, 129, 0.1); }
        .stat-icon.shortage { color: #ef4444; background: rgba(239, 68, 68, 0.1); }

        .stat-details h3 {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 2px;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffffff;
        }

        /* Section Header */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 10px;
        }

        .section-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
        }

        /* Danger Banner */
        .shortage-banner {
            background-color: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.25);
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 2rem;
            color: #fca5a5;
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
        }

        .shortage-banner i {
            color: var(--danger);
            font-size: 1.2rem;
        }

        /* Table Style */
        .table-container {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0,0,0,0.25);
            margin-bottom: 3rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background-color: rgba(255, 255, 255, 0.03);
            color: var(--text-muted);
            padding: 16px 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--glass-border);
            text-align: left;
        }

        td {
            padding: 16px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            font-size: 1rem;
            color: #ffffff;
        }

        .student-name {
            font-weight: 600;
        }

        .roll-number {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .alert-badge {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }

        footer {
            border-top: 1px solid var(--glass-border);
            background-color: #080c14;
            color: #475569;
            padding: 2rem;
            text-align: center;
            font-size: 0.9rem;
            margin-top: 6rem;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-brand">DonK <span>ERP</span></div>
        <div class="navbar-links">
            <a href="/admin/students"><i class="fas fa-users"></i> Students Registry</a>
            <a href="/admin/faculty"><i class="fas fa-chalkboard-teacher"></i> Faculty Registry</a>
            <a href="/admin/courses"><i class="fas fa-book-open"></i> Courses</a>
            <a href="/"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1>Welcome, Registrar</h1>
            <p>DonK-University Campus Management & Administrative Dashboard.</p>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon students"><i class="fas fa-user-graduate"></i></div>
                <div class="stat-details">
                    <h3>Total Students</h3>
                    <div class="stat-value"><%= totalStudents %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon faculty"><i class="fas fa-chalkboard-teacher"></i></div>
                <div class="stat-details">
                    <h3>Total Faculty</h3>
                    <div class="stat-value"><%= totalFaculty %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon courses"><i class="fas fa-scroll"></i></div>
                <div class="stat-details">
                    <h3>Total Courses</h3>
                    <div class="stat-value"><%= totalCourses %></div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon shortage"><i class="fas fa-user-clock"></i></div>
                <div class="stat-details">
                    <h3>Attendance Shortages</h3>
                    <div class="stat-value"><%= shortageCount %></div>
                </div>
            </div>
        </div>

        <!-- Attendance Shortage Alerts Banner -->
        <% if (shortageCount != null && shortageCount > 0) { %>
        <div class="shortage-banner">
            <i class="fas fa-exclamation-circle"></i>
            <span>Warning: <%= shortageCount %> student(s) currently have an attendance record below the mandatory 75% threshold!</span>
        </div>
        <% } %>

        <!-- Attendance Shortage Roster -->
        <div class="section-header">
            <h2>Attendance Shortage Roster (< 75%)</h2>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Department</th>
                        <th>Semester</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (shortageStudents != null && !shortageStudents.isEmpty()) {
                        for (Student s : shortageStudents) {
                    %>
                    <tr>
                        <td class="roll-number"><%= s.getRollNumber() != null ? s.getRollNumber() : "N/A" %></td>
                        <td class="student-name"><%= s.getName() %></td>
                        <td><%= s.getDepartment() != null ? s.getDepartment() : "N/A" %></td>
                        <td>Semester <%= s.getSemester() %></td>
                        <td>
                            <span class="alert-badge"><i class="fas fa-exclamation-triangle"></i> Shortage</span>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                            Excellent! No students currently suffer from attendance shortage (>= 75% for all).
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 DonK-University Academic Portal. All rights reserved.</p>
    </footer>
</body>
</html>
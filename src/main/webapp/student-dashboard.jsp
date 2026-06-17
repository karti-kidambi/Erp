<%@page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.Course"%>
<%@page import="com.sdp.erp.model.GradePoints"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%
Student s = (Student) session.getAttribute("student");
List<Course> courses = (List<Course>) request.getAttribute("courses");
Map<Long, GradePoints> courseGrades = (Map<Long, GradePoints>) request.getAttribute("courseGrades");
Map<Long, Double> courseAttendance = (Map<Long, Double>) request.getAttribute("courseAttendance");
String sgpa = (String) request.getAttribute("sgpa");
String overallAttendance = (String) request.getAttribute("overallAttendance");
double overallAttVal = overallAttendance != null ? Double.parseDouble(overallAttendance) : 100.0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - DonK-University ERP</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0f172a;
            --primary-light: #1e293b;
            --accent: #d97706; /* Indian Amber/Gold */
            --accent-hover: #b45309;
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
            gap: 20px;
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
            margin-bottom: 2rem;
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

        /* Profile details dashboard bar */
        .student-profile-bar {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 1.5rem 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 2.5rem;
        }

        .profile-info-item {
            display: flex;
            flex-direction: column;
        }

        .profile-info-label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .profile-info-value {
            font-size: 1.1rem;
            font-weight: 500;
            color: #ffffff;
        }

        /* Analytics grid */
        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 24px;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2rem;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .stat-icon {
            font-size: 2.5rem;
            color: var(--accent);
            background: rgba(217, 119, 6, 0.1);
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 16px;
        }

        .stat-details h3 {
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
        }

        /* Attendance warning bar style */
        .attendance-bar-container {
            width: 100%;
            height: 8px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 4px;
            margin-top: 10px;
            overflow: hidden;
        }

        .attendance-bar-fill {
            height: 100%;
            border-radius: 4px;
        }

        .attendance-bar-fill.safe {
            background-color: var(--success);
        }

        .attendance-bar-fill.shortage {
            background-color: var(--danger);
        }

        .warning-badge {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
            font-size: 0.8rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            margin-top: 6px;
        }

        .safe-badge {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
            font-size: 0.8rem;
            padding: 4px 10px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            margin-top: 6px;
        }

        /* Section Headings */
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

        /* Course List Table */
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
            text-align: left;
        }

        th {
            background-color: rgba(255, 255, 255, 0.03);
            color: var(--text-muted);
            padding: 18px 24px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--glass-border);
        }

        td {
            padding: 18px 24px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            font-size: 1.05rem;
            color: #ffffff;
        }

        tbody tr {
            transition: var(--transition);
        }

        tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.02);
        }

        .course-name-td {
            font-weight: 600;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
        }

        .badge.danger {
            background-color: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .badge.success {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .grade-letter {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--accent);
        }
        
        .grade-not-published {
            color: var(--text-muted);
            font-size: 0.95rem;
            font-style: italic;
        }

        /* Action Buttons Grid */
        .actions-bar {
            display: flex;
            gap: 15px;
            margin-top: 1.5rem;
        }

        .action-btn {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn:hover {
            background-color: rgba(217, 119, 6, 0.15);
            border-color: var(--accent);
            color: #ffffff;
            transform: translateY(-2px);
        }

        footer {
            border-top: 1px solid var(--glass-border);
            background-color: #080c14;
            color: #475569;
            padding: 2rem;
            text-align: center;
            font-size: 0.9rem;
            margin-top: 5rem;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-brand">DonK <span>ERP</span></div>
        <div class="navbar-links">
            <a href="/student/attendance/<%=s.getStudentId() %>"><i class="fas fa-calendar-check"></i> Attendance</a>
            <a href="/student/viewGrades"><i class="fas fa-graduation-cap"></i> Grades</a>
            <a href="/"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1>Welcome back, <%= s.getName() %></h1>
            <p>Keep track of your academic progress, grades, and schedules.</p>
        </div>

        <!-- Student Profile Details Bar -->
        <div class="student-profile-bar">
            <div class="profile-info-item">
                <span class="profile-info-label">Roll Number</span>
                <span class="profile-info-value"><%= s.getRollNumber() != null ? s.getRollNumber() : "N/A" %></span>
            </div>
            <div class="profile-info-item">
                <span class="profile-info-label">Program & Branch</span>
                <span class="profile-info-value"><%= s.getDepartment() != null ? s.getDepartment() : "N/A" %></span>
            </div>
            <div class="profile-info-item">
                <span class="profile-info-label">Current Semester</span>
                <span class="profile-info-value">Semester <%= s.getSemester() %></span>
            </div>
            <div class="profile-info-item">
                <span class="profile-info-label">Section</span>
                <span class="profile-info-value"><%= s.getSection() != null ? s.getSection() : "A" %></span>
            </div>
        </div>

        <!-- Analytics Grid -->
        <div class="analytics-grid">
            <!-- SGPA Card -->
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-medal"></i></div>
                <div class="stat-details">
                    <h3>Current SGPA</h3>
                    <div class="stat-value"><%= sgpa %></div>
                </div>
            </div>

            <!-- Attendance Card -->
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-user-clock"></i></div>
                <div class="stat-details" style="flex: 1;">
                    <h3>Overall Attendance</h3>
                    <div class="stat-value"><%= overallAttendance %>%</div>
                    <div class="attendance-bar-container">
                        <div class="attendance-bar-fill <%= overallAttVal >= 75 ? "safe" : "shortage" %>" style="width: <%= overallAttendance %>%;"></div>
                    </div>
                    <% if (overallAttVal < 75) { %>
                        <div class="warning-badge"><i class="fas fa-exclamation-triangle"></i> Attendance Shortage!</div>
                    <% } else { %>
                        <div class="safe-badge"><i class="fas fa-check-circle"></i> Safe (>= 75%)</div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Enrolled Courses -->
        <div class="section-header">
            <h2>Enrolled Subjects & Performance</h2>
            <div class="actions-bar">
                <a href="/student/attendance/<%=s.getStudentId() %>" class="action-btn"><i class="fas fa-list"></i> Full Logs</a>
                <a href="/student/viewGrades" class="action-btn"><i class="fas fa-file-invoice"></i> Marksheet</a>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Subject / Course Name</th>
                        <th>Credits</th>
                        <th>Attendance %</th>
                        <th>Internal Marks (Sessional)</th>
                        <th>Grade Letter</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (courses != null && !courses.isEmpty()) {
                        for (Course course : courses) {
                            Double attPct = courseAttendance != null ? courseAttendance.get(course.getCourseId()) : 100.0;
                            double attPctVal = attPct != null ? attPct : 100.0;
                            GradePoints gp = courseGrades != null ? courseGrades.get(course.getCourseId()) : null;
                    %>
                    <tr>
                        <td class="course-name-td"><%= course.getCourseName() %></td>
                        <td><%= course.getCredits() %></td>
                        <td>
                            <span class="badge <%= attPctVal >= 75 ? "success" : "danger" %>">
                                <%= String.format("%.1f", attPctVal) %>%
                            </span>
                        </td>
                        <td>
                            <%= (gp != null && gp.getInternalMarks() != null) ? String.format("%.1f / 30", gp.getInternalMarks()) : "N/A" %>
                        </td>
                        <td>
                            <% if (gp != null && gp.getGradeLetter() != null) { %>
                                <span class="grade-letter"><%= gp.getGradeLetter() %></span>
                            <% } else { %>
                                <span class="grade-not-published">Not Graded Yet</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: var(--text-muted); font-style: italic;">
                            No enrolled subjects found. Please register under the course catalog.
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
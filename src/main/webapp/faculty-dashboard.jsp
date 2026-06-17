<%@page import="com.sdp.erp.model.Faculty"%>
<%
Faculty f = (Faculty) session.getAttribute("faculty");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard - DonK-University ERP</title>
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

        /* Profile bar */
        .faculty-profile-bar {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 16px;
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
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

        /* Cards Grid */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 24px;
        }

        .card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
        }

        .card:hover {
            transform: translateY(-8px);
            border-color: rgba(217, 119, 6, 0.3);
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
        }

        .card-icon {
            font-size: 3rem;
            color: var(--accent);
            margin-bottom: 1.5rem;
            background: rgba(217, 119, 6, 0.1);
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 20px;
        }

        .card h2 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #ffffff;
        }

        .card p {
            font-size: 1rem;
            color: var(--text-muted);
            margin-bottom: 2rem;
            font-weight: 300;
        }

        .btn {
            background: linear-gradient(135deg, var(--accent) 0%, #f59e0b 100%);
            color: #0b0f19;
            text-decoration: none;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
            box-shadow: 0 10px 20px -5px rgba(217, 119, 6, 0.4);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(217, 119, 6, 0.6);
            color: #0b0f19;
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
            <a href="/faculty/courses?facultyId=<%= f.getFacultyId() %>"><i class="fas fa-book"></i> My Subjects</a>
            <a href="/faculty/attendance?facultyId=<%= f.getFacultyId() %>"><i class="fas fa-user-check"></i> Attendance</a>
            <a href="/"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <!-- Welcome Header -->
        <div class="welcome-header">
            <h1>Welcome back, <%= f.getUsername() %></h1>
            <p>Access subject registers, mark daily attendance, and upload midterm/end-semester assessment sheets.</p>
        </div>

        <% if (f != null) { %>
        <!-- Faculty Profile Bar -->
        <div class="faculty-profile-bar">
            <div class="profile-info-item">
                <span class="profile-info-label">Faculty Name</span>
                <span class="profile-info-value"><%= f.getUsername() %></span>
            </div>
            <div class="profile-info-item">
                <span class="profile-info-label">Designation / Department</span>
                <span class="profile-info-value"><%= f.getDepartment() != null ? f.getDepartment() : "Computer Science & Engineering" %></span>
            </div>
            <div class="profile-info-item">
                <span class="profile-info-label">Official Email</span>
                <span class="profile-info-value"><%= f.getEmail() %></span>
            </div>
        </div>
        <% } %>

        <!-- Cards Grid -->
        <div class="dashboard-cards">
            <!-- Courses Card -->
            <div class="card" id="courses">
                <div class="card-icon"><i class="fas fa-graduation-cap"></i></div>
                <div>
                    <h2>Academic Courses</h2>
                    <p>Manage curriculum plans, list students, and configure internal marks grading files.</p>
                </div>
                <a href="/faculty/courses?facultyId=<%=f.getFacultyId() %>" class="btn">View My Courses</a>
            </div>

            <!-- Attendance Card -->
            <div class="card" id="attendance">
                <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
                <div>
                    <h2>Attendance Registers</h2>
                    <p>Mark daily lecture attendance registers and view consolidated student attendance lists.</p>
                </div>
                <a href="/faculty/attendance?facultyId=<%=f.getFacultyId() %>" class="btn">Mark Attendance</a>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 DonK-University Academic Portal. All rights reserved.</p>
    </footer>
</body>
</html>
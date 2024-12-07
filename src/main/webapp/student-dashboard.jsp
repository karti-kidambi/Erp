<%@page import="com.sdp.erp.model.Student"%>
<%
Student s = (Student) session.getAttribute("student");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - College ERP</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --background-color: #f4f6f9;
            --card-shadow: 0 10px 20px rgba(0,0,0,0.1);
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            color: #333;
            line-height: 1.6;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: white;
            padding: 15px 5%;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            letter-spacing: 1px;
        }

        .navbar-links {
            display: flex;
            gap: 25px;
        }

        .navbar-links a {
            text-decoration: none;
            color: var(--secondary-color);
            font-weight: 500;
            transition: all var(--transition-speed) ease;
            position: relative;
            padding-bottom: 5px;
        }

        .navbar-links a:hover {
            color: #2980b9;
        }

        .navbar-links a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #2980b9;
            transition: width var(--transition-speed) ease;
        }

        .navbar-links a:hover::after {
            width: 100%;
        }

        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .content h1 {
            text-align: center;
            margin-bottom: 40px;
            color: var(--primary-color);
            font-weight: 600;
            position: relative;
        }

        .content h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background-color: #2980b9;
        }

        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .card {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: all var(--transition-speed) ease;
            position: relative;
            overflow: hidden;
            border-top: 4px solid transparent;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }

        #courses { border-top-color: #3498db; }
        #attendance { border-top-color: #2ecc71; }
        #grades { border-top-color: #e74c3c; }
        #timetable { border-top-color: #f39c12; }

        .card h2 {
            color: var(--secondary-color);
            margin-bottom: 15px;
            font-size: 1.4rem;
        }

        .card p {
            color: #666;
            margin-bottom: 20px;
        }

.btn {
            display: inline-block;
            background-color: #2980b9;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 25px;
            transition: all var(--transition-speed) ease;
            font-weight: 500;
        }

        .btn:hover {
            background-color: #3498db;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
            }

            .dashboard-cards {
                grid-template-columns: 1fr;
            }
        }

        /* Subtle Background Animation */
        @keyframes gradientBg {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0.03;
            z-index: -1;
            background: linear-gradient(45deg, #f4f6f9, #e9ecef, #dee2e6);
            background-size: 400% 400%;
            animation: gradientBg 15s ease infinite;
        }

        /* Student Specific Styling */
        .student-info {
            text-align: center;
            margin-bottom: 20px;
            background-color: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
        }

        .student-info p {
            margin: 5px 0;
            color: var(--secondary-color);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-brand">College ERP</div>
        <div class="navbar-links">
            <a href="#"><i class="fas fa-user-circle"></i> Profile</a>
            <a href="#"><i class="fas fa-bell"></i> Notifications</a>
            <a href="/"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </nav>

    <div class="main-container">
        <!-- Dashboard Content -->
        <div class="content">
            <h1>Welcome, Student</h1>
            
            <!-- Student Information -->
            <div class="student-info">
                <p><strong>Name:</strong> <%= s.getName() %></p>
                <p><strong>Student ID:</strong> <%= s.getStudentId() %></p>
            </div>

            <div class="dashboard-cards">
                <!-- Courses Card -->
                <div class="card" id="courses">
                    <h2>Courses</h2>
                    <p>View Enrolled Courses</p>
                    <a href="/student/courses?studentId=<%=s.getStudentId() %>" class="btn">My Courses</a>
                </div>
                <!-- Attendance Card -->
                <div class="card" id="attendance">
                    <h2>Attendance</h2>
                    <p>Check Attendance Records</p>
                    <a href="/student/attendance/<%=s.getStudentId() %>" class="btn">View Attendance</a>
                </div>
                <!-- Grades Card -->
                <div class="card" id="grades">
                    <h2>Grades</h2>
                    <p>View Academic Performance</p>
                    <a href="/student/viewGrades" class="btn">My Grades</a>
                </div>
            </div>
        </div>
    </div>

<script>
        // Subtle card interaction
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'scale(1.03) rotate(1deg)';
            });
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'scale(1) rotate(0)';
            });
        });
    </script>
</body>
</html>
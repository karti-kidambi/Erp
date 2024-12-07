<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - College ERP</title>
    <link rel="stylesheet" href="css/dashboardStyles.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="navbar-brand">College ERP</div>
        <div class="navbar-links">
            <a href="#">Profile</a>
            <a href="#">Notifications</a>
            <a href="#">Logout</a>
        </div>
    </nav>
    <div class="main-container">
        <!-- Dashboard Content -->
        <div class="content">
            <h1>Welcome, Admin</h1>
            <div class="dashboard-cards">
                <!-- Courses Card -->
                <div class="card" id="courses">
                    <h2>Courses</h2>
                    <p>CourseProfile</p>
                    <a href="/student/courses" class="btn">Courses</a>
                </div>
                <!-- Attendance Card -->
                <div class="card" id="attendance">
                    <h2>AttendanceProfile</h2>
                    <p>Checkattendance records.</p>
                    <a href="/student/attendance" class="btn">Attendance</a>
                </div>
                <!-- Students Card -->
                <div class="card" id="students">
                    <h2>StudentProfiles</h2>
                    <p>StudentDetails</p>
                    <a href="/student/viewGrades" class="btn">Student</a>
                </div>
                <!-- Faculty Card -->
                <div class="card" id="faculty">
                    <h2>FacultyProfiles</h2>
                    <p>FacultyDetails</p>
                    <a href="/student/faculty" class="btn">Faculty</a>
                </div>
            </div>
        </div>
    </div>
    <script src="script/dashboardScript.js"></script>
</body>
</html>

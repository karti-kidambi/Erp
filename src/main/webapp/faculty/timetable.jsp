<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Faculty - My Timetable</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h1>My Teaching Schedule</h1>
        
        <div class="timetable-view">
            <table>
                <thead>
                    <tr>
                        <th>Time</th>
                        <th>Monday</th>
                        <th>Tuesday</th>
                        <th>Wednesday</th>
                        <th>Thursday</th>
                        <th>Friday</th>
                    </tr>
                </thead>
                <tbody id="timetableData">
                    <!-- Data will be populated dynamically -->
                </tbody>
            </table>
        </div>
        
        <div class="upcoming-classes">
            <h2>Upcoming Classes</h2>
            <div id="upcomingList">
                <!-- Upcoming classes will be populated dynamically -->
            </div>
        </div>
        
        <div class="schedule-conflicts">
            <h2>Schedule Conflicts</h2>
            <div id="conflictsList">
                <!-- Conflicts will be populated dynamically -->
            </div>
        </div>
    </div>
    <script src="../js/faculty/timetable.js"></script>
</body>
</html>
<%@page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.Course"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.sdp.erp.model.Faculty"%>
<%
Faculty f = (Faculty) session.getAttribute("faculty");
List<Course> courses = (List<Course>) request.getAttribute("courses");
List<Student> students = (List<Student>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mark Attendance - Faculty Portal</title>
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
            max-width: 1100px;
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

        /* Card Container */
        .attendance-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .attendance-header {
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .attendance-header h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .attendance-header h1 span {
            color: var(--accent);
        }

        /* Filters Bar */
        .filters-bar {
            display: flex;
            gap: 20px;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            background: rgba(255, 255, 255, 0.02);
            border: 1px solid rgba(255, 255, 255, 0.05);
            padding: 1.2rem;
            border-radius: 12px;
            align-items: center;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
        }

        select, input[type="date"], input[type="text"].remarks-field {
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 10px 14px;
            color: #ffffff;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        select:focus, input:focus {
            outline: none;
            border-color: var(--accent);
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        th {
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            padding: 14px 18px;
            border-bottom: 2px solid var(--glass-border);
        }

        td {
            padding: 14px 18px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 1rem;
        }

        .student-name {
            font-weight: 600;
            color: #ffffff;
        }

        .roll-number {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .radio-cell {
            text-align: center;
        }

        /* Custom radio buttons styles */
        .radio-label {
            cursor: pointer;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: var(--transition);
            display: inline-block;
            color: var(--text-muted);
        }

        input[type="radio"] {
            display: none;
        }

        input[type="radio"][value="present"]:checked + .radio-label {
            background-color: rgba(16, 185, 129, 0.2);
            border-color: var(--success);
            color: var(--success);
        }

        input[type="radio"][value="absent"]:checked + .radio-label {
            background-color: rgba(239, 68, 68, 0.2);
            border-color: var(--danger);
            color: var(--danger);
        }

        input[type="text"].remarks-field {
            width: 100%;
            padding: 6px 12px;
            font-size: 0.9rem;
        }

        /* Action Button */
        .submit-btn {
            background: linear-gradient(135deg, var(--accent) 0%, #f59e0b 100%);
            color: #0b0f19;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 10px 20px -5px rgba(217, 119, 6, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(217, 119, 6, 0.6);
        }

        .submit-btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/faculty/" class="back-btn"><i class="fas fa-arrow-left"></i> Dashboard</a>

        <div class="attendance-card">
            <div class="attendance-header">
                <h1>Mark <span>Daily Attendance</span></h1>
            </div>

            <form action="/faculty/attendance/save" method="POST">
                <div class="filters-bar">
                    <div class="filter-group">
                        <label for="courseSelect">Select Subject</label>
                        <select id="courseSelect" name="courseId" required>
                            <option value="">Select Subject</option>
                            <% 
                                if (courses != null) {
                                    for (Course course : courses) { 
                            %>
                                <option value="<%= course.getCourseId() %>"><%= course.getCourseName() %></option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="filter-group">
                        <label for="dateSelect">Lecture Date</label>
                        <input type="date" id="dateSelect" name="date" value="<%= request.getAttribute("currentDate") %>" required>
                    </div>
                </div>
                
                <table>
                    <thead>
                        <tr>
                            <th>Roll Number</th>
                            <th>Student Name</th>
                            <th style="text-align: center;">Present</th>
                            <th style="text-align: center;">Absent</th>
                            <th>Remarks (Optional)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (students != null && !students.isEmpty()) {
                                for (Student student : students) {
                        %>
                            <tr>
                                <td class="roll-number"><%= student.getRollNumber() != null ? student.getRollNumber() : "DONK2026CS" + student.getStudentId() %></td>
                                <td class="student-name"><%= student.getName() %></td>
                                <td class="radio-cell">
                                    <label>
                                        <input type="radio" name="attendance-<%= student.getStudentId() %>" value="present" checked required>
                                        <span class="radio-label">P</span>
                                    </label>
                                </td>
                                <td class="radio-cell">
                                    <label>
                                        <input type="radio" name="attendance-<%= student.getStudentId() %>" value="absent">
                                        <span class="radio-label">A</span>
                                    </label>
                                </td>
                                <td>
                                    <input type="text" class="remarks-field" name="remarks-<%= student.getStudentId() %>" placeholder="No remarks">
                                </td>
                            </tr>
                        <% 
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="5" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                                    No students loaded.
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                
                <% if (students != null && !students.isEmpty()) { %>
                <button type="submit" class="submit-btn">
                    <i class="fas fa-check-double"></i> Save Daily Registers
                </button>
                <% } %>
            </form>
        </div>
    </div>
</body>
</html>

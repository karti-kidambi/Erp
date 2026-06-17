<%@page import="com.sdp.erp.model.Course"%>
<%@page import="com.sdp.erp.model.Student"%>
<%@page import="com.sdp.erp.model.GradePoints"%>
<%@page import="com.sdp.erp.model.Faculty"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Course course = (Course) request.getAttribute("course");
List<Student> students = (List<Student>) request.getAttribute("students");
Map<Long, GradePoints> studentGrades = (Map<Long, GradePoints>) request.getAttribute("studentGrades");
Faculty f = (Faculty) session.getAttribute("faculty");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Assessment Grading - Faculty Portal</title>
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

        /* Grading Sheet Card */
        .grading-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .grading-header {
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 1.5rem;
            margin-bottom: 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 20px;
        }

        .grading-header h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .grading-header h1 span {
            color: var(--accent);
        }

        .course-meta {
            font-size: 0.95rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .course-meta span {
            margin-left: 15px;
            background: rgba(255, 255, 255, 0.05);
            padding: 4px 12px;
            border-radius: 12px;
        }

        /* Grade Table */
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
            text-align: left;
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

        /* Marks input fields */
        .marks-input {
            width: 80px;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 6px 12px;
            color: #ffffff;
            font-size: 0.95rem;
            font-weight: 600;
            text-align: center;
            transition: var(--transition);
        }

        .marks-input:focus {
            outline: none;
            border-color: var(--accent);
        }

        .grade-letter {
            font-weight: 700;
            color: var(--accent);
            font-size: 1.1rem;
        }

        .total-display {
            font-weight: 600;
        }

        /* Submit Button */
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
        <a href="/faculty/courses?facultyId=<%= f.getFacultyId() %>" class="back-btn"><i class="fas fa-arrow-left"></i> Assigned Subjects</a>

        <div class="grading-card">
            <div class="grading-header">
                <div>
                    <h1>Grade Sheet: <span><%= course != null ? course.getCourseName() : "Course" %></span></h1>
                </div>
                <div class="course-meta">
                    <span>Credits: <%= course != null ? course.getCredits() : "0" %></span>
                    <span>Dept: <%= course != null ? course.getDepartment() : "CSE" %></span>
                </div>
            </div>

            <form action="/faculty/marks/save" method="post">
                <input type="hidden" name="courseId" value="<%= course != null ? course.getCourseId() : "" %>">
                
                <table>
                    <thead>
                        <tr>
                            <th>Roll Number</th>
                            <th>Student Name</th>
                            <th>Internal Marks (out of 30)</th>
                            <th>External Marks (out of 70)</th>
                            <th>Total Marks (100)</th>
                            <th>Letter Grade</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if (students != null && !students.isEmpty()) {
                            for (Student s : students) {
                                GradePoints gp = studentGrades != null ? studentGrades.get(s.getStudentId()) : null;
                                float internal = (gp != null && gp.getInternalMarks() != null) ? gp.getInternalMarks() : 0.0f;
                                float external = (gp != null && gp.getExternalMarks() != null) ? gp.getExternalMarks() : 0.0f;
                                float total = (gp != null && gp.getTotalMarks() != null) ? gp.getTotalMarks() : 0.0f;
                                String gradeLetter = (gp != null && gp.getGradeLetter() != null) ? gp.getGradeLetter() : "F";
                        %>
                        <tr>
                            <td class="roll-number"><%= s.getRollNumber() != null ? s.getRollNumber() : "DONK2026CS" + s.getStudentId() %></td>
                            <td class="student-name"><%= s.getName() %></td>
                            <td>
                                <input type="number" step="0.5" min="0" max="30" 
                                       class="marks-input" name="internal-<%= s.getStudentId() %>" 
                                       value="<%= String.format("%.1f", internal) %>">
                            </td>
                            <td>
                                <input type="number" step="0.5" min="0" max="70" 
                                       class="marks-input" name="external-<%= s.getStudentId() %>" 
                                       value="<%= String.format("%.1f", external) %>">
                            </td>
                            <td class="total-display"><%= String.format("%.1f", total) %></td>
                            <td class="grade-letter"><%= gradeLetter %></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                                No students enrolled in this course.
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <% if (students != null && !students.isEmpty()) { %>
                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i> Publish Sessional Grade Sheet
                </button>
                <% } %>
            </form>
        </div>
    </div>
</body>
</html>

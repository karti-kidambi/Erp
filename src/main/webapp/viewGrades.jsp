<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sdp.erp.model.GradePoints"%>
<%@ page import="com.sdp.erp.model.Student"%>
<%
Student s = (Student) session.getAttribute("student");
List<GradePoints> gradePoints = (List<GradePoints>) request.getAttribute("gradePoints");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Academic Transcript - DonK-University ERP</title>
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

        /* Transcript Card */
        .transcript-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .transcript-header {
            text-align: center;
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 2rem;
            margin-bottom: 2rem;
        }

        .transcript-header h1 {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 4px;
        }

        .transcript-header p {
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

        .marks-column {
            text-align: center;
        }

        .grade-letter-cell {
            text-align: center;
            font-weight: 700;
            color: var(--accent);
            font-size: 1.1rem;
        }

        .points-cell {
            text-align: center;
            font-weight: 600;
        }

        .summary-notes {
            font-size: 0.85rem;
            color: var(--text-muted);
            border-top: 1px dashed var(--glass-border);
            padding-top: 1.5rem;
            display: flex;
            justify-content: space-between;
        }

        .sign-area {
            text-align: right;
            margin-top: 2rem;
        }

        .sign-area p {
            font-size: 0.9rem;
            font-weight: 600;
            color: #ffffff;
        }

        .sign-area span {
            font-size: 0.8rem;
            color: var(--text-muted);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/student/" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

        <div class="transcript-card">
            <div class="transcript-header">
                <h1>DonK-University</h1>
                <p>Official Academic Grade Sheet</p>
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
                    <span class="meta-label">Semester / Year</span>
                    <span class="meta-value">Semester <%= s.getSemester() %> (Year <%= (s.getSemester() + 1)/2 %>)</span>
                </div>
            </div>
            <% } %>

            <table>
                <thead>
                    <tr>
                        <th style="text-align: left;">Subject / Course</th>
                        <th class="marks-column">Internal (30)</th>
                        <th class="marks-column">External (70)</th>
                        <th class="marks-column">Total (100)</th>
                        <th class="grade-letter-cell">Grade Letter</th>
                        <th class="points-cell">Grade Points</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    if (gradePoints != null && !gradePoints.isEmpty()) {
                        for (GradePoints grade : gradePoints) {
                    %>
                        <tr>
                            <td class="subject-name"><%= grade.getSubject() %></td>
                            <td class="marks-column"><%= grade.getInternalMarks() != null ? String.format("%.1f", grade.getInternalMarks()) : "0.0" %></td>
                            <td class="marks-column"><%= grade.getExternalMarks() != null ? String.format("%.1f", grade.getExternalMarks()) : "0.0" %></td>
                            <td class="marks-column"><%= grade.getTotalMarks() != null ? String.format("%.1f", grade.getTotalMarks()) : "0.0" %></td>
                            <td class="grade-letter-cell"><%= grade.getGradeLetter() != null ? grade.getGradeLetter() : "F" %></td>
                            <td class="points-cell"><%= grade.getGrade() != null ? String.format("%.1f", grade.getGrade()) : "0.0" %></td>
                        </tr>
                    <%
                        }
                    } else {
                    %>
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                                No course grades published yet.
                            </td>
                        </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>

            <div class="summary-notes">
                <div>
                    <strong>Grading Scale:</strong> O (10) | A+ (9) | A (8) | B+ (7) | B (6) | C (5) | P (4) | F (0 - Fail)
                </div>
                <div>
                    Date of Issue: 2026-06-17
                </div>
            </div>

            <div class="sign-area">
                <p>Controller of Examinations</p>
                <span>DonK-University Academic Registry</span>
            </div>
        </div>
    </div>
</body>
</html>

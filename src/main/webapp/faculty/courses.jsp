<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sdp.erp.model.Course"%>
<%@ page import="com.sdp.erp.model.Faculty"%>
<%
Faculty f = (Faculty) session.getAttribute("faculty");
List<Course> courses = (List<Course>) request.getAttribute("courses");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses - Faculty Portal</title>
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

        h1 {
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 2.5rem;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 10px;
        }

        h1 span {
            color: var(--accent);
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 25px;
        }

        .course-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: var(--transition);
        }

        .course-card:hover {
            transform: translateY(-5px);
            border-color: rgba(217, 119, 6, 0.3);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.25);
        }

        .course-card h3 {
            font-size: 1.4rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 10px;
            line-height: 1.3;
        }

        .course-meta {
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .course-meta span {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .course-meta i {
            color: var(--accent);
            width: 16px;
        }

        .card-actions {
            display: flex;
            gap: 12px;
            margin-top: auto;
        }

        .action-link {
            flex: 1;
            text-align: center;
            text-decoration: none;
            padding: 10px;
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            transition: var(--transition);
        }

        .action-link.primary {
            background: linear-gradient(135deg, var(--accent) 0%, #f59e0b 100%);
            color: #0b0f19;
        }

        .action-link.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(217, 119, 6, 0.4);
        }

        .action-link.secondary {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff;
        }

        .action-link.secondary:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/faculty/" class="back-btn"><i class="fas fa-arrow-left"></i> Dashboard</a>
        
        <h1>My Assigned <span>Subjects</span></h1>

        <div class="courses-grid">
            <%
                if (courses != null && !courses.isEmpty()) {
                    for (Course course : courses) {
            %>
            <div class="course-card">
                <div>
                    <h3><%= course.getCourseName() %></h3>
                    <div class="course-meta">
                        <span><i class="fas fa-university"></i> Department: <%= course.getDepartment() %></span>
                        <span><i class="fas fa-book-open"></i> Scheme Credits: <%= course.getCredits() %> Credits</span>
                    </div>
                </div>
                <div class="card-actions">
                    <a href="students?courseId=<%=course.getCourseId() %>" class="action-link primary">
                        <i class="fas fa-edit"></i> Enter Marks
                    </a>
                    <a href="attendance?facultyId=<%= f.getFacultyId() %>" class="action-link secondary">
                        <i class="fas fa-user-check"></i> Attendance
                    </a>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div style="grid-column: 1/-1; text-align: center; color: var(--text-muted); padding: 3rem;">
                <p>No courses assigned to your profile yet.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>

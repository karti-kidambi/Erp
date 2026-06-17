<%@page import="com.sdp.erp.model.Student"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Student student = (Student) request.getAttribute("student");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Student - Admin Portal</title>
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
            max-width: 600px;
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

        /* Form Card */
        .form-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 10px;
        }

        h1 span {
            color: var(--accent);
        }

        .form-group {
            margin-bottom: 1.5rem;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        label {
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
        }

        input, select {
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 10px 14px;
            color: #ffffff;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--accent);
        }

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 1rem;
        }

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
            flex: 1;
            text-align: center;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(217, 119, 6, 0.6);
        }

        .cancel-btn {
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition);
            flex: 1;
        }

        .cancel-btn:hover {
            background-color: rgba(255,255,255,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/admin/students" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Registry</a>

        <div class="form-card">
            <h1>Modify Student <span>Details</span></h1>

            <form action="/admin/updatestudent" method="POST">
                <input type="hidden" name="studentId" value="<%= student != null ? student.getStudentId() : "" %>">

                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" value="<%= student != null ? student.getName() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="rollNumber">Roll Number</label>
                    <input type="text" id="rollNumber" name="rollNumber" value="<%= student != null ? student.getRollNumber() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="email">Official Email</label>
                    <input type="email" id="email" name="email" value="<%= student != null ? student.getEmail() : "" %>" required>
                </div>

                <div class="form-group">
                    <label for="semester">Semester</label>
                    <input type="number" id="semester" name="semester" min="1" max="8" value="<%= student != null ? student.getSemester() : 1 %>" required>
                </div>

                <div class="form-group">
                    <label for="department">Department</label>
                    <select id="department" name="department" required>
                        <option value="Computer Science" <%= (student != null && "Computer Science".equals(student.getDepartment())) ? "selected" : "" %>>Computer Science & Engineering</option>
                        <option value="Electronics" <%= (student != null && "Electronics".equals(student.getDepartment())) ? "selected" : "" %>>Electronics & Communication</option>
                        <option value="Mechanical" <%= (student != null && "Mechanical".equals(student.getDepartment())) ? "selected" : "" %>>Mechanical Engineering</option>
                        <option value="Civil" <%= (student != null && "Civil".equals(student.getDepartment())) ? "selected" : "" %>>Civil Engineering</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="section">Section</label>
                    <input type="text" id="section" name="section" value="<%= student != null ? student.getSection() : "A" %>" required>
                </div>

                <div class="form-group" style="display:none;">
                    <label for="gradepoint">CGPA</label>
                    <input type="number" id="gradepoint" name="gradepoint" value="<%= student != null ? student.getGradepoint() : 0 %>">
                </div>

                <div class="btn-group">
                    <a href="/admin/students" class="cancel-btn">Cancel</a>
                    <button type="submit" class="submit-btn">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>

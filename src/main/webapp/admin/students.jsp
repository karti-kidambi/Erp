<%@page import="com.sdp.erp.model.Student"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registry - Admin Portal</title>
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
            max-width: 1200px;
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
        .registry-card {
            background: var(--glass);
            border: 1px solid var(--glass-border);
            backdrop-filter: blur(16px);
            border-radius: 24px;
            padding: 3rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .registry-header {
            border-bottom: 2px solid var(--glass-border);
            padding-bottom: 1.5rem;
            margin-bottom: 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .registry-header h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .registry-header h1 span {
            color: var(--accent);
        }

        /* Buttons */
        .action-btn {
            background: linear-gradient(135deg, var(--accent) 0%, #f59e0b 100%);
            color: #0b0f19;
            border: none;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 10px 20px -5px rgba(217, 119, 6, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(217, 119, 6, 0.6);
        }

        .edit-link {
            color: var(--accent);
            text-decoration: none;
            font-weight: 600;
            margin-right: 15px;
            transition: var(--transition);
        }

        .edit-link:hover {
            color: #ffffff;
        }

        .delete-btn {
            background: none;
            border: none;
            color: var(--danger);
            cursor: pointer;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
        }

        .delete-btn:hover {
            color: #ffffff;
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
            text-align: left;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 1rem;
        }

        .student-name {
            font-weight: 600;
            color: #ffffff;
        }

        .roll-number {
            font-weight: 500;
            color: var(--text-muted);
        }

        /* Modal dialog styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(11, 15, 25, 0.85);
            backdrop-filter: blur(12px);
        }

        .modal-content {
            background: var(--primary-light);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            margin: 10% auto;
            padding: 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }

        .modal-content h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #ffffff;
            border-bottom: 1px solid var(--glass-border);
            padding-bottom: 8px;
        }

        .modal-content form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .modal-content input, .modal-content select {
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            padding: 10px 14px;
            color: #ffffff;
            font-size: 0.95rem;
        }

        .modal-content input:focus, .modal-content select:focus {
            outline: none;
            border-color: var(--accent);
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 10px;
        }

        .cancel-btn {
            background: rgba(255,255,255,0.05);
            border: 1px solid var(--glass-border);
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            transition: var(--transition);
        }

        .cancel-btn:hover {
            background-color: rgba(255,255,255,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/admin/" class="back-btn"><i class="fas fa-arrow-left"></i> Dashboard</a>

        <div class="registry-card">
            <div class="registry-header">
                <h1>Student <span>Registry</span></h1>
                <button class="action-btn" onclick="showAddStudentModal()">
                    <i class="fas fa-user-plus"></i> Add New Student
                </button>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Roll Number</th>
                        <th>Student Name</th>
                        <th>Email</th>
                        <th>Department</th>
                        <th>Semester</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Student> studentsList = (List<Student>) request.getAttribute("studentsList"); 
                        if (studentsList != null && !studentsList.isEmpty()) {
                            for (Student student : studentsList) { 
                    %>
                    <tr>
                        <td class="roll-number"><%= student.getRollNumber() != null ? student.getRollNumber() : "N/A" %></td>
                        <td class="student-name"><%= student.getName() %></td>
                        <td><%= student.getEmail() %></td>
                        <td><%= student.getDepartment() != null ? student.getDepartment() : "N/A" %></td>
                        <td>Semester <%= student.getSemester() %></td>
                        <td>
                            <a href="/admin/student/edit/<%=student.getStudentId() %>" class="edit-link">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <form action="student/delete/<%= student.getStudentId() %>" method="POST" style="display:inline;">
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this student?')">
                                    <i class="fas fa-trash-alt"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% 
                            } 
                        } else { 
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                            No students registered in the database.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Add Student Modal -->
        <div id="studentModal" class="modal">
            <div class="modal-content">
                <h2>Register Student</h2>
                <form id="studentForm" action="addstudent" method="POST">
                    <input type="text" name="name" placeholder="Full Name" required>
                    <input type="text" name="rollNumber" placeholder="Roll Number (e.g. DONK2026CS101)" required>
                    <input type="email" name="email" placeholder="Official Email Address" required>
                    <input type="number" name="semester" placeholder="Current Semester (1-8)" min="1" max="8" required>
                    
                    <select name="department" required>
                        <option value="">-- Select Department --</option>
                        <option value="Computer Science">Computer Science & Engineering</option>
                        <option value="Electronics">Electronics & Communication</option>
                        <option value="Mechanical">Mechanical Engineering</option>
                        <option value="Civil">Civil Engineering</option>
                    </select>

                    <input type="text" name="section" placeholder="Section (e.g. A, B)" required>

                    <div class="modal-actions">
                        <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                        <button type="submit" class="action-btn">Register</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showAddStudentModal() {
            document.getElementById('studentModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('studentModal').style.display = 'none';
        }

        window.onclick = function (event) {
            const modal = document.getElementById('studentModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };

        document.addEventListener('keydown', function (event) {
            const modal = document.getElementById('studentModal');
            if (event.key === 'Escape' && modal.style.display === 'block') {
                modal.style.display = 'none';
            }
        });
    </script>
</body>
</html>

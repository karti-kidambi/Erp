<%@page import="com.sdp.erp.model.Faculty"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Faculty Registry - Admin Portal</title>
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

        .faculty-name {
            font-weight: 600;
            color: #ffffff;
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
                <h1>Faculty <span>Registry</span></h1>
                <button class="action-btn" onclick="showAddFacultyModal()">
                    <i class="fas fa-user-plus"></i> Add New Faculty
                </button>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Faculty ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Department</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Faculty> facultyList = (List<Faculty>) request.getAttribute("facultylist"); 
                        if (facultyList != null && !facultyList.isEmpty()) {
                            for (Faculty faculty : facultyList) { 
                    %>
                    <tr>
                        <td><%= faculty.getFacultyId() %></td>
                        <td class="faculty-name"><%= faculty.getUsername() %></td>
                        <td><%= faculty.getEmail() %></td>
                        <td><%= faculty.getDepartment() != null ? faculty.getDepartment() : "N/A" %></td>
                        <td>
                            <a href="/admin/edit/<%=faculty.getFacultyId()%>" class="edit-link">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <form action="faculty/delete/<%= faculty.getFacultyId() %>" method="POST" style="display:inline;">
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this faculty?')">
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
                        <td colspan="5" style="text-align: center; color: var(--text-muted); font-style: italic; padding: 2rem;">
                            No faculty members registered in the database.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Add Faculty Modal -->
        <div id="facultyModal" class="modal">
            <div class="modal-content">
                <h2>Add Faculty Profile</h2>
                <form id="facultyForm" action="faculties" method="POST">
                    <input type="text" name="username" placeholder="Full Name (e.g. Dr. Rajesh Kumar)" required>
                    <input type="email" name="email" placeholder="Official Email Address" required>
                    
                    <select name="department" required>
                        <option value="">-- Select Department --</option>
                        <option value="Computer Science">Computer Science & Engineering</option>
                        <option value="Electronics">Electronics & Communication</option>
                        <option value="Mechanical">Mechanical Engineering</option>
                        <option value="Civil">Civil Engineering</option>
                    </select>

                    <div class="modal-actions">
                        <button type="button" class="cancel-btn" onclick="closeModal()">Cancel</button>
                        <button type="submit" class="action-btn">Register</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showAddFacultyModal() {
            document.getElementById('facultyModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('facultyModal').style.display = 'none';
        }

        window.onclick = function (event) {
            const modal = document.getElementById('facultyModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };

        document.addEventListener('keydown', function (event) {
            const modal = document.getElementById('facultyModal');
            if (event.key === 'Escape' && modal.style.display === 'block') {
                modal.style.display = 'none';
            }
        });
    </script>
</body>
</html>

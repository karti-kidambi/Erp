<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DonK-University ERP - Sign In</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: radial-gradient(circle at top right, rgba(217, 119, 6, 0.1) 0%, transparent 60%),
                        radial-gradient(circle at bottom left, rgba(30, 58, 138, 0.15) 0%, transparent 60%),
                        #0b0f19;
            color: #f8fafc;
            padding: 20px;
        }

        .login-container {
            width: 100%;
            max-width: 480px;
        }

        .login-box {
            background: rgba(15, 23, 42, 0.65);
            backdrop-filter: blur(16px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 0.5rem;
        }

        h1 span {
            color: #d97706;
        }

        .subtitle {
            color: #94a3b8;
            font-size: 0.95rem;
            font-weight: 300;
            margin-bottom: 2.5rem;
        }

        .login-form {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        label {
            font-size: 0.9rem;
            font-weight: 500;
            color: #94a3b8;
            margin-bottom: 0.5rem;
        }

        input {
            width: 100%;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 0.9rem 1.2rem;
            color: #ffffff;
            font-size: 1rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #d97706;
            box-shadow: 0 0 0 3px rgba(217, 119, 6, 0.25);
        }

        .login-button {
            background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
            color: #0b0f19;
            border: none;
            padding: 1rem;
            border-radius: 12px;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 0.5rem;
        }

        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(217, 119, 6, 0.4);
        }

        .login-button:active {
            transform: translateY(0);
        }

        /* Demo Accounts Widget */
        .demo-widget {
            margin-top: 2.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
            padding-top: 1.5rem;
            text-align: left;
        }

        .demo-title {
            font-size: 0.85rem;
            font-weight: 600;
            color: #d97706;
            margin-bottom: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            text-align: center;
        }

        .demo-accounts {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .demo-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 8px;
            padding: 10px 14px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .demo-card:hover {
            background: rgba(217, 119, 6, 0.08);
            border-color: rgba(217, 119, 6, 0.3);
        }

        .demo-role {
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 2px;
        }

        .demo-user {
            color: #94a3b8;
        }

        .footer-text {
            margin-top: 2.5rem;
            color: #475569;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h1>DonK <span>ERP</span></h1>
            <p class="subtitle">Academic Information System Sign-In</p>

            <form action="/CheckLogin" method="post" class="login-form">
                <label for="username">Email or Username</label>
                <input type="text" id="username" name="username" placeholder="Enter username or official email" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your secure password" required>

                <button type="submit" class="login-button">Sign In</button>
            </form>

            <div class="demo-widget">
                <div class="demo-title">Quick Demo Login</div>
                <div class="demo-accounts">
                    <div class="demo-card" onclick="fillCreds('admin', 'admin')">
                        <div class="demo-role">System Administrator</div>
                        <div class="demo-user">User: admin | Pass: admin</div>
                    </div>
                    <div class="demo-card" onclick="fillCreds('srinivas@donk.edu.in', 'faculty')">
                        <div class="demo-role">Faculty Portal (DR.Srinivas)</div>
                        <div class="demo-user">User: srinivas@donk.edu.in | Pass: faculty</div>
                    </div>
                    <div class="demo-card" onclick="fillCreds('kartik@student.donk.edu.in', 'student')">
                        <div class="demo-role">Student Portal (K. Kartik)</div>
                        <div class="demo-user">User: kartik@student.donk.edu.in | Pass: student</div>
                    </div>
                </div>
            </div>

            <p class="footer-text">&copy; 2026 DonK-University. All rights reserved.</p>
        </div>
    </div>

    <script>
        function fillCreds(username, password) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;
        }
    </script>
</body>
</html>
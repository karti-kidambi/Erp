<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College ERP - Login</title>
    <!-- Google Fonts Import -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        /* Reset and Base Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif; /* Changed from Arial to Poppins */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            line-height: 1.6;
            background: linear-gradient(135deg, #4f5985 0%, #764ba2 100%);
            text-rendering: optimizeLegibility;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .login-container {
            width: 100%;
            max-width: 600px;
            padding: 30px;
        }

        .login-box {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
            padding: 60px 45px;
            text-align: center;
        }

        h1 {
            color: #333;
            margin-bottom: 15px;
            font-size: 28px;
            font-weight: 700;
            font-family: 'Poppins', sans-serif; /* Explicitly set font */
            letter-spacing: -0.5px; /* Slight letter spacing for clean look */
        }

        .subtitle {
            color: #777;
            margin-bottom: 35px;
            font-size: 18px;
            font-weight: 300;
        }

        .login-form {
            display: flex;
            flex-direction: column;
        }

        label {
            text-align: left;
            margin-bottom: 8px;
            color: #555;
            font-size: 16px;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 18px;
            font-family: 'Roboto', sans-serif; /* Different font for inputs */
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.3);
        }

        .login-button {
            background-color: #667eea;
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            font-weight: 600;
            font-family: 'Poppins', sans-serif;
            transition: all 0.3s ease;
            margin-top: 10px;
            text-transform: uppercase; /* Optional: make button text uppercase */
            letter-spacing: 1px; /* Slight letter spacing */
        }

        .login-button:hover {
            background-color: #5a5dea;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .login-button:active {
            transform: scale(0.98);
        }

        .footer-text {
            margin-top: 35px;
            color: #888;
            font-size: 14px;
            font-weight: 300;
        }

        /* Responsive Design */
        @media screen and (max-width: 480px) {
            .login-container {
                max-width: 95%;
                padding: 20px;
            }

            .login-box {
                padding: 40px 25px;
            }

            h1 {
                font-size: 24px;
            }

            input, .login-button {
                padding: 12px 18px;
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h1>College ERP System</h1>
            <p class="subtitle">Login to your account</p>

            <form action="/CheckLogin" method="post" class="login-form">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <button type="submit" class="login-button">Login</button>
            </form>

            <p class="footer-text">� 2024 College ERP. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
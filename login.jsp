<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ERP Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('campus-bg.jpg') no-repeat center center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: rgba(255, 255, 255, 0.15);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        h2 {
            color: #fff;
            margin-bottom: 25px;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        input,
        select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid rgba(255, 255, 255, 0.5);
            background: rgba(255, 255, 255, 0.85);
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s, background 0.3s;
            outline: none;
        }

        input:focus,
        select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            background: #fff;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 10px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
        }

        .register-link {
            margin-top: 25px;
            display: block;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.3s;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        .register-link:hover {
            color: #e0e0e0;
            text-decoration: underline;
        }

        .role-fields {
            animation: fadeIn 0.4s;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
    <script>
        function showFields() {
            let role = document.getElementById("role").value;
            let idLabel = document.getElementById("id_label");
            let idInput = document.getElementById("id");

            if (role === "STUDENT") {
                idLabel.innerText = "Admission Number";
                idInput.placeholder = "Enter Admission No";
            } else if (role === "TEACHER") {
                idLabel.innerText = "Teacher ID";
                idInput.placeholder = "Enter Teacher ID";
            } else {
                idLabel.innerText = "Admin Username";
                idInput.placeholder = "Enter Admin Username";
            }
        }
    </script>
</head>

<body onload="showFields()">

    <div class="container">
        <h2>College ERP Login</h2>
        <form action="login" method="post">

            <div class="form-group">
                <label for="role">Select Role</label>
                <select name="role" id="role" onchange="showFields()">
                    <option value="STUDENT">Student</option>
                    <option value="TEACHER">Teacher</option>
                    <option value="ADMIN">Admin</option>
                </select>
            </div>

            <div class="form-group role-fields">
                <label for="id" id="id_label">Admission Number</label>
                <input type="text" id="id" name="id" placeholder="Enter Admission No" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter Password" required>
            </div>

            <button type="submit" class="btn-primary">Login to Account</button>

            <a href="register.jsp" class="register-link">Don't have an account? Register here</a>
        </form>
    </div>

</body>

</html>
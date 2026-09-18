<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College ERP Registration</title>
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
            max-width: 450px;
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

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
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
            border-color: #11998e;
            box-shadow: 0 0 0 3px rgba(17, 153, 142, 0.2);
            background: #fff;
        }

        .btn-primary {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
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
            box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4);
        }

        .login-link {
            margin-top: 25px;
            display: block;
            color: #fff;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: color 0.3s;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
        }

        .login-link:hover {
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
        function toggleRole() {
            var role = document.getElementById("role").value;

            var studentFields = document.getElementById("studentFields");
            var teacherFields = document.getElementById("teacherFields");

            if (role === "STUDENT") {
                studentFields.style.display = "block";
                teacherFields.style.display = "none";
                if (document.getElementById("admission_no")) document.getElementById("admission_no").required = true;
                if (document.getElementById("teacher_id")) document.getElementById("teacher_id").required = false;
            } else {
                studentFields.style.display = "none";
                teacherFields.style.display = "block";
                if (document.getElementById("admission_no")) document.getElementById("admission_no").required = false;
                if (document.getElementById("teacher_id")) document.getElementById("teacher_id").required = true;
            }
        }
    </script>
</head>

<body onload="toggleRole()">

    <div class="container">
        <h2>Create an Account</h2>
        <form action="register" method="post">

            <div class="form-group">
                <label for="role">I am a...</label>
                <select name="role" id="role" onchange="toggleRole()">
                    <option value="STUDENT">Student</option>
                    <option value="TEACHER">Teacher</option>
                </select>
            </div>

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            </div>

            <div id="studentFields" class="role-fields">
                <div class="form-row">
                    <div class="form-group">
                        <label for="admission_no">Admission No</label>
                        <input type="text" id="admission_no" name="admission_no" placeholder="e.g. S12345">
                    </div>
                    <div class="form-group">
                        <label for="section">Section</label>
                        <input type="text" id="section" name="section" value="16">
                    </div>
                </div>
            </div>

            <div id="teacherFields" class="role-fields" style="display:none;">
                <div class="form-group">
                    <label for="teacher_id">Teacher ID</label>
                    <input type="text" id="teacher_id" name="teacher_id" placeholder="e.g. T98765">
                </div>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter email address" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required>
            </div>

            <button type="submit" class="btn-primary">Register Now</button>

            <a href="login.jsp" class="login-link">Already have an account? Login here</a>

        </form>
    </div>

</body>

</html>
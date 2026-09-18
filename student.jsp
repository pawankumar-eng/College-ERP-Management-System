<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String name = (String) session.getAttribute("studentName");
String admission_no = (String) session.getAttribute("admissionNo");

if(name == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }
        body {
            background-color: #f0f4f8; /* Professional light blue-gray */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: #ffffff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            width: 100%;
            max-width: 600px;
            text-align: center;
        }
        h1 {
            color: #1e293b;
            margin-bottom: 5px;
            font-weight: 700;
        }
        h3 {
            color: #3b82f6;
            margin-bottom: 25px;
            font-weight: 500;
            font-size: 16px;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        .menu-item {
            display: block;
            background: #ffffff;
            padding: 15px;
            border-radius: 12px;
            text-decoration: none;
            color: #475569;
            font-weight: 600;
            border: 1px solid #e2e8f0;
            transition: all 0.3s;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.02);
        }
        .menu-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(59, 130, 246, 0.15);
            border-color: #3b82f6;
            color: #2563eb;
        }
        .logout-btn {
            display: inline-block;
            background: #ff4757;
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: background 0.3s, transform 0.2s;
        }
        .logout-btn:hover {
            background: #ff6b81;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= name %></h1>
    <h3>Admission No: <%= admission_no %></h3>

    <div class="menu-grid">
        <a href="viewAttendance.jsp" class="menu-item">View Attendance</a>
        <a href="viewResults.jsp" class="menu-item">View Results</a>
        <a href="viewFees.jsp" class="menu-item">View Fees</a>
        <a href="payFee.jsp" class="menu-item">Pay Fee</a>
        <a href="viewTimetable.jsp" class="menu-item">View Timetable</a>
        <a href="viewNotifications.jsp" class="menu-item">View Notifications</a>
    </div>

    <a href="logout.jsp" class="logout-btn">Logout</a>
</div>

</body>
</html>
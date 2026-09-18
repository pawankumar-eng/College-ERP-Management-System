<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String name = (String) session.getAttribute("adminName");
if(name == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 600px; text-align: center; backdrop-filter: blur(10px); }
        h1 { color: #333; margin-bottom: 5px; font-weight: 600; }
        h3 { color: #2a5298; margin-bottom: 25px; font-weight: 400; font-size: 16px; }
        .menu-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 30px; margin-bottom: 30px; }
        .menu-item { display: block; background: white; padding: 15px; border-radius: 12px; text-decoration: none; color: #333; font-weight: 600; border: 1px solid #eee; transition: all 0.3s; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .menu-item:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(42, 82, 152, 0.2); border-color: #2a5298; color: #2a5298; }
        .logout-btn { display: inline-block; background: #ff4757; color: white; text-decoration: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; transition: background 0.3s, transform 0.2s; }
        .logout-btn:hover { background: #ff6b81; transform: translateY(-2px); }
    </style>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= name %></h1>
    <h3>Role: System Administrator</h3>

    <div class="menu-grid">
        <a href="timetable.jsp" class="menu-item">Manage Timetable</a>
        <a href="generateReport.jsp" class="menu-item">Generate Report</a>
        <a href="sendNotification.jsp" class="menu-item">Send Notification</a>
        <a href="markAttendance.jsp" class="menu-item">Manage Attendance</a>
    </div>

    <a href="logout.jsp" class="logout-btn">Logout</a>
</div>

</body>
</html>
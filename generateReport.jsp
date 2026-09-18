<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String name = (String) session.getAttribute("adminName");
if(name == null){
    response.sendRedirect("login.jsp");
    return;
}

int totalStudents = 0;
int totalTeachers = 0;
double totalFees = 0;

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","1648");

ResultSet rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM students");
if(rs.next()) totalStudents = rs.getInt(1);

rs = con.createStatement().executeQuery("SELECT COUNT(DISTINCT teacher) FROM timetable WHERE teacher != '-' AND teacher != ''");
if(rs.next()) totalTeachers = rs.getInt(1);

rs = con.createStatement().executeQuery("SELECT SUM(amount) FROM fees WHERE payment_status='Paid'");
if(rs.next()) totalFees = rs.getDouble(1);

con.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Report</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 700px; text-align: center; backdrop-filter: blur(10px); }
        h1 { color: #333; margin-bottom: 30px; font-weight: 700; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 35px; }
        .stat-card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: 1px solid #eee; }
        .stat-value { font-size: 32px; font-weight: 700; color: #2a5298; margin-bottom: 5px; }
        .stat-label { color: #666; font-size: 14px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; }
        .btn-back { display: inline-block; background: #2a5298; color: white; text-decoration: none; padding: 12px 30px; border-radius: 8px; font-weight: 600; transition: background 0.3s, transform 0.2s; }
        .btn-back:hover { background: #1e3c72; transform: translateY(-2px); }
    </style>
</head>
<body>

<div class="container">
    <h1>System Statistics Report</h1>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value"><%= totalStudents %></div>
            <div class="stat-label">Total Students</div>
        </div>
        <div class="stat-card">
            <div class="stat-value"><%= totalTeachers %></div>
            <div class="stat-label">Total Teachers</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">Rs. <%= String.format("%.2f", totalFees) %></div>
            <div class="stat-label">Total Fees Collected</div>
        </div>
    </div>

    <a href="admin.jsp" class="btn-back">← Back to Dashboard</a>
</div>

</body>
</html>

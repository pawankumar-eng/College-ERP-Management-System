<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String admissionNo = (String) session.getAttribute("admissionNo");
if(admissionNo == null) { response.sendRedirect("login.jsp"); return; }

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","1648");
ResultSet rs = con.prepareStatement("SELECT * FROM timetable ORDER BY FIELD(day_name,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), STR_TO_DATE(SUBSTRING(time_slot, 1, 8), '%h:%i %p')").executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Timetable</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255,255,255,0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 850px; margin: 0 auto; }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; text-align: center; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #667eea; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
        table { width: 100%; border-collapse: collapse; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #333; font-weight: 600; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: #f3f4ff; }
        .day-badge { background: #667eea; color: white; padding: 3px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <a href="student.jsp" class="nav-link">← Back to Dashboard</a>
    <h2>Class Timetable</h2>
    <table>
        <tr><th>Day</th><th>Time Slot</th><th>Subject</th><th>Teacher</th></tr>
        <% while(rs.next()) { %>
        <tr>
            <td><span class="day-badge"><%= rs.getString("day_name") %></span></td>
            <td><%= rs.getString("time_slot") %></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("teacher") %></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
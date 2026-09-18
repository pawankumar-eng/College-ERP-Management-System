<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String adminName = (String) session.getAttribute("adminName");
if(adminName == null) { response.sendRedirect("login.jsp"); return; }

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","1648");
ResultSet rs = con.prepareStatement("SELECT * FROM timetable ORDER BY FIELD(day_name,'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'), STR_TO_DATE(SUBSTRING(time_slot, 1, 8), '%h:%i %p')").executeQuery();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Timetable</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255,255,255,0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 950px; margin: 0 auto; }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; text-align: center; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #11998e; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
        .add-form { background: #f8fffe; border: 1px solid #d0f0e8; border-radius: 12px; padding: 25px; margin-bottom: 30px; }
        .add-form h3 { color: #11998e; margin-bottom: 18px; font-size: 16px; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 15px; }
        .form-group { text-align: left; }
        label { display: block; margin-bottom: 6px; color: #555; font-size: 13px; font-weight: 600; }
        input[type="text"], select { width: 100%; padding: 10px 14px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; outline: none; }
        input:focus, select:focus { border-color: #11998e; }
        .btn-add { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; padding: 12px 28px; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; margin-top: 18px; width: 100%; }
        .btn-add:hover { opacity: 0.9; }
        table { width: 100%; border-collapse: collapse; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { padding: 14px; text-align: left; border-bottom: 1px solid #eee; font-size: 14px; }
        th { background: #f8f9fa; color: #333; font-weight: 600; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: #f1f8f6; }
        .day-badge { background: #11998e; color: white; padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <a href="teacher.jsp" class="nav-link">← Back to Dashboard</a>
    <h2>Manage Class Timetable</h2>

    <div class="add-form">
        <h3>Add New Timetable Entry</h3>
        <form action="TimetableServlet" method="post">
            <div class="form-grid">
                <div class="form-group">
                    <label>Day</label>
                    <select name="day_name" required>
                        <option value="" disabled selected>Select Day</option>
                        <option>Monday</option><option>Tuesday</option><option>Wednesday</option>
                        <option>Thursday</option><option>Friday</option><option>Saturday</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Time Slot</label>
                    <input type="text" name="time_slot" placeholder="e.g. 9:00 AM - 10:00 AM" required>
                </div>
                <div class="form-group">
                    <label>Subject</label>
                    <select name="subject" required>
                        <option value="" disabled selected>Select Subject</option>
                        <option>DBMS</option><option>Java</option><option>OS</option>
                        <option>CN</option><option>Python</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Teacher Name</label>
                    <input type="text" name="teacher" placeholder="e.g. Dr. Smith" required>
                </div>
            </div>
            <button type="submit" class="btn-add">Add to Timetable</button>
        </form>
    </div>

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
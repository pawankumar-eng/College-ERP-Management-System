<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String teacherName = (String) session.getAttribute("teacherName");
if(teacherName == null) {
    response.sendRedirect("login.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");
PreparedStatement ps = con.prepareStatement("SELECT * FROM students");
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Marks</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 500px; text-align: center; backdrop-filter: blur(10px); }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; }
        .form-group { margin-bottom: 20px; text-align: left; }
        label { display: block; margin-bottom: 8px; color: #555; font-size: 14px; font-weight: 600; }
        input[type="number"], select { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; outline: none; transition: border-color 0.3s; }
        input:focus, select:focus { border-color: #11998e; box-shadow: 0 0 0 3px rgba(17, 153, 142, 0.2); }
        .btn-primary { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: transform 0.2s, box-shadow 0.2s; width: 100%; margin-top: 10px; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4); }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #11998e; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <a href="teacher.jsp" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Add Student Marks</h2>

    <form action="MarksServlet" method="post">
        <div class="form-group">
            <label>Select Subject</label>
            <select name="subject" required>
                <option value="" disabled selected>Select a subject</option>
                <option>DBMS</option>
                <option>Java</option>
                <option>OS</option>
                <option>CN</option>
                <option>Python</option>
            </select>
        </div>

        <div class="form-group">
            <label>Select Student</label>
            <select name="admission_no" required>
                <option value="" disabled selected>Select a student</option>
                <% while(rs.next()) { %>
                <option value="<%= rs.getString("admission_no") %>">
                    <%= rs.getString("student_name") %> (<%= rs.getString("admission_no") %>)
                </option>
                <% } %>
            </select>
        </div>

        <div class="form-group">
            <label>Marks Scored</label>
            <input type="number" name="marks" placeholder="Enter marks out of 100" required min="0" max="100">
        </div>

        <button type="submit" class="btn-primary">Save Marks</button>
    </form>
</div>

</body>
</html>
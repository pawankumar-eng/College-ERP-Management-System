<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String admissionNo = (String) session.getAttribute("admissionNo");
if(admissionNo == null) {
    response.sendRedirect("login.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");
PreparedStatement ps = con.prepareStatement("SELECT * FROM marks WHERE admission_no=?");
ps.setString(1, admissionNo);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Results</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 800px; margin: 0 auto; backdrop-filter: blur(10px); }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background-color: #f8f9fa; color: #333; font-weight: 600; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #f1f8f6; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #667eea; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
        .grade-a { color: #28a745; font-weight: bold; }
        .grade-b { color: #17a2b8; font-weight: bold; }
        .grade-c { color: #ffc107; font-weight: bold; }
        .grade-f { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>

<div class="container">
    <a href="student.jsp" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Your Academic Results</h2>

    <table>
        <tr>
            <th>Subject</th>
            <th>Marks</th>
            <th>Grade</th>
        </tr>
        <% while(rs.next()) { 
            String grade = rs.getString("grade");
            String gradeClass = "grade-b"; // Default
            if (grade != null) {
                if (grade.startsWith("A")) gradeClass = "grade-a";
                else if (grade.startsWith("C") || grade.startsWith("D")) gradeClass = "grade-c";
                else if (grade.startsWith("F") || grade.startsWith("E")) gradeClass = "grade-f";
            }
        %>
        <tr>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getInt("marks") %></td>
            <td class="<%= gradeClass %>"><%= grade %></td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
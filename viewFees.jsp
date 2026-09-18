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
PreparedStatement ps = con.prepareStatement("SELECT * FROM fees WHERE admission_no=?");
ps.setString(1, admissionNo);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Fee Status</title>
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
        .status-paid { color: #28a745; font-weight: bold; background: #e6f4ea; padding: 4px 10px; border-radius: 20px; font-size: 13px; }
        .status-pending { color: #ffc107; font-weight: bold; background: #fff8e1; padding: 4px 10px; border-radius: 20px; font-size: 13px; }
    </style>
</head>
<body>

<div class="container">
    <a href="student.jsp" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Your Fee Status</h2>

    <table>
        <tr>
            <th>Amount</th>
            <th>Payment Mode</th>
            <th>Status</th>
        </tr>
        <% while(rs.next()) { 
            String status = rs.getString("payment_status");
            String statusClass = (status != null && status.equalsIgnoreCase("Paid")) ? "status-paid" : "status-pending";
        %>
        <tr>
            <td>Rs. <%= String.format("%.2f", rs.getDouble("amount")) %></td>
            <td><%= rs.getString("payment_mode") %></td>
            <td><span class="<%= statusClass %>"><%= status %></span></td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
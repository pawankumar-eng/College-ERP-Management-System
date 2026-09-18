<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
// Support both Students and Teachers
String admissionNo = (String) session.getAttribute("admissionNo");
String teacherId   = (String) session.getAttribute("teacherId");

if(admissionNo == null && teacherId == null) {
    response.sendRedirect("login.jsp");
    return;
}

String userType     = (admissionNo != null) ? "STUDENT" : "TEACHER";
String userId       = (admissionNo != null) ? admissionNo : teacherId;
String dashboardLink= (admissionNo != null) ? "student.jsp" : "teacher.jsp";

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

// Show: General (ALL) notifications + ones specifically for this user
PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM notifications WHERE target_type='ALL' OR (target_type=? AND target_id=?) ORDER BY created_at DESC"
);
ps.setString(1, userType);
ps.setString(2, userId);
ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Notifications</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 800px; margin: 0 auto; backdrop-filter: blur(10px); }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; text-align: center; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #667eea; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
        .notification-card { background: white; border-radius: 12px; padding: 20px; margin-bottom: 15px; text-align: left; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-left: 5px solid #667eea; }
        .notification-card.personal { border-left-color: #11998e; }
        .notification-date { font-size: 12px; color: #888; margin-bottom: 8px; }
        .notification-msg { color: #333; font-size: 15px; line-height: 1.5; }
        .badge-type { display: inline-block; font-size: 11px; font-weight: 700; padding: 2px 10px; border-radius: 20px; margin-bottom: 8px; }
        .badge-all { background: #e8eaff; color: #667eea; }
        .badge-personal { background: #e8f5e9; color: #11998e; }
        .empty-state { text-align: center; color: #999; padding: 40px 0; font-size: 15px; }
    </style>
</head>
<body>

<div class="container">
    <a href="<%= dashboardLink %>" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Announcements &amp; Notifications</h2>

    <%
    boolean hasNotes = false;
    while(rs.next()) {
        hasNotes = true;
        String type = rs.getString("target_type");
        boolean isPersonal = !"ALL".equals(type);
        String badgeClass = isPersonal ? "badge-personal" : "badge-all";
        String badgeLabel = isPersonal ? "Personal" : "General";
        String cardClass  = isPersonal ? "notification-card personal" : "notification-card";
    %>
    <div class="<%= cardClass %>">
        <span class="badge-type <%= badgeClass %>"><%= badgeLabel %></span>
        <div class="notification-date"><%= rs.getTimestamp("created_at") %></div>
        <div class="notification-msg"><%= rs.getString("message") %></div>
    </div>
    <% } %>

    <% if(!hasNotes) { %>
        <div class="empty-state">No new notifications yet.</div>
    <% } %>
</div>

<% con.close(); %>
</body>
</html>
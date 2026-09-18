<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String adminName = (String) session.getAttribute("adminName");
if(adminName == null) {
    response.sendRedirect("login.jsp");
    return;
}

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","1648");
ResultSet rsStudents = con.createStatement().executeQuery("SELECT admission_no, student_name FROM students ORDER BY student_name");
ResultSet rsTeachers = con.createStatement().executeQuery("SELECT teacher_id, teacher_name FROM teachers ORDER BY teacher_name");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Notification</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); min-height: 100vh; padding: 30px 20px; }
        .container { background: rgba(255,255,255,0.97); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); width: 100%; max-width: 700px; margin: 0 auto; }
        h2 { color: #1e3c72; margin-bottom: 6px; font-weight: 700; text-align: center; }
        .subtitle { text-align: center; color: #888; font-size: 14px; margin-bottom: 30px; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #2a5298; text-decoration: none; font-weight: 600; font-size: 14px; }
        .nav-link:hover { text-decoration: underline; }
        .form-group { margin-bottom: 22px; }
        label.field-label { display: block; margin-bottom: 10px; color: #333; font-size: 14px; font-weight: 700; }

        /* Recipient Tabs */
        .tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab-btn { flex: 1; padding: 11px; border: 2px solid #ddd; border-radius: 8px; background: white; font-size: 14px; font-weight: 600; color: #666; cursor: pointer; transition: all 0.2s; }
        .tab-btn.active { border-color: #2a5298; background: #eef2ff; color: #2a5298; }

        /* Checkbox Panel */
        .checkbox-panel { display: none; border: 1px solid #ddd; border-radius: 10px; overflow: hidden; }
        .checkbox-panel.visible { display: block; }
        .panel-header { background: #f8f9fa; padding: 10px 16px; display: flex; align-items: center; gap: 10px; border-bottom: 1px solid #eee; }
        .panel-header label { font-weight: 700; color: #333; font-size: 14px; cursor: pointer; }
        .panel-body { max-height: 220px; overflow-y: auto; padding: 10px 16px; }
        .cb-item { display: flex; align-items: center; gap: 10px; padding: 9px 0; border-bottom: 1px solid #f5f5f5; }
        .cb-item:last-child { border-bottom: none; }
        .cb-item label { font-size: 14px; color: #333; cursor: pointer; flex: 1; }
        .cb-item .id-badge { font-size: 11px; color: #888; background: #f0f0f0; padding: 2px 8px; border-radius: 20px; }
        input[type="checkbox"] { width: 17px; height: 17px; accent-color: #2a5298; cursor: pointer; }

        /* Message */
        textarea { width: 100%; padding: 14px; border: 1.5px solid #ddd; border-radius: 10px; font-size: 14px; outline: none; transition: border-color 0.3s; min-height: 130px; resize: vertical; color: #333; }
        textarea:focus { border-color: #2a5298; box-shadow: 0 0 0 3px rgba(42,82,152,0.1); }

        .btn-primary { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; border: none; padding: 14px 30px; border-radius: 10px; font-size: 16px; font-weight: 700; cursor: pointer; width: 100%; margin-top: 10px; transition: transform 0.2s, box-shadow 0.2s; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(42,82,152,0.35); }
        .no-data { color: #999; font-size: 13px; padding: 15px 0; text-align: center; }
    </style>
</head>
<body>
<div class="container">
    <a href="admin.jsp" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Send Notification</h2>
    <p class="subtitle">Send announcements to students, teachers, or everyone</p>

    <form action="NotificationServlet" method="post">

        <!-- Recipient Type Tabs -->
        <div class="form-group">
            <label class="field-label">Select Recipients</label>
            <div class="tabs">
                <button type="button" class="tab-btn active" onclick="showTab('general', this)">General (All)</button>
                <button type="button" class="tab-btn" onclick="showTab('students', this)">Students</button>
                <button type="button" class="tab-btn" onclick="showTab('teachers', this)">Teachers</button>
            </div>
            <input type="hidden" name="recipient_mode" id="recipient_mode" value="ALL">

            <!-- Students Checkbox Panel -->
            <div class="checkbox-panel" id="panel_students">
                <div class="panel-header">
                    <input type="checkbox" id="selectAllStudents" onchange="toggleAll('student_ids', this)">
                    <label for="selectAllStudents">Select All Students</label>
                </div>
                <div class="panel-body">
                    <%
                    boolean hasStudents = false;
                    while(rsStudents.next()) {
                        hasStudents = true;
                        String admNo = rsStudents.getString("admission_no");
                        String sName = rsStudents.getString("student_name");
                    %>
                    <div class="cb-item">
                        <input type="checkbox" name="student_ids" value="<%= admNo %>" class="student_ids">
                        <label><%= sName %></label>
                        <span class="id-badge"><%= admNo %></span>
                    </div>
                    <% } %>
                    <% if(!hasStudents) { %><p class="no-data">No students found.</p><% } %>
                </div>
            </div>

            <!-- Teachers Checkbox Panel -->
            <div class="checkbox-panel" id="panel_teachers">
                <div class="panel-header">
                    <input type="checkbox" id="selectAllTeachers" onchange="toggleAll('teacher_ids', this)">
                    <label for="selectAllTeachers">Select All Teachers</label>
                </div>
                <div class="panel-body">
                    <%
                    boolean hasTeachers = false;
                    while(rsTeachers.next()) {
                        hasTeachers = true;
                        String tId = rsTeachers.getString("teacher_id");
                        String tName = rsTeachers.getString("teacher_name");
                    %>
                    <div class="cb-item">
                        <input type="checkbox" name="teacher_ids" value="<%= tId %>" class="teacher_ids">
                        <label><%= tName %></label>
                        <span class="id-badge">ID: <%= tId %></span>
                    </div>
                    <% } %>
                    <% if(!hasTeachers) { %><p class="no-data">No teachers found.</p><% } %>
                </div>
            </div>
        </div>

        <!-- Message -->
        <div class="form-group">
            <label class="field-label">Announcement Message</label>
            <textarea name="message" placeholder="Type your notification message here..." required></textarea>
        </div>

        <button type="submit" class="btn-primary">Send Notification</button>
    </form>
</div>

<script>
function showTab(tab, btn) {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById('panel_students').classList.remove('visible');
    document.getElementById('panel_teachers').classList.remove('visible');
    // Map 'general' -> 'ALL', 'students' -> 'STUDENTS', 'teachers' -> 'TEACHERS'
    var modeMap = { 'general': 'ALL', 'students': 'STUDENTS', 'teachers': 'TEACHERS' };
    document.getElementById('recipient_mode').value = modeMap[tab];
    if(tab === 'students') document.getElementById('panel_students').classList.add('visible');
    if(tab === 'teachers') document.getElementById('panel_teachers').classList.add('visible');
}

function toggleAll(name, masterCb) {
    document.querySelectorAll('.' + name).forEach(cb => cb.checked = masterCb.checked);
}
</script>

<% con.close(); %>
</body>
</html>
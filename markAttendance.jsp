<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String teacherName = (String) session.getAttribute("teacherName");
String adminName = (String) session.getAttribute("adminName");
if(teacherName == null && adminName == null) {
    response.sendRedirect("login.jsp");
    return;
}
String dashboardLink = (teacherName != null) ? "teacher.jsp" : "admin.jsp";
String displayName = (teacherName != null) ? teacherName : "Administrator";


// Phase 2: subject + date selected → load students with pre-ticked status
String selectedSubject = request.getParameter("subject");
String selectedDate    = request.getParameter("attendance_date");
String selectedDay     = request.getParameter("day");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp","root","1648");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255,255,255,0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 950px; margin: 0 auto; }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; text-align: center; }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #11998e; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 25px; }
        .form-group { text-align: left; }
        label { display: block; margin-bottom: 8px; color: #555; font-size: 14px; font-weight: 600; }
        input[type="text"], input[type="date"], select { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; outline: none; transition: border-color 0.3s; }
        input:focus, select:focus { border-color: #11998e; }
        input[readonly] { background: #f9f9f9; }
        .btn-load { background: white; color: #11998e; border: 2px solid #11998e; padding: 12px 28px; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.2s; }
        .btn-load:hover { background: #11998e; color: white; }
        .btn-save { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 25px; transition: transform 0.2s, box-shadow 0.2s; }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(56,239,125,0.4); }
        table { width: 100%; border-collapse: collapse; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #333; font-weight: 600; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: #f1f8f6; }
        .cb-wrap { display: flex; justify-content: center; }
        input[type="checkbox"] { width: 22px; height: 22px; accent-color: #11998e; cursor: pointer; }
        .present-row { background: #e6f4ea !important; }
        .badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 600; }
        .badge-present { background: #d4edda; color: #155724; }
        .badge-absent  { background: #f8d7da; color: #721c24; }
        .info-banner { background: #e8f5e9; border-left: 4px solid #11998e; padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; color: #333; font-size: 14px; }
    </style>
</head>
<body>
<div class="container">
    <a href="<%= dashboardLink %>" class="nav-link">← Back to Dashboard</a>
    <h2>Mark Student Attendance</h2>

    <!-- Phase 1 Filter Form (GET to same page to load students) -->
    <form method="GET" action="markAttendance.jsp">
        <div class="form-grid">
            <div class="form-group">
                <label>Teacher/Admin Name</label>
                <input type="text" value="<%= displayName %>" readonly>
            </div>
            <div class="form-group">
                <label>Engineering Subject</label>
                <select name="subject" required>
                    <option value="" disabled <%= (selectedSubject==null)?"selected":"" %>>Select Subject</option>
                    <option value="DBMS"   <%= "DBMS".equals(selectedSubject)?"selected":"" %>>Database Management System (DBMS)</option>
                    <option value="Java"   <%= "Java".equals(selectedSubject)?"selected":"" %>>Java Programming</option>
                    <option value="OS"     <%= "OS".equals(selectedSubject)?"selected":"" %>>Operating Systems (OS)</option>
                    <option value="CN"     <%= "CN".equals(selectedSubject)?"selected":"" %>>Computer Networks (CN)</option>
                    <option value="Python" <%= "Python".equals(selectedSubject)?"selected":"" %>>Python Programming</option>
                </select>
            </div>
            <div class="form-group">
                <label>Day</label>
                <select name="day">
                    <option value="" disabled <%= (selectedDay==null)?"selected":"" %>>Select Day</option>
                    <option value="Monday"    <%= "Monday".equals(selectedDay)?"selected":"" %>>Monday</option>
                    <option value="Tuesday"   <%= "Tuesday".equals(selectedDay)?"selected":"" %>>Tuesday</option>
                    <option value="Wednesday" <%= "Wednesday".equals(selectedDay)?"selected":"" %>>Wednesday</option>
                    <option value="Thursday"  <%= "Thursday".equals(selectedDay)?"selected":"" %>>Thursday</option>
                    <option value="Friday"    <%= "Friday".equals(selectedDay)?"selected":"" %>>Friday</option>
                    <option value="Saturday"  <%= "Saturday".equals(selectedDay)?"selected":"" %>>Saturday</option>
                </select>
            </div>
            <div class="form-group">
                <label>Date</label>
                <input type="date" name="attendance_date" value="<%= (selectedDate!=null)?selectedDate:"" %>" required>
            </div>
        </div>
        <button type="submit" class="btn-load">Load Students &rarr;</button>
    </form>

    <% if(selectedSubject != null && selectedDate != null && !selectedDate.isEmpty()) { %>

    <% if(true) { %>
    <div class="info-banner" style="margin-top:25px;">
        Pre-ticked boxes show students already marked <strong>Present</strong> for <strong><%= selectedSubject %></strong> on <strong><%= selectedDate %></strong>. Untick to mark Absent.
    </div>
    <% } %>

    <!-- Phase 2 Save Form (POST to AttendanceServlet) -->
    <form action="AttendanceServlet" method="post">
        <input type="hidden" name="subject" value="<%= selectedSubject %>">
        <input type="hidden" name="attendance_date" value="<%= selectedDate %>">
        <input type="hidden" name="day" value="<%= (selectedDay!=null)?selectedDay:"" %>">

        <table>
            <tr>
                <th>Admission No</th>
                <th>Student Name</th>
                <th>Section</th>
                <th style="text-align:center;">Present?</th>
                <th style="text-align:center;">Last Status</th>
            </tr>

            <%
            PreparedStatement psStudents = con.prepareStatement("SELECT * FROM students");
            ResultSet rsStudents = psStudents.executeQuery();

            while(rsStudents.next()) {
                String adm  = rsStudents.getString("admission_no");
                String sName = rsStudents.getString("student_name");
                String sec  = rsStudents.getString("section");

                // Check existing attendance
                PreparedStatement psChk = con.prepareStatement(
                    "SELECT status FROM attendance WHERE admission_no=? AND subject=? AND attendance_date=?");
                psChk.setString(1, adm);
                psChk.setString(2, selectedSubject);
                psChk.setString(3, selectedDate);
                ResultSet rsChk = psChk.executeQuery();

                String lastStatus = null;
                if(rsChk.next()) lastStatus = rsChk.getString("status");
                boolean isPresent = "Present".equalsIgnoreCase(lastStatus);
            %>
            <tr class="<%= isPresent ? "present-row" : "" %>">
                <td><%= adm %></td>
                <td><%= sName %></td>
                <td><%= sec != null ? sec : "-" %></td>
                <td class="cb-wrap">
                    <input type="checkbox" name="attendance" value="<%= adm %>" <%= isPresent ? "checked" : "" %>>
                </td>
                <td style="text-align:center;">
                    <% if(lastStatus != null) { %>
                        <span class="badge <%= isPresent ? "badge-present" : "badge-absent" %>"><%= lastStatus %></span>
                    <% } else { %>
                        <span class="badge" style="background:#eee;color:#999;">New</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>

        <button type="submit" class="btn-save">Save Attendance</button>
    </form>

    <% } %>
</div>
</body>
</html>
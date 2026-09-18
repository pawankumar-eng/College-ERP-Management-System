<%@ page import="java.sql.*" %>

<%
String adm = (String) session.getAttribute("admissionNo");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

PreparedStatement ps =
con.prepareStatement(
"SELECT subject, COUNT(*) total, " +
"SUM(status='Present') present " +
"FROM attendance WHERE admission_no=? GROUP BY subject"
);

ps.setString(1, adm);

ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Attendance</title>

<style>
body{font-family:Arial;background:#f5f5f5;}
.card{width:700px;margin:auto;background:white;padding:20px;margin-top:30px;}
table{width:100%;border-collapse:collapse;}
th,td{border:1px solid #ddd;padding:10px;text-align:center;}
</style>

</head>

<body>

<div class="card">

<h2>My Attendance</h2>

<table>
<tr>
<th>Subject</th>
<th>Present</th>
<th>Total</th>
<th>Percentage</th>
</tr>

<%
while(rs.next()){

int total = rs.getInt("total");
int present = rs.getInt("present");

double percent = (present * 100.0) / total;
%>

<tr>
<td><%= rs.getString("subject") %></td>
<td><%= present %></td>
<td><%= total %></td>
<td><%= String.format("%.2f", percent) %>%</td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>
<%@ page import="java.sql.*" %>

<%
String adm = (String) session.getAttribute("admissionNo");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM fees WHERE admission_no=?"
);

ps.setString(1, adm);

ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>My Fees</title>

<style>
body{font-family:Arial;background:#f5f5f5;}
.card{width:600px;margin:auto;background:white;padding:20px;margin-top:30px;}
table{width:100%;border-collapse:collapse;}
th,td{border:1px solid #ddd;padding:10px;text-align:center;}
</style>

</head>

<body>

<div class="card">

<h2>Fee History</h2>

<table>
<tr>
<th>Amount</th>
<th>Mode</th>
<th>Status</th>
</tr>

<%
while(rs.next()){
%>

<tr>
<td><%= rs.getDouble("amount") %></td>
<td><%= rs.getString("payment_mode") %></td>
<td><%= rs.getString("payment_status") %></td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>
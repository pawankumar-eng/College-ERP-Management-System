<%@ page import="java.sql.*" %>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

PreparedStatement ps =
con.prepareStatement(
"SELECT * FROM notifications ORDER BY created_at DESC"
);

ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>Notifications</title>

<style>
body{
    font-family:Arial;
    background:#f5f5f5;
}

.card{
    width:700px;
    margin:auto;
    margin-top:30px;
    background:white;
    padding:20px;
    border-radius:10px;
}

.msg{
    padding:10px;
    border-bottom:1px solid #ddd;
}
</style>
</head>

<body>

<div class="card">

<h2>📢 Notifications</h2>

<%
while(rs.next()){
%>

<div class="msg">
    <b><%= rs.getString("created_at") %></b><br>
    <%= rs.getString("message") %>
</div>

<%
}
%>

</div>

</body>
</html>
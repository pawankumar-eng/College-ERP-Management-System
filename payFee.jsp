<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String admissionNo = (String) session.getAttribute("admissionNo");
String studentName = (String) session.getAttribute("studentName");
if(admissionNo == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay Fee</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 500px; text-align: center; backdrop-filter: blur(10px); }
        h2 { color: #333; margin-bottom: 25px; font-weight: 600; }
        .form-group { margin-bottom: 20px; text-align: left; }
        label { display: block; margin-bottom: 8px; color: #555; font-size: 14px; font-weight: 600; }
        input[type="text"], input[type="number"], select { width: 100%; padding: 12px 15px; border: 1px solid #ddd; border-radius: 8px; font-size: 15px; outline: none; transition: border-color 0.3s; }
        input[readonly] { background-color: #f8f9fa; cursor: not-allowed; }
        input:focus, select:focus { border-color: #667eea; box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2); }
        .btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: transform 0.2s, box-shadow 0.2s; width: 100%; margin-top: 10px; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4); }
        .nav-link { display: inline-block; margin-bottom: 20px; color: #667eea; text-decoration: none; font-weight: 600; }
        .nav-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

<div class="container">
    <a href="student.jsp" class="nav-link">&larr; Back to Dashboard</a>
    <h2>Online Fee Payment</h2>

    <form action="AddFeeServlet" method="post">
        <div class="form-group">
            <label>Admission No</label>
            <input type="text" name="admission_no" value="<%= admissionNo %>" readonly>
        </div>
        <div class="form-group">
            <label>Student Name</label>
            <input type="text" value="<%= studentName %>" readonly>
        </div>
        <div class="form-group">
            <label>Amount to Pay (Rs.)</label>
            <input type="number" name="amount" placeholder="e.g. 500" required min="1" step="0.01">
        </div>
        <div class="form-group">
            <label>Payment Mode</label>
            <select name="payment_mode" required>
                <option value="Credit Card">Credit/Debit Card</option>
                <option value="Net Banking">Net Banking</option>
                <option value="UPI">UPI</option>
            </select>
        </div>

        <button type="submit" class="btn-primary">Proceed to Pay</button>
    </form>
</div>

</body>
</html>
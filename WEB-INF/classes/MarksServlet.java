import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MarksServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String admission = request.getParameter("admission_no");
            String subject   = request.getParameter("subject");
            int marks        = Integer.parseInt(request.getParameter("marks"));

            String grade;
            if      (marks >= 90) grade = "A+";
            else if (marks >= 80) grade = "A";
            else if (marks >= 70) grade = "B+";
            else if (marks >= 60) grade = "B";
            else if (marks >= 50) grade = "C";
            else                  grade = "F";

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO marks(admission_no, subject, marks, grade) VALUES(?,?,?,?)"
            );
            ps.setString(1, admission);
            ps.setString(2, subject);
            ps.setInt(3, marks);
            ps.setString(4, grade);
            ps.executeUpdate();
            con.close();

            // Styled success page
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width,initial-scale=1.0'>");
            out.println("<title>Marks Saved</title>");
            out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
            out.println("<style>*{box-sizing:border-box;margin:0;padding:0;font-family:'Inter',sans-serif;}");
            out.println("body{background:linear-gradient(135deg,#11998e 0%,#38ef7d 100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px;}");
            out.println(".box{background:rgba(255,255,255,0.95);padding:40px;border-radius:20px;box-shadow:0 15px 35px rgba(0,0,0,0.2);max-width:440px;width:100%;text-align:center;}");
            out.println("h2{color:#11998e;margin-bottom:12px;} .meta{color:#555;margin-bottom:8px;font-size:15px;} .grade{font-size:42px;font-weight:700;color:#11998e;margin:15px 0;}");
            out.println(".btn{display:inline-block;background:linear-gradient(135deg,#11998e,#38ef7d);color:white;padding:12px 26px;border-radius:8px;font-size:14px;font-weight:600;text-decoration:none;margin:5px;}");
            out.println(".btn-out{background:white;color:#11998e;border:2px solid #11998e;}");
            out.println("</style></head><body><div class='box'>");
            out.println("<h2>Marks Saved!</h2>");
            out.println("<p class='meta'>Subject: <strong>" + subject + "</strong></p>");
            out.println("<p class='meta'>Marks: <strong>" + marks + "/100</strong></p>");
            out.println("<div class='grade'>Grade: " + grade + "</div>");
            out.println("<a href='addMarks.jsp' class='btn btn-out'>Add More</a>");
            out.println("<a href='teacher.jsp' class='btn'>Dashboard</a>");
            out.println("</div></body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving marks: " + e.getMessage());
        }
    }
}
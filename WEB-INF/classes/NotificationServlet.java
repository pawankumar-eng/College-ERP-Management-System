import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class NotificationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String message = request.getParameter("message");
            String mode    = request.getParameter("recipient_mode"); // ALL, STUDENTS, TEACHERS

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO notifications(message, target_type, target_id) VALUES(?, ?, ?)"
            );

            int totalSent = 0;

            if ("ALL".equals(mode)) {
                // One row for everyone
                ps.setString(1, message);
                ps.setString(2, "ALL");
                ps.setString(3, "ALL");
                ps.executeUpdate();
                totalSent = 1;
            } else if ("STUDENTS".equals(mode)) {
                String[] studentIds = request.getParameterValues("student_ids");
                if (studentIds != null) {
                    for (String sid : studentIds) {
                        ps.setString(1, message);
                        ps.setString(2, "STUDENT");
                        ps.setString(3, sid);
                        ps.executeUpdate();
                        totalSent++;
                    }
                }
            } else if ("TEACHERS".equals(mode)) {
                String[] teacherIds = request.getParameterValues("teacher_ids");
                if (teacherIds != null) {
                    for (String tid : teacherIds) {
                        ps.setString(1, message);
                        ps.setString(2, "TEACHER");
                        ps.setString(3, tid);
                        ps.executeUpdate();
                        totalSent++;
                    }
                }
            }

            con.close();

            // Styled success page
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width,initial-scale=1.0'>");
            out.println("<title>Notification Sent</title>");
            out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap' rel='stylesheet'>");
            out.println("<style>*{box-sizing:border-box;margin:0;padding:0;font-family:'Inter',sans-serif;}");
            out.println("body{background:linear-gradient(135deg,#1e3c72 0%,#2a5298 100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px;}");
            out.println(".box{background:rgba(255,255,255,0.97);padding:40px;border-radius:20px;box-shadow:0 15px 35px rgba(0,0,0,0.2);max-width:460px;width:100%;text-align:center;}");
            out.println("h2{color:#1e3c72;margin-bottom:10px;font-size:22px;} .count{font-size:42px;font-weight:700;color:#2a5298;margin:15px 0;} p{color:#555;margin-bottom:25px;line-height:1.6;}");
            out.println(".msg-preview{background:#eef2ff;border-left:4px solid #2a5298;padding:12px 15px;border-radius:8px;text-align:left;font-size:14px;color:#333;margin-bottom:20px;}");
            out.println(".btn{display:inline-block;background:linear-gradient(135deg,#1e3c72,#2a5298);color:white;padding:12px 26px;border-radius:8px;font-size:14px;font-weight:600;text-decoration:none;margin:5px;}");
            out.println(".btn-out{background:white;color:#2a5298;border:2px solid #2a5298;}</style></head><body><div class='box'>");
            out.println("<h2>Notification Sent!</h2>");
            if ("ALL".equals(mode)) {
                out.println("<div class='count'>All</div>");
                out.println("<p>Notification sent to <strong>all students and teachers</strong>.</p>");
            } else {
                out.println("<div class='count'>" + totalSent + "</div>");
                out.println("<p>recipient" + (totalSent != 1 ? "s" : "") + " received your message.</p>");
            }
            out.println("<div class='msg-preview'>" + message + "</div>");
            out.println("<a href='sendNotification.jsp' class='btn btn-out'>Send Another</a>");
            out.println("<a href='admin.jsp' class='btn'>Dashboard</a>");
            out.println("</div></body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error sending notification: " + e.getMessage());
        }
    }
}
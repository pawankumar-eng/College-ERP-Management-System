import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class TimetableServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String dayName   = request.getParameter("day_name");
            String timeSlot  = request.getParameter("time_slot");
            String subject   = request.getParameter("subject");
            String teacher   = request.getParameter("teacher");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO timetable(day_name, time_slot, subject, teacher) VALUES(?,?,?,?)"
            );
            ps.setString(1, dayName);
            ps.setString(2, timeSlot);
            ps.setString(3, subject);
            ps.setString(4, teacher);
            ps.executeUpdate();
            con.close();

            // Styled success page
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Timetable Updated</title>");
            out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
            out.println("<style>* { box-sizing:border-box; margin:0; padding:0; font-family:'Inter',sans-serif; }");
            out.println("body { background:linear-gradient(135deg,#11998e 0%,#38ef7d 100%); min-height:100vh; display:flex; align-items:center; justify-content:center; padding:20px; }");
            out.println(".box { background:rgba(255,255,255,0.95); padding:40px; border-radius:20px; box-shadow:0 15px 35px rgba(0,0,0,0.2); max-width:420px; width:100%; text-align:center; }");
            out.println("h2 { color:#11998e; margin-bottom:12px; } p { color:#555; margin-bottom:25px; }");
            out.println(".btn { display:inline-block; background:linear-gradient(135deg,#11998e,#38ef7d); color:white; padding:13px 28px; border-radius:8px; font-size:15px; font-weight:600; text-decoration:none; margin:5px; }");
            out.println(".btn-out { background:white; color:#11998e; border:2px solid #11998e; }");
            out.println("</style></head><body><div class='box'>");
            out.println("<h2>Timetable Updated!</h2>");
            out.println("<p><strong>" + subject + "</strong> on <strong>" + dayName + "</strong> at <strong>" + timeSlot + "</strong> added successfully.</p>");
            out.println("<a href='timetable.jsp' class='btn btn-out'>Add More</a>");
            out.println("<a href='teacher.jsp' class='btn'>Dashboard</a>");
            out.println("</div></body></html>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating timetable: " + e.getMessage());
        }
    }
}

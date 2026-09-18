import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AttendanceServlet extends HttpServlet {

    private void printStyledSuccess(HttpServletResponse response, String subject, String date, String day) throws IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html><html lang='en'><head><meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Attendance Saved</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
        out.println("<style>* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }");
        out.println("body { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }");
        out.println(".container { background: rgba(255,255,255,0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 450px; width: 100%; text-align: center; }");
        out.println("h2 { color: #11998e; margin-bottom: 12px; font-size: 24px; }");
        out.println(".meta { color: #666; font-size: 14px; margin-bottom: 25px; }");
        out.println(".btn { display: inline-block; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; padding: 13px 30px; border-radius: 8px; font-size: 15px; font-weight: 600; text-decoration: none; margin: 6px; }");
        out.println(".btn-outline { background: white; color: #11998e; border: 2px solid #11998e; }");
        out.println("</style></head><body><div class='container'>");
        out.println("<h2>Attendance Saved!</h2>");
        out.println("<p class='meta'>Subject: <strong>" + subject + "</strong> &nbsp;|&nbsp; Day: <strong>" + day + "</strong> &nbsp;|&nbsp; Date: <strong>" + date + "</strong></p>");
        out.println("<a href='markAttendance.jsp' class='btn btn-outline'>Mark Again</a>");
        out.println("<a href='teacher.jsp' class='btn'>Dashboard</a>");
        out.println("</div></body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String subject = request.getParameter("subject");
            String date    = request.getParameter("attendance_date");
            String day     = request.getParameter("day");
            String[] present = request.getParameterValues("attendance");

            // Fetch all student admission numbers
            PreparedStatement ps1 = con.prepareStatement("SELECT admission_no FROM students");
            ResultSet rs = ps1.executeQuery();

            while (rs.next()) {
                String adm = rs.getString("admission_no");
                String status = "Absent";
                if (present != null) {
                    for (String p : present) {
                        if (p.equals(adm)) { status = "Present"; break; }
                    }
                }

                // Check if a record already exists for this student/subject/date
                PreparedStatement check = con.prepareStatement(
                    "SELECT id FROM attendance WHERE admission_no=? AND subject=? AND attendance_date=?"
                );
                check.setString(1, adm);
                check.setString(2, subject);
                check.setString(3, date);
                ResultSet existing = check.executeQuery();

                if (existing.next()) {
                    // UPDATE existing record
                    PreparedStatement upd = con.prepareStatement(
                        "UPDATE attendance SET status=? WHERE admission_no=? AND subject=? AND attendance_date=?"
                    );
                    upd.setString(1, status);
                    upd.setString(2, adm);
                    upd.setString(3, subject);
                    upd.setString(4, date);
                    upd.executeUpdate();
                } else {
                    // INSERT new record
                    PreparedStatement ins = con.prepareStatement(
                        "INSERT INTO attendance(admission_no, subject, attendance_date, status) VALUES(?,?,?,?)"
                    );
                    ins.setString(1, adm);
                    ins.setString(2, subject);
                    ins.setString(3, date);
                    ins.setString(4, status);
                    ins.executeUpdate();
                }
            }

            printStyledSuccess(response, subject, date, day == null ? "" : day);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error saving attendance: " + e.getMessage());
        }
    }
}
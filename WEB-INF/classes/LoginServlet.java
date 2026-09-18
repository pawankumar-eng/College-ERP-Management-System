import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    private void printStyledError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Login Error</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println("* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }");
        out.println("body { background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }");
        out.println(".container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 450px; text-align: center; backdrop-filter: blur(10px); }");
        out.println("h2 { color: #333; margin-bottom: 15px; font-weight: 600; }");
        out.println("p { color: #555; margin-bottom: 25px; line-height: 1.5; }");
        out.println(".btn { display: inline-block; background: linear-gradient(135deg, #ff416c 0%, #ff4b2b 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: transform 0.2s, box-shadow 0.2s; }");
        out.println(".btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h2>Login Failed</h2>");
        out.println("<p>" + message + "</p>");
        out.println("<a href='login.jsp' class='btn'>Try Again</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Connection con = DBConnection.getConnection();
            String role = request.getParameter("role");
            String id = request.getParameter("id");
            String pass = request.getParameter("password");
            HttpSession session = request.getSession();

            if(role.equals("ADMIN")) {
                if(id.equals("admin") && pass.equals("admin")) {
                    session.setAttribute("adminName", "Administrator");
                    response.sendRedirect("admin.jsp");
                } else {
                    printStyledError(response, "Invalid Admin Credentials.");
                }
            } else if(role.equals("STUDENT")) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM students WHERE admission_no=? AND password=?");
                ps.setString(1, id);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();

                if(rs.next()) {
                    session.setAttribute("admissionNo", id);
                    session.setAttribute("studentName", rs.getString("student_name"));
                    response.sendRedirect("student.jsp");
                } else {
                    printStyledError(response, "Invalid Admission Number or Password. Please double-check your credentials and try again.");
                }
            } else {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM teachers WHERE teacher_id=? AND password=?");
                ps.setString(1, id);
                ps.setString(2, pass);
                ResultSet rs = ps.executeQuery();

                if(rs.next()) {
                    session.setAttribute("teacherId", id);
                    session.setAttribute("teacherName", rs.getString("teacher_name"));
                    response.sendRedirect("teacher.jsp"); 
                } else {
                    printStyledError(response, "Invalid Teacher ID or Password. Please double-check your credentials and try again.");
                }
            }
        } catch(Exception e){
            e.printStackTrace();
            printStyledError(response, "A system error occurred. Please try again later.");
        }
    }
}
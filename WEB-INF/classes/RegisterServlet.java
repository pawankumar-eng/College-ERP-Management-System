import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    private void printStyledMessage(PrintWriter out, String title, String message, String linkText, String linkUrl, boolean isSuccess) {
        String color1 = isSuccess ? "#11998e" : "#ff416c";
        String color2 = isSuccess ? "#38ef7d" : "#ff4b2b";
        
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>" + title + "</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println("* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }");
        out.println("body { background: linear-gradient(135deg, " + color1 + " 0%, " + color2 + " 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }");
        out.println(".container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 450px; text-align: center; backdrop-filter: blur(10px); }");
        out.println("h2 { color: #333; margin-bottom: 15px; font-weight: 600; }");
        out.println("p { color: #555; margin-bottom: 25px; line-height: 1.5; }");
        out.println(".btn { display: inline-block; background: linear-gradient(135deg, " + color1 + " 0%, " + color2 + " 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: transform 0.2s, box-shadow 0.2s; }");
        out.println(".btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h2>" + title + "</h2>");
        out.println("<p>" + message + "</p>");
        out.println("<a href='" + linkUrl + "' class='btn'>" + linkText + "</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String role = request.getParameter("role");

        try {

            Connection con = DBConnection.getConnection();

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if ("STUDENT".equalsIgnoreCase(role)) {

                String admissionNo = request.getParameter("admission_no");
                String section = request.getParameter("section");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO students(admission_no,student_name,section,email,password) VALUES(?,?,?,?,?)"
                );

                ps.setString(1, admissionNo);
                ps.setString(2, name);
                ps.setString(3, section);
                ps.setString(4, email);
                ps.setString(5, password);

                ps.executeUpdate();

                printStyledMessage(out, "Registration Successful!", "Welcome to the College ERP System. Your student account has been created successfully.", "Login Now", "login.jsp", true);

                ps.close();
            }

            else if ("TEACHER".equalsIgnoreCase(role)) {

                String teacherId = request.getParameter("teacher_id");

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO teachers(teacher_id,teacher_name,email,password) VALUES(?,?,?,?)"
                );

                ps.setString(1, teacherId);
                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, password);

                ps.executeUpdate();

                printStyledMessage(out, "Registration Successful!", "Welcome to the College ERP System. Your teacher account has been created successfully.", "Login Now", "login.jsp", true);

                ps.close();
            }

            con.close();

        } catch(Exception e) {
            printStyledMessage(out, "Registration Error", "An error occurred while creating your account. It's possible the Admission No or Teacher ID is already registered.<br><br><small>" + e.getMessage() + "</small>", "Try Again", "register.jsp", false);
        }
    }
}
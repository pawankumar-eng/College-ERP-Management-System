import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddFeeServlet extends HttpServlet {

    private void printStyledSuccess(HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<!DOCTYPE html>");
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<meta charset='UTF-8'>");
        out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
        out.println("<title>Payment Successful</title>");
        out.println("<link href='https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap' rel='stylesheet'>");
        out.println("<style>");
        out.println("* { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }");
        out.println("body { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 20px; }");
        out.println(".container { background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 450px; text-align: center; backdrop-filter: blur(10px); }");
        out.println("h2 { color: #11998e; margin-bottom: 15px; font-weight: 600; }");
        out.println("p { color: #555; margin-bottom: 25px; line-height: 1.5; }");
        out.println(".btn { display: inline-block; background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; padding: 14px 30px; border-radius: 8px; font-size: 16px; font-weight: 600; text-decoration: none; transition: transform 0.2s, box-shadow 0.2s; }");
        out.println(".btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,0,0,0.2); }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class='container'>");
        out.println("<h2>Payment Successful!</h2>");
        out.println("<p>Your fee payment has been securely processed and recorded.</p>");
        out.println("<a href='student.jsp' class='btn'>Go to Dashboard</a>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String admission_no = request.getParameter("admission_no");
            double amount = Double.parseDouble(request.getParameter("amount"));
            String payment_mode = request.getParameter("payment_mode");
            String payment_status = "Paid"; // Since they are paying directly here

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO fees(admission_no, amount, payment_mode, payment_status) VALUES(?,?,?,?)"
            );

            ps.setString(1, admission_no);
            ps.setDouble(2, amount);
            ps.setString(3, payment_mode);
            ps.setString(4, payment_status);

            ps.executeUpdate();

            printStyledSuccess(response);

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred during payment.");
        }
    }
}
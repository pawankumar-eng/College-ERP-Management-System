import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddNotificationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Connection con = DBConnection.getConnection();

            String title = request.getParameter("title");
            String message = request.getParameter("message");
            String sender = request.getParameter("sender");
            String target_role = request.getParameter("target_role");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO notifications(title,message,sender,target_role) VALUES(?,?,?,?)"
            );

            ps.setString(1, title);
            ps.setString(2, message);
            ps.setString(3, sender);
            ps.setString(4, target_role);

            ps.executeUpdate();

            response.getWriter().println("<h2>Notification Sent Successfully</h2>");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class FeesServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
throws ServletException, IOException {

try {

Connection con = DBConnection.getConnection();

String adm = request.getParameter("admission_no");
String mode = request.getParameter("payment_mode");
String amount = request.getParameter("amount");

PreparedStatement ps = con.prepareStatement(
"INSERT INTO fees(admission_no,amount,payment_mode,payment_status) VALUES(?,?,?,?)"
);

ps.setString(1, adm);
ps.setDouble(2, Double.parseDouble(amount));
ps.setString(3, mode);
ps.setString(4, "SUCCESS");

ps.executeUpdate();

response.sendRedirect("student.jsp");

} catch(Exception e){
e.printStackTrace();
}
}
}
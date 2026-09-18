import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddMarksServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Connection con = DBConnection.getConnection();

            String subject = request.getParameter("subject");
            String exam_date = request.getParameter("exam_date");

            String[] admission_no = request.getParameterValues("admission_no");
            String[] marks = request.getParameterValues("marks");

            String teacher = "Mr. Sharma";

            for(int i = 0; i < admission_no.length; i++) {

                int mark = Integer.parseInt(marks[i]);

                String grade;

                if(mark >= 90) grade = "A+";
                else if(mark >= 75) grade = "A";
                else if(mark >= 60) grade = "B";
                else if(mark >= 40) grade = "C";
                else grade = "F";

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO marks(admission_no,subject,marks,grade,teacher,exam_date) VALUES(?,?,?,?,?,?)"
                );

                ps.setString(1, admission_no[i]);
                ps.setString(2, subject);
                ps.setInt(3, mark);
                ps.setString(4, grade);
                ps.setString(5, teacher);
                ps.setString(6, exam_date);

                ps.executeUpdate();
            }

            response.getWriter().println("<h2>Marks Saved Successfully</h2>");

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
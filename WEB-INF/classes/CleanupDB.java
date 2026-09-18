import java.sql.*;

public class CleanupDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            String sql1 = "CREATE TEMPORARY TABLE keep_ids AS " +
                          "SELECT MAX(id) as id FROM attendance GROUP BY admission_no, subject, attendance_date";
            con.createStatement().execute(sql1);

            String sql2 = "DELETE FROM attendance WHERE id NOT IN (SELECT id FROM keep_ids)";
            int deleted = con.createStatement().executeUpdate(sql2);

            System.out.println("Cleaned up " + deleted + " duplicate attendance records.");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

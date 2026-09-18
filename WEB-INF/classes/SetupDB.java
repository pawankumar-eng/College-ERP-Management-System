import java.sql.*;

public class SetupDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            // Clean existing timetable
            con.createStatement().executeUpdate("TRUNCATE TABLE timetable");

            // Insert fixed timetable
            String sql = "INSERT INTO timetable(day_name, time_slot, subject, teacher) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            String[][] fixedTimetable = {
                {"Monday", "09:00 AM - 10:00 AM", "DBMS", "Dr. Smith"},
                {"Monday", "10:00 AM - 11:00 AM", "Java", "Dr. Johnson"},
                {"Tuesday", "09:00 AM - 10:00 AM", "OS", "Dr. Williams"},
                {"Tuesday", "10:00 AM - 11:00 AM", "CN", "Dr. Brown"},
                {"Wednesday", "09:00 AM - 10:00 AM", "Python", "Dr. Taylor"},
                {"Wednesday", "10:00 AM - 11:00 AM", "DBMS", "Dr. Smith"},
                {"Thursday", "09:00 AM - 10:00 AM", "Java", "Dr. Johnson"},
                {"Thursday", "10:00 AM - 11:00 AM", "OS", "Dr. Williams"},
                {"Friday", "09:00 AM - 10:00 AM", "CN", "Dr. Brown"},
                {"Friday", "10:00 AM - 11:00 AM", "Python", "Dr. Taylor"}
            };

            for(String[] row : fixedTimetable) {
                ps.setString(1, row[0]);
                ps.setString(2, row[1]);
                ps.setString(3, row[2]);
                ps.setString(4, row[3]);
                ps.executeUpdate();
            }

            // Remove any duplicated attendance rows by keeping only latest
            System.out.println("Timetable setup complete.");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

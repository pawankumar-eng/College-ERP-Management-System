import java.sql.*;

public class SetupNewTimetable {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            // Clear old timetable
            con.createStatement().executeUpdate("TRUNCATE TABLE timetable");

            String sql = "INSERT INTO timetable(day_name, time_slot, subject, teacher) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            String[][] grid = {
                {"Monday", "09:00 AM - 10:00 AM", "Engineering Mathematics", "Dr. Sharma"},
                {"Monday", "10:00 AM - 11:00 AM", "Data Structures", "Dr. Gupta"},
                {"Monday", "11:00 AM - 12:00 PM", "DBMS", "Dr. Smith"},
                {"Monday", "12:00 PM - 01:00 PM", "ERP Development", "Dr. Johnson"},
                {"Monday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Monday", "02:00 PM - 03:00 PM", "Software Engineering", "Dr. Williams"},
                {"Monday", "03:00 PM - 04:00 PM", "Computer Networks Lab", "Dr. Brown"},

                {"Tuesday", "09:00 AM - 10:00 AM", "Data Structures", "Dr. Gupta"},
                {"Tuesday", "10:00 AM - 11:00 AM", "Engineering Mathematics", "Dr. Sharma"},
                {"Tuesday", "11:00 AM - 12:00 PM", "Computer Networks", "Dr. Brown"},
                {"Tuesday", "12:00 PM - 01:00 PM", "DBMS Lab", "Dr. Smith"},
                {"Tuesday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Tuesday", "02:00 PM - 03:00 PM", "ERP Project Work", "Dr. Davis"},
                {"Tuesday", "03:00 PM - 04:00 PM", "Software Engineering Lab", "Dr. Williams"},

                {"Wednesday", "09:00 AM - 10:00 AM", "DBMS", "Dr. Smith"},
                {"Wednesday", "10:00 AM - 11:00 AM", "Software Engineering", "Dr. Williams"},
                {"Wednesday", "11:00 AM - 12:00 PM", "Engineering Mathematics", "Dr. Sharma"},
                {"Wednesday", "12:00 PM - 01:00 PM", "Data Structures Lab", "Dr. Gupta"},
                {"Wednesday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Wednesday", "02:00 PM - 03:00 PM", "Computer Networks", "Dr. Brown"},
                {"Wednesday", "03:00 PM - 04:00 PM", "ERP Project Work", "Dr. Davis"},

                {"Thursday", "09:00 AM - 10:00 AM", "Software Engineering", "Dr. Williams"},
                {"Thursday", "10:00 AM - 11:00 AM", "DBMS", "Dr. Smith"},
                {"Thursday", "11:00 AM - 12:00 PM", "ERP Development", "Dr. Johnson"},
                {"Thursday", "12:00 PM - 01:00 PM", "Computer Networks", "Dr. Brown"},
                {"Thursday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Thursday", "02:00 PM - 03:00 PM", "Data Structures", "Dr. Gupta"},
                {"Thursday", "03:00 PM - 04:00 PM", "DBMS Lab", "Dr. Smith"},

                {"Friday", "09:00 AM - 10:00 AM", "Computer Networks", "Dr. Brown"},
                {"Friday", "10:00 AM - 11:00 AM", "ERP Development", "Dr. Johnson"},
                {"Friday", "11:00 AM - 12:00 PM", "Software Engineering", "Dr. Williams"},
                {"Friday", "12:00 PM - 01:00 PM", "Engineering Mathematics", "Dr. Sharma"},
                {"Friday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Friday", "02:00 PM - 03:00 PM", "DBMS", "Dr. Smith"},
                {"Friday", "03:00 PM - 04:00 PM", "Project Review", "Dr. Miller"},

                {"Saturday", "09:00 AM - 10:00 AM", "ERP Project Review", "Dr. Davis"},
                {"Saturday", "10:00 AM - 11:00 AM", "Seminar", "Dr. Wilson"},
                {"Saturday", "11:00 AM - 12:00 PM", "Aptitude Training", "Dr. Moore"},
                {"Saturday", "12:00 PM - 01:00 PM", "Project Documentation", "Dr. Davis"},
                {"Saturday", "01:00 PM - 02:00 PM", "Lunch Break", "-"},
                {"Saturday", "02:00 PM - 03:00 PM", "ERP Project Work", "Dr. Davis"},
                {"Saturday", "03:00 PM - 04:00 PM", "Weekly Presentation", "Dr. Miller"}
            };

            for(String[] row : grid) {
                ps.setString(1, row[0]);
                ps.setString(2, row[1]);
                ps.setString(3, row[2]);
                ps.setString(4, row[3]);
                ps.executeUpdate();
            }

            System.out.println("Detailed timetable successfully injected with AM/PM formatting.");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

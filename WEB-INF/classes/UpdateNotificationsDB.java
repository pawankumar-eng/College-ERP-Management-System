import java.sql.*;

public class UpdateNotificationsDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/erp", "root", "1648");

            Statement stmt = con.createStatement();

            // Add new columns to notifications
            try {
                stmt.execute("ALTER TABLE notifications ADD COLUMN target_type VARCHAR(20) DEFAULT 'ALL'");
                System.out.println("Added target_type column.");
            } catch (SQLException e) {
                System.out.println("target_type column may already exist.");
            }

            try {
                stmt.execute("ALTER TABLE notifications ADD COLUMN target_id VARCHAR(50) DEFAULT 'ALL'");
                System.out.println("Added target_id column.");
            } catch (SQLException e) {
                System.out.println("target_id column may already exist.");
            }

            try {
                stmt.execute("ALTER TABLE notifications ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP");
                System.out.println("Added created_at column.");
            } catch (SQLException e) {
                System.out.println("created_at column may already exist.");
            }

            con.close();
            System.out.println("Database update complete.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

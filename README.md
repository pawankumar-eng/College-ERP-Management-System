# 🎓 College ERP Management System

## 📖 About
A comprehensive, full-stack web-based ERP solution designed to streamline college operations. It digitizes student and faculty management, fee processing, attendance tracking, result publication, and university-wide notifications. 

## 💻 Tech Stack & Tools
**Frontend & UI:**
* **Languages:** HTML5, CSS3, JavaScript (Vanilla)
* **Views:** JSP (JavaServer Pages)
* **Design:** Custom Glassmorphism UI, Google Fonts (Inter)

**Backend & Database:**
* **Core:** Java (Servlets, JDBC)
* **Database:** MySQL

**Development Tools & Environment:**
* **Server:** Apache Tomcat 9
* **IDEs & Tools:** VS Code, MySQL Workbench, Git

## ⚙️ Key Modules & Features

| Module | Features & Capabilities |
| :--- | :--- |
| 🛡️ **Admin Dashboard** | Database setup/cleanup, generate reports, manage college fees, broadcast notifications, and configure timetables. |
| 👨‍🏫 **Teacher Dashboard** | Mark daily student attendance, upload academic results, and view official notifications. |
| 🧑‍🎓 **Student Dashboard** | View real-time attendance, access academic results, view & pay fees, check class timetables, and receive notices. |
| 🔐 **Authentication** | Secure, role-based login routing for Admins, Teachers, and Students with dynamic UI rendering. |

## 🚀 How to Run

1. **Database Setup (MySQL Workbench):** 
   - Open **MySQL Workbench** and create a new database.
   - Run the provided `SetupDB.java` servlet or import the database SQL tables.
   - Update your database credentials (username/password) in the `DBConnection.java` file.
2. **IDE Configuration (VS Code / Eclipse):** 
   - Open the project folder in **VS Code** (or your preferred IDE).
   - Ensure the Java Extension Pack and Tomcat for Java extensions are installed.
3. **Execution:**
   - Add the project directory to your **Apache Tomcat 9** server.
   - Start Tomcat and open the application in your browser (usually `http://localhost:8085/ERP`).

---

## 👨‍💻 Developer
Developed by Pawan Kumar | B.Tech CSE @ Galgotias University

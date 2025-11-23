# Student Details Manager

A simple web-based application to manage student details and courses, built with Java Servlets, JSP, and MySQL.

## Features

- **Student Management**: Add, Edit, Delete, and List students.
- **Course Management**: Add, Edit, Delete, and List courses.
- **Automated Setup**: Includes a script to automatically download dependencies and configure the server.
- **Sequential IDs**: Displays user-friendly row numbers in the UI while maintaining database integrity.

## Prerequisites

- **Java Development Kit (JDK) 8+**
- **MySQL Server** (running locally)

## Quick Start (Automated)

1.  **Clone the repository**:

    ```bash
    git clone https://github.com/milind2k4/Student-Details-Java-Project.git
    cd Student-Details-Java-Project
    ```

2.  **Run the Setup Script**:

    - Double-click `auto_setup.bat`.
    - OR run it from the terminal:
      ```powershell
      .\auto_setup.bat
      ```

3.  **Follow the Prompts**:

    - The script will download Apache Tomcat 9 automatically.
    - It will ask for your **MySQL root password** to configure the database connection.

4.  **Access the Application**:
    - The script will automatically open the application in your default browser.
    - URL: [http://localhost:8081/StudentDetails/list](http://localhost:8081/StudentDetails/list)

## Manual Setup (Optional)

If you prefer to set it up manually:

1.  Import `database_setup.sql` into your MySQL server.
2.  Update `src/com/student/util/DBConnection.java` with your database credentials.
3.  Compile the project using `deploy.bat` or your IDE.
4.  Deploy the `WebContent` folder to your Tomcat `webapps` directory.
5.  Start Tomcat and access the URL.

## Technologies Used

- **Backend**: Java Servlets, JDBC
- **Frontend**: JSP, JSTL, HTML/CSS
- **Database**: MySQL
- **Server**: Apache Tomcat 9
- **Automation**: PowerShell & Batch Scripts

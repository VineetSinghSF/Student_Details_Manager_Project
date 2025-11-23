# Student Details Manager - Setup & Run Guide

This guide will help you set up and run the Student Details Manager project on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

1.  **Java Development Kit (JDK) 8 or higher**: [Download JDK](https://www.oracle.com/java/technologies/downloads/)
2.  **Apache Tomcat 9**: [Download Tomcat 9](https://tomcat.apache.org/download-90.cgi) (Download the "Core" zip file, e.g., `apache-tomcat-9.0.xx.zip`)
3.  **MySQL Server**: [Download MySQL](https://dev.mysql.com/downloads/installer/)

## Step 1: Database Setup

1.  Open your MySQL Command Line Client or MySQL Workbench.
2.  Login with your username and password (default is usually `root`).
3.  Open the `database_setup.sql` file provided in this project.
4.  Copy the contents and paste them into your MySQL client to execute them.
    - This will create a database named `student_db`.
    - It will create two tables: `courses` and `students`.
    - It will insert some sample data.

## Step 2: Project Configuration

1.  **Database Credentials**:
    - Open `src/com/student/util/DBConnection.java`.
    - Check the `url`, `username`, and `password` variables.
    - If your MySQL password is not empty, update the `password` variable.

## Step 3: Compiling and Packaging

Since you are using VS Code without a specific build tool like Maven, we will compile manually or use the VS Code Java extensions.

**Option A: Manual Compilation (Command Line)**

1.  Open a terminal (Command Prompt or PowerShell).
2.  Navigate to the project root directory: `e:\Code\Java\Student Details`
3.  Create a folder for compiled classes:
    ```powershell
    mkdir WebContent\WEB-INF\classes
    ```
4.  Compile the Java files (replace `path\to\servlet-api.jar` with the actual path inside your Tomcat `lib` folder):
    ```powershell
    javac -cp ".;C:\path\to\tomcat\lib\servlet-api.jar" -d WebContent\WEB-INF\classes src\com\student\bean\*.java src\com\student\dao\*.java src\com\student\util\*.java src\com\student\web\*.java
    ```
    _Note: You need to find where you extracted Tomcat to get the `servlet-api.jar` path._

**Option B: VS Code Java Extension**

1.  Open the project folder in VS Code.
2.  Ensure "Extension Pack for Java" is installed.
3.  VS Code should automatically compile the files into a `bin` or `target` folder. You may need to configure the output path to `WebContent\WEB-INF\classes`.

## Step 4: Deployment

1.  Locate your **Apache Tomcat** folder.
2.  Go to the `webapps` directory inside Tomcat.
3.  Copy the `WebContent` folder from your project.
4.  Paste it into `webapps` and rename it to `StudentDetails`.
    - Structure should look like: `apache-tomcat-9.0.xx\webapps\StudentDetails\index.jsp`

## Step 5: Running the Server

1.  Open a terminal.
2.  Navigate to your Tomcat `bin` directory.
3.  Run `startup.bat` (Windows) or `./startup.sh` (Mac/Linux).
4.  Wait for the server to start (you'll see "Server startup in [x] ms").

## Step 6: Accessing the Application

1.  Open your web browser.
2.  Go to: [http://localhost:8080/StudentDetails/](http://localhost:8080/StudentDetails/)

## Troubleshooting

- **404 Not Found**: Check if the folder name in `webapps` matches the URL.
- **500 Internal Server Error**: Check the Tomcat logs or the browser console for Java errors (often database connection issues).
- **Database Connection Error**: Ensure MySQL is running and the username/password in `DBConnection.java` are correct.

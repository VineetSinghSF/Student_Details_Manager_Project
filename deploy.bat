@echo off
setlocal

set "PROJECT_ROOT=%~dp0"
set "TOMCAT_HOME=D:\Student-Details-Java-Project\apache-tomcat-9.0.112"
set "WEBAPP_NAME=StudentDetails"
set "DEPLOY_DIR=%TOMCAT_HOME%\webapps\%WEBAPP_NAME%"
set "SOURCE_DIR=%PROJECT_ROOT%src"
set "OUTPUT_DIR=%PROJECT_ROOT%WebContent\WEB-INF\classes"
set "CLASSPATH=.;%TOMCAT_HOME%\lib\servlet-api.jar"

echo ==========================================
echo Student Details Manager - Build and Deploy
echo ==========================================

echo [1/4] Cleaning and preparing output directory...
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo [2/4] Compiling Java source files...
echo Generating source file list...
powershell -Command "Get-ChildItem -Recurse '%SOURCE_DIR%' -Filter *.java | ForEach-Object { '\"' + $_.FullName.Replace('\', '/') + '\"' } | Out-File -Encoding ASCII sources.txt"
javac -cp "%CLASSPATH%" -d "%OUTPUT_DIR%" @sources.txt
set BUILD_STATUS=%ERRORLEVEL%
if %BUILD_STATUS% NEQ 0 (
    echo.
    echo [ERROR] Compilation failed!
    echo Content of sources.txt:
    type sources.txt
    del sources.txt
    pause
    exit /b %BUILD_STATUS%
)
del sources.txt

if %BUILD_STATUS% NEQ 0 (
    echo.
    echo [ERROR] Compilation failed! Please check the errors above.
    pause
    exit /b %BUILD_STATUS%
)

echo [3/4] Removing old deployment...
if exist "%DEPLOY_DIR%" (
    rmdir /s /q "%DEPLOY_DIR%"
)

echo [4/4] Deploying to Tomcat...
xcopy /s /e /y "%PROJECT_ROOT%WebContent\*" "%DEPLOY_DIR%\"

echo.
echo ==========================================
echo Build and Deployment Successful!
echo ==========================================
echo.
echo To run the application:
echo 1. Go to %TOMCAT_HOME%\bin
echo 2. Run startup.bat
echo.
echo Access the application at:
echo http://localhost:8081/%WEBAPP_NAME%/
echo.

endlocal
pause


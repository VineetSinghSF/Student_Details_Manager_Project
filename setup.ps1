# Student Details Manager - Automated Setup Script

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$projectRoot = Get-Location
$tomcatUrl = "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.112/bin/apache-tomcat-9.0.112.zip"
$tomcatZip = "tomcat.zip"
$tomcatDirName = "apache-tomcat-9.0.112"
$tomcatHome = Join-Path $projectRoot $tomcatDirName

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Student Details Manager - Auto Setup   " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Download Tomcat
if (-not (Test-Path $tomcatHome)) {
    Write-Host "`n[1/6] Downloading Apache Tomcat 9..." -ForegroundColor Yellow
    Import-Module BitsTransfer
    Start-BitsTransfer -Source $tomcatUrl -Destination $tomcatZip -DisplayName "Downloading Tomcat"
    
    # 2. Extract Tomcat
    Write-Host "[2/6] Extracting Tomcat..." -ForegroundColor Yellow
    Expand-Archive -Path $tomcatZip -DestinationPath $projectRoot -Force
    Remove-Item $tomcatZip
}
else {
    Write-Host "`n[1-2/6] Tomcat already exists. Skipping download." -ForegroundColor Green
}

# 2.5 Configure Tomcat Port (8081)
Write-Host "[2.5/6] Configuring Tomcat Port to 8081..." -ForegroundColor Yellow
$serverXml = Join-Path $tomcatHome "conf\server.xml"
if (Test-Path $serverXml) {
    $xmlContent = Get-Content $serverXml -Raw
    # Replace the Connector port
    $xmlContent = $xmlContent -replace 'port="8080"', 'port="8081"'
    Set-Content -Path $serverXml -Value $xmlContent
}

# 3. Ask for MySQL Password
Write-Host "`n[3/6] Database Configuration" -ForegroundColor Yellow
$mysqlPass = Read-Host "Enter your MySQL 'root' password (leave empty if none)"

# 4. Update DBConnection.java
Write-Host "[4/6] Updating DBConnection.java..." -ForegroundColor Yellow
$dbFile = Join-Path $projectRoot "src\com\student\util\DBConnection.java"
$dbContent = Get-Content $dbFile -Raw
# Regex to replace the password field
$dbContent = $dbContent -replace 'private static final String PASSWORD = ".*";', "private static final String PASSWORD = `"$mysqlPass`";"
Set-Content -Path $dbFile -Value $dbContent

# 5. Update and Run deploy.bat
Write-Host "[5/6] Updating and Running deploy.bat..." -ForegroundColor Yellow
$deployFile = Join-Path $projectRoot "deploy.bat"
$deployContent = Get-Content $deployFile -Raw
# Update TOMCAT_HOME to the new local path
$deployContent = $deployContent -replace 'set "TOMCAT_HOME=.*"', "set `"TOMCAT_HOME=$tomcatHome`""
Set-Content -Path $deployFile -Value $deployContent

# Run deploy.bat
Start-Process -FilePath "cmd.exe" -ArgumentList "/c deploy.bat" -Wait -NoNewWindow

# 6. Start Tomcat and Open Website
Write-Host "`n[6/6] Starting Server and Opening Browser..." -ForegroundColor Yellow
$startupBat = Join-Path $tomcatHome "bin\startup.bat"

# Start Tomcat in a new window
Start-Process -FilePath $startupBat

# Wait a bit for Tomcat to start
Write-Host "Waiting 5 seconds for server to initialize..."
Start-Sleep -Seconds 5

# Open Browser
Start-Process "http://localhost:8081/StudentDetails/list"

Write-Host "`nSuccess! Your application should be running now." -ForegroundColor Green
Write-Host "Note: If port 8081 is busy, Tomcat might fail to start. Check the Tomcat window."

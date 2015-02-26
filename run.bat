@ECHO OFF
setlocal

REM Start a JBoss Data Virtualization and JBoss Fuse environment.
REM 
REM This script expects JBoss Fuse to be running in order to start the shopping application
REM
REM author: ankit.b.verma@accenture.com
REM

set PROJECT_HOME=%~dp0
set FUSE_DIR=%PROJECT_HOME%target\fuse\jboss-fuse-6.1.1.redhat-412
set DV_DIR=%PROJECT_HOME%target\dv\jboss-eap-6.1
set KARAF_LOG=%FUSE_DIR%\data\log\fuse.log

if exist "%KARAF_LOG%" (
	del %KARAF_LOG%
)

call "%FUSE_DIR%\bin\start.bat"

echo Starting JBoss Fuse and wait for 60 seconds
echo.

timeout 60 /nobreak

echo.
echo Starting JBoss Data Virtualization
echo.

start "" "%DV_DIR%\bin\standalone.bat"

	call mvn -f "%PROJECT_HOME%\projects\shopping-demo-application\pom.xml" clean install -DskipTests

	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s war:mvn:com.redhat/application-interface/1.0.0-SNAPSHOT/war?Web-ContextPath=shoppingApplication"
	
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install  -s wrap:mvn:mysql/mysql-connector-java/5.0.5"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-sql"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-twitter"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install  camel-jackson"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-salesforce"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin"    "osgi:install -s wrap:file://$DV_DIR/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar"
	
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin"    "osgi:install -s wrap:mvn:com.redhat/application/1.0.0-SNAPSHOT"
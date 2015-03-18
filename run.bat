@echo OFF
setlocal

REM Start a JBoss Data Virtualization and JBoss Fuse environment.
REM
REM This script expects JBoss Fuse to be running in order to start the shopping application
REM
REM author: ankit.b.verma@accenture.com
REM

set PROJECT_HOME=%~dp0
set DV_DIR=%PROJECT_HOME%target\dv
set SERVER_CONF_DV=%DV_DIR%\standalone\configuration\
set DV_DIR_OSGI=%DV_DIR:\=/%
set SUPPORT_DIR=%PROJECT_HOME%support
set DV_SUPPORT_DIR=%SUPPORT_DIR%\dv-support
set FUSE_SUPPORT_DIR=%SUPPORT_DIR%\fuse-support



del %DV_DIR%\standalone\deployments\shoppingApplication*.war*

echo.
echo Starting JBoss Data Virtualization
echo.
start call %DV_DIR%\bin\standalone  -Dkaraf.home="%SERVER_CONF_DV%"


:start
echo Choose the environment you wish to deploy the application...
echo
echo 1) Eap  6.1.0-Beta
echo 2) Fuse 6.2
echo 3) Fuse 6.1
set /p choice= Enter Your Choice (1,2,3)?
if '%choice%'=='' echo "%choice%" is not valid please try again
if '%choice%'=='1' goto eap
if '%choice%'=='2' goto fuse6_2
if '%choice%'=='3' goto fuse6_1
echo.
goto start



:eap

echo.
echo  - install application properties files...
echo.

mkdir %SERVER_CONF_DV%etc
xcopy /Y /Q "%DV_SUPPORT_DIR%\application.properties" "%SERVER_CONF_DV%"
set ENVIRONMENT="eap"
goto eapDeployment
:fuse6_2

set ENVIRONMENT="fuse6.2"
echo.
echo  - install application properties files...
echo.
set FUSE_DIR=%PROJECT_HOME%target\fuse\jboss-fuse-6.1.1.redhat-412
set SERVER_CONF_FUSE=%FUSE_DIR%\etc\
set KARAF_LOG=%FUSE_DIR%\data\log\fuse.log
goto fuseDeployment



:fuse6_1

set ENVIRONMENT="fuse6.1"
echo.
echo  - install application properties files...
echo.
set FUSE_DIR=%PROJECT_HOME%target\fuse\jboss-fuse-6.1.1.redhat-412
set SERVER_CONF_FUSE=%FUSE_DIR%\etc\
set KARAF_LOG=%FUSE_DIR%\data\log\fuse.log
goto fuseDeployment


:fuseDeployment
(	if exist "%KARAF_LOG%" (
			del %KARAF_LOG_6-1%
		)


echo  - enabling application properties file...
echo.
xcopy /Y /Q "%FUSE_SUPPORT_DIR%\application.properties" "%SERVER_CONF_FUSE%"
echo.


start call %FUSE_DIR%\bin\fuse


echo Starting JBoss Fuse and wait for 60 seconds
echo.

timeout 60 /nobreak
call mvn -f "%PROJECT_HOME%\projects\shopping-demo-application\pom.%ENVIRONMENT%.xml" clean install -DskipTests

	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s war:mvn:com.redhat/application-interface/1.0.0-SNAPSHOT/war?Web-ContextPath=shoppingApplication"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s wrap:mvn:commons-dbcp/commons-dbcp/1.4"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-sql"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-twitter"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install  camel-jackson"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"features:install camel-salesforce"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin"   "osgi:install -s wrap:file:%DV_DIR_OSGI%/dataVirtualization/jdbc/teiid-8.7.1.redhat-5-jdbc.jar"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s mvn:com.redhat/applicationCommon"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" 	"osgi:install -s mvn:com.redhat/application"
)
GOTO :EOF

:eapDeployment
(
	call mvn -f "%PROJECT_HOME%\projects\shopping-demo-application\pom.%ENVIRONMENT%.xml" clean install -DskipTests
	xcopy /Y /Q "%PROJECT_HOME%\projects\shopping-demo-application\application-interface\target\shoppingApplication.war" "%DV_DIR%\standalone\deployments"
	xcopy /Y /Q "%PROJECT_HOME%\projects\shopping-demo-application\applicationEap\target\shoppingApplicationRest.war" "%DV_DIR%\standalone\deployments"
)

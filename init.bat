@ECHO OFF
setlocal
REM Please ensure to edit the software version names

set FUSE_VERSION=6.2.0.redhat-133
set DV_VERSION=6.1.0.Beta-redhat-1
set AMQ-VERSION=6.1.0.redhat-379

REM


REM Setting Variabbles Start

set PROJECT_HOME=%~dp0
set DEMO=Fuse API Best Practices:Shopping Application Demo
set AUTHORS=Accenture-Ankit Verma
set PROJECT=https://github.com/jbossdemocentral/fuse-dv-shopping-integration-demo.git
set PRODUCT=Fuse API Best Practices:Shopping Application Demo

REM Set Server Configuration Varaibles
set JBOSS_HOME_DV=%PROJECT_HOME%target\dv
set JBOSS_HOME_FUSE=%PROJECT_HOME%target\jboss-fuse-%FUSE_VERSION%
set JBOSS_HOME_AMQ=%PROJECT_HOME%target\jboss-a-mq-%AMQ-VERSION%
set SERVER_CONF_DV=%JBOSS_HOME_DV%\standalone\configuration\
set SERVER_CONF_FUSE=%JBOSS_HOME_FUSE%\etc\
set SERVER_CONF_AMQ=%JBOSS_HOME_AMQ%\etc\


REM Set Support Names
set SRC_DIR=%PROJECT_HOME%software
set SUPPORT_DIR=%PROJECT_HOME%support
set DV_SUPPORT_DIR=%SUPPORT_DIR%\dv-support
set FUSE_SUPPORT_DIR=%SUPPORT_DIR%\fuse-support
set AMQ_SUPPORT_DIR=%SUPPORT_DIR%\amq-support
set PRJ_DIR=%PROJECT_HOME%projects

REM Set Installer Complete Names
set FUSE=jboss-fuse-full-%FUSE_VERSION%.zip
set DV=jboss-dv-installer-%DV_VERSION%.jar
set AMQ=jboss-a-mq-%AMQ-VERSION%.zip

REM Setting Variables END

REM wipe screen.
cls


REM MESSAGE AUTHOR
echo.
echo Setting up the %DEMO%
echo.
echo brought to you by,
echo   %AUTHORS%
echo.
echo   %PROJECT%
echo.


REM double check for maven
call where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Maven is required but not installed yet. aborting.
	GOTO :EOF
)


REM make some checks first before proceeding. Checking FOR DV Installer
if exist "%SRC_DIR%\%DV%" (
        echo JBoss product sources, %DV% is present...
        echo.
) else (
        echo Need to download %DV% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)



REM Remove JBoss product installation if exists.
if exist "%PROJECT_HOME%\target" (
	echo - existing JBoss product install detected...
	echo.
	echo - removing existing JBoss product installation...
	echo.

	rmdir /s /q "%PROJECT_HOME%\target"
)


REM DV Installation
echo Starting DV Install. Press any key or wait 5 seconds
timeout 5
echo.
echo Product installer running now...
echo.
call java -jar %SRC_DIR%\%DV% %DV_SUPPORT_DIR%\InstallationScript.xml
if not "%ERRORLEVEL%" == "0" (
	echo Error Occurred During DV Installation!
	echo.
	GOTO :EOF
)
echo Post DV install configuration. Press any key or wait 5 seconds
timeout 30




REM FUSE INSTALLATION
if exist "%SRC_DIR%\%FUSE%" (
        echo JBoss product sources, %FUSE% is present...
        echo.

				if exist "%PROJECT_HOME%\target" (
					REM Unzip the JBoss Fuse instance
					echo Unpacking JBoss FUSE %VERSION%...
					echo.
					cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%SRC_DIR%\%FUSE%" "%PROJECT_HOME%\target"

					if not "%ERRORLEVEL%" == "0" (
						echo Error Occurred During Installation!
						echo.
						GOTO :EOF
					)

				) else (
					echo.
					echo Missing target directory, stopping installation.
					echo.
					GOTO :EOF
				)


				echo  - enabling demo accounts logins in users.properties file...
				echo.
				xcopy /Y /Q "%FUSE_SUPPORT_DIR%\users.properties" "%SERVER_CONF_FUSE%"
				echo.

) else (
        echo Need to download %FUSE% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to validate in fuse...
)
REM FUSE Installation END


REM AMQ Installation Start
echo Installing AMQ Server
if exist "%SRC_DIR%\%AMQ%" (
        echo JBoss product sources, %AMQ% is present...
        echo.

				if exist "%PROJECT_HOME%\target" (
					REM Unzip the JBoss AMQ instance
					echo Unpacking JBoss AMQ %VERSION%...
					echo.
					cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%SRC_DIR%\%AMQ%" "%PROJECT_HOME%\target\"
					
					if not "%ERRORLEVEL%" == "0" (
						echo Error Occurred During Installation!
						echo.
						GOTO :EOF
					)

				) else (
					echo.
					echo Missing target directory, stopping installation.
					echo.
					GOTO :EOF
				)


				echo  - enabling demo accounts logins in users.properties file...
				echo.
				xcopy /Y /Q "%AMQ_SUPPORT_DIR%\users.properties" "%SERVER_CONF_AMQ%"
				echo.
				
				echo  - enabling standalone xml with amq enabled...
				echo.
				xcopy /Y /Q "%AMQ_SUPPORT_DIR%\standalone.dv.xml" "%SERVER_CONF_DV%\standalone.xml"
				echo.
				
				echo  - active mq deployment in progress...
				echo.
				cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%JBOSS_HOME_AMQ%\extras\apache-activemq-5.9.0.redhat-610379-bin.zip" "%PROJECT_HOME%\target\"
				xcopy /Y /Q %PROJECT_HOME%\target\apache-activemq-5.9.0.redhat-610379\lib\optional\activemq-rar-5.9.0.redhat-610379.rar %JBOSS_HOME_DV%\standalone\deployments\activemq-rar.rar
				echo.

) else (
        echo Need to download %AMQ% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed for running the application in EAP...
		
		        
        echo   - setting up default dv standalone.xml configuration adjustments without active mq Configurations...
		echo.
		xcopy /Y /Q "%DV_SUPPORT_DIR%\standalone.dv.xml" "%SERVER_CONF_DV%\standalone.xml"
		REM DV Configuration END
)
REM AMQ Installation END


	
	REM DV Configuration Start
	echo Installing DV Server and adding application properties in it
	echo.
	echo  - install teiid security files...
	echo.
	xcopy /Y /Q /S "%DV_SUPPORT_DIR%\teiid*" "%SERVER_CONF_DV%"
	
	echo.
	echo   - move modules...
	echo.
	xcopy /Y /Q /S "%DV_SUPPORT_DIR%\modules\*" "%JBOSS_HOME_DV%\modules"
	
	echo.
	echo   - move virtual database...
	echo.
	xcopy /Y /Q "%DV_SUPPORT_DIR%\vdb" "%JBOSS_HOME_DV%\standalone\deployments"




REM Renaming the Server Names to Make them Generic
rename %JBOSS_HOME_FUSE% fuse
rename %JBOSS_HOME_AMQ%  amq



REM Final instructions to user to start and run demo.
echo.
echo See Readme for any additional steps
echo %DEMO% Setup Complete.
echo.

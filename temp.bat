Please download the active mq version for
set AMQ = jboss-a-mq-6.2.0.redhat-133.zip
set AMQ_HOME=%PROJECT_HOME%target\amq\jboss-a-mq-6.2.0.redhat-133

REM Unzipping Active MQ Server


if exist "%SRC_DIR%\%AMQ%" (
        echo JBoss product sources, %AMQ% is present...
        echo.

				if exist "%PROJECT_HOME%\target" (

					md "%PROJECT_HOME%\target\amq"
					REM Unzip the JBoss AMQ instance
					echo Unpacking JBoss AMQ %VERSION%...
					echo.
					cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%SRC_DIR%\%AMQ%" "%PROJECT_HOME%\target\amq"

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
				xcopy /Y /Q "%AMQ_SUPPORT_DIR%\users.properties" "%SERVER_CONF_FUSE%"
				echo.

) else (
        echo Need to download %FUSE% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo Installing DV Server and adding application properties in it

)



cscript /nologo "%SUPPORT_DIR%\unzip.vbs"  "%SRC_DIR%\%AMQ%"  %PROJECT_HOME%target\amq
echo Extracting Active Mq Files to the target folder
timeout 30


REM Unzipping active mq component for dv installer
cscript /nologo "%SUPPORT_DIR%\unzip.vbs" AMQ_HOME\extras\apache-activemq-5.11.0.redhat-620133--bin.zip "%PROJECT_HOME%\target\fuse"
cd apache-activemq-5.11.0.redhat-620133/lib/optional
cp activemq-rar-5.9.0.redhat-610379.rar activemq-rar.rar

cp activemq-rar.rar EAPInstallDir/standalone/deployments/

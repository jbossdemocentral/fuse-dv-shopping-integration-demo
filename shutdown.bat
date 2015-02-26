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


call "%FUSE_DIR%\bin\stop.bat"
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

REM Renaming the Server Names to Make them Generic

cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%JBOSS_HOME_AMQ%\extras\apache-activemq-5.9.0.redhat-610379-bin.zip" "%PROJECT_HOME%\target\"



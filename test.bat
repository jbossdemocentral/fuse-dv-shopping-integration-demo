@ECHO OFF
set "h=Hello-World"
set ENVIRONMENT=fuse6.1
set "f=%ENVIRONMENT%"
echo %h% %f%
call set "a=%%h:%f%=%%"
if not "%a%"=="%f%" goto :done
pause
exit /b
:done
echo it matched
pause

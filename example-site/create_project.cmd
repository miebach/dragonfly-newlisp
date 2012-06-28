@echo off

rem set dragonfly base dir:
SET DFBASE=%~dp0

echo Base dir: %DFBASE%

rem go to the base dir:
cd /d "%~dp0"

rem Get directory for new project from user:
set /p PROOT="Enter the directory, where you would like to create the new project:"
echo %PROOT%

rem make sure it does not yet exist:
IF NOT EXIST %PROOT% GOTO OK_NOT_EXIST
echo %PROOT% already exists, please choose a different directory.
goto ENDERR

:OK_NOT_EXIST
rem now create the new directory:
md %PROOT%

rem anc check that it exists:
IF EXIST %PROOT% GOTO OK_EXIST 
echo %PROOT% could not be created
GOTO ENDERR

:OK_EXIST

call:COPY_FILE index.cgi 
call:COPY_FILE newlispServerWin.bat

call:CREATE_LINK dragonfly-api 

md %PROOT%\dragonfly-framework
call:COPY_FILE dragonfly-framework\config.lsp 
call:COPY_FILE dragonfly-framework\dragonfly.lsp 
call:COPY_FILE dragonfly-framework\newlisp-redirection.lsp 

call:CREATE_LINK dragonfly-framework\lib
call:CREATE_LINK dragonfly-framework\plugins-active
call:CREATE_LINK dragonfly-framework\plugins-inactive

md %PROOT%\databases
md %PROOT%\includes
md %PROOT%\includes\css
md %PROOT%\includes\images
md %PROOT%\includes\js

md %PROOT%\views
md %PROOT%\views\partials
call:COPY_FILE \views\500.html 
call:COPY_FILE \views\404.html 
call:COPY_FILE_RENAME \views\empty.html \views\welcome.html

goto EXIT

rem == FUNCTIONS ==

:CREATE_LINK
mklink /J %PROOT%\%1 %DFBASE%%1 
GOTO:EOF

:COPY_FILE
copy %DFBASE%%1 %PROOT%\%1 
GOTO:EOF

:COPY_FILE_RENAME
copy %DFBASE%%1 %PROOT%\%2 
GOTO:EOF


rem == EXIT ==

:ENDERR


:EXIT
pause

  
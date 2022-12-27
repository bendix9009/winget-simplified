@echo off
:reboot
title Winget Simplified - Press Ctrl + C to cancel anytime.
color 02
:: STARTs THE SCRIPT
cls
goto check_Permissions
exit

:: Checks if the script run with admin permissions
:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto boottext
    ) else (
        goto noperms
    )
    pause >nul
pause
exit

:: No permisssion message
:noperms
color 6
cls
echo ###########################################################
echo #
echo # Important: Winget needs administrator permissions to 
echo # run the most upgrade or installation processes. Sorry about that.
echo # Try to close and right-click this file, than choose: "Run as administrator"
echo #
echo ###########################################################
pause
exit

:wronginput
color a
cls
echo Please enter a valid input. Try again
echo -- --- --
timeout 5
goto start
exit

::Starting real script if permission check is succesful
:boottext
color 9
cls
echo ###########################################################
echo #
echo # You can use the Winget feature without this script.
echo # It just makes it more easier without the need of knowing
echo # the commands or attributes. Have a nice day!
echo #
echo ###########################################################
timeout 5
goto start
::Just in case i want to add smthg later..
:start
color f
cls
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
echo [1] Install - Install applications by name
echo [2] Upgrade - Automaticly search and run available updates 
echo [3] Uninstall - Removes applications by name
echo [4] List - List all installed applications
echo -- --- -- --- -- --- -- --- --
set /p mainmenu=Enter a valid number: 
if %mainmenu%==1 goto main1
if %mainmenu%==2 goto main2
if %mainmenu%==3 goto main3
if %mainmenu%==4 goto main4
goto wronginput
exit

::Mainmenu Install
:main1
cls
::Install or Search
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
echo [1] Search the right application
echo [2] Install directly by ID
echo -- --- -- --- -- --- -- --- --
set /p installmenu=Enter a valid number: 
if %installmenu%==1 goto installmenu1
if %installmenu%==2 goto installmenu2
goto wronginput
:installmenu1
cls
::Search query
echo Winget Search
echo -- --- -- --- -- --- -- --- --
set /p search=Please enter your search query: 
winget search "%search%"
echo -- --- -- --- -- --- -- --- --
:installmenu2
set /p installbyID=Please enter the application ID you want to install: 
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
echo [1] With GUI 
echo [2] Install silent (May not always work)
echo -- --- -- --- -- --- -- --- --
set /p silent=Enter a valid numer:
::Silent or GUI
if %silent%==2 goto installsilent
if %silent%==1 goto installgui
goto wronginput
:installsilent
winget install "%installbyID%" --silent
goto installdone
exit
:installgui
winget install "%installbyID%"
goto installdone
exit
::DONE MESSAGE DONE MESSAGE DONE MESSAGE DONE MESSAGE 
:installdone
echo -- --- -- --- -- --- -- --- --
echo Unfortunately, the application can not read the winget responses. In the best case, the action is now complete.
echo -- --- -- --- -- --- -- --- --
pause
goto start


::Mainmenu Upgrade 
:main2
cls
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
echo [1] Search and upgrade all
echo [2] Upgrade by name
echo -- --- -- --- -- --- -- --- --
set /p upgrademenu=Enter a valid number: 
if %upgrademenu%==1 goto upgrademenu1
if %upgrademenu%==2 goto upgrademenu2
goto wronginput
:upgrademenu1
cls
winget upgrade
set /p confirm=Do you want to upgrade all? (yes or ID): 
if %confirm%==yes goto upgradeyes
winget upgrade %confirm% --silent
goto installdone
:upgradeyes
cls
winget upgrade --all --silent
goto installdone


::Mainmenu Uninstall
:main3
cls
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
echo Generating application list...
winget list
set /p confirm=Enter Programm Name or ID to uninstall. Type "cancel" to cancel.: 
cls
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
if %confirm%==cancel goto start
winget uninstall "%confirm%" --silent
goto installdone






::Mainmenu List
:main4
cls
echo Winget Simplified
echo -- --- -- --- -- --- -- --- --
winget list
echo -- --- -- --- -- --- -- --- --
pause
goto start













::Backup message if smthg went wrong
cls
color 4
echo You are not supposed to see this, but
echo somehow the script reached the end...
echo -
timeout 15
goto reboot
pause
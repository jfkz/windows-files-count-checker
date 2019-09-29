@echo off
setlocal ENABLEEXTENSIONS

rem msg * "Enter Your Message"
rem start "" /wait cmd /c "echo Hello world!&echo(&pause"


for /f %%i in ('call ini.cmd /s Main /i Directory config.ini') do (
    set dirname=%%i
)
for /f %%i in ('call ini.cmd /s Main /i Count config.ini') do (
    set minfilecount=%%i
)
for /f %%i in ('call ini.cmd /s Main /i Mask config.ini') do (
    set mask=%%i
)
for /f %%i in ('call ini.cmd /s Main /i Timeout config.ini') do (
    set timetowait=%%i
)
set "dirandmask=%dirname%\%mask%"
set filecount=%minfilecount%

:counter
set count=0
echo Checking...
for %%x in (%dirandmask%) do set /a count+=1
echo Found %count% files
goto condition

:timer
echo Waiting %timetowait% sec
timeout /t %timetowait%
goto counter

:condition
if %count% gtr %filecount% (
   set filecount=%count%
   goto showmessage
) else (
   rem We have to reset filecount if they are less then original
   if %count% lss %minfilecount% (
      set filecount=%minfilecount%
   )
   echo Filecount not reached
)
goto timer

:showmessage
msg * "There is %count% files w/ mask %mask% in %dirname%"
goto timer

@echo on
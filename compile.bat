@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
color 0f
echo Modified Makefile, compile.bat and clean.bat by : Daniel

:detect
SET "bannertoolFile=Not Found"
IF EXIST "bannertool.exe" SET "bannertoolFile=Found"

SET "ctrtoolFile=Not Found"
IF EXIST "ctrtool.exe" SET "ctrtoolFile=Found"

SET "makeromFile=Not Found"
IF EXIST "makerom.exe" SET "makeromFile=Found"

SET "devkitProFile=Not Found"
IF EXIST "C:\devkitPro" SET "devkitProFile=Found"

SET "cgfxFile=Not Found"
IF EXIST "app\banner.cgfx" SET "cgfxFile=Found"

SET "pngFile=Not Found"
IF EXIST "app\banner.png" SET "pngFile=Found"

SET "iconFile=Not Found"
IF EXIST "app\Icon.png" SET "iconFile=Found"

SET "audioFile=Not Found"
IF EXIST "app\BannerAudio.wav" SET "audioFile=Found"

SET "neededfiles=found"
SET "banners=notfound"
IF "%pngFile%" == "Found" SET "banners=found"
IF "%cgfxFile%" == "Found" SET "banners=found"

:SecondDetect
IF "%bannertoolFile%" == "Not Found" SET "neededfiles=notfound"
IF "%ctrtoolFile%" == "Not Found" SET "neededfiles=notfound"
IF "%makeromFile%" == "Not Found" SET "neededfiles=notfound"
IF "%devkitProFile%" == "Not Found" SET "neededfiles=notfound"
IF "%iconFile%" == "Not Found" SET "neededfiles=notfound"
IF "%audioFile%" == "Not Found" SET "neededfiles=notfound"
IF "%banners%" == "notfound" SET "neededfiles=notfound"

IF "%neededfiles%" == "notfound" goto :badend
IF "%neededfiles%" == "found" goto :next

:badend
echo.
IF "%bannertoolFile%" == "Not Found" echo "bannertool.exe" could not be found. make sure is in same place as "compile.bat".
echo.
IF "%ctrtoolFile%" == "Not Found" echo "ctrtool.exe" could not be found. make sure is in same place as "compile.bat".
echo.
IF "%makeromFile%" == "Not Found" echo "makerom.exe" could not be found. make sure is in same place as "compile.bat".
echo.
IF "%devkitProFile%" == "Not Found" echo devkitPro ins't installed. make sure to download and install lastest version of it.
echo.
IF "%iconFile%" == "Not Found" echo "Icon.png" could not be found. make sure is on the "app" folder.
echo.
IF "%audioFile%" == "Not Found" echo "BannerAudio.wav" could not be found. make sure is on the "app" folder.
echo.
IF "%banners%" == "notfound" echo an "banner.png" or "banner.cgfx" could not be found. make sure to have at least one of them on the "app" folder.
echo.
pause
exit

:next
echo.
call :ColorText 0e "------------------=[BannerTool GUI]=------------------"
echo.
call :ColorText 0e "Specify the following info for icon.bin and TWiLight_Menu++_Launcher.smdh"
:chooseciainfo
echo.
SET /p "CIA_NAME=Name of the .cia : "
IF "%CIA_NAME%" == "" goto :wrongselect
SET /p "CIA_DESCRIPTION=Description of the .cia : "
IF "%CIA_DESCRIPTION%" == "" goto :wrongselect
SET /p "CIA_AUTHOR=Creator(s) of the .cia : "
IF "%CIA_AUTHOR%" == "" goto :wrongselect

echo.
call :ColorText 0e "------------------=[BannerTool GUI]=------------------"
echo.
echo CIA Name : %CIA_NAME%
echo CIA Description : %CIA_DESCRIPTION%
echo CIA Creator(s) : %CIA_AUTHOR%
echo.
:select
SET /p "CHOICE=Is this info correct? (y: yes, n: no) "
IF [%CHOICE%]==[y] goto :nextversion
IF [%CHOICE%]==[n] SET CIA_NAME=
IF [%CHOICE%]==[n] SET CIA_DESCRIPTION=
IF [%CHOICE%]==[n] SET CIA_AUTHOR=
IF [%CHOICE%]==[n] goto :next
echo.
call :ColorText 0c "Error"
echo Invalid option, Select an valid option.
echo.
goto :select

:wrongselect
SET CIA_NAME=
SET CIA_DESCRIPTION=
SET CIA_AUTHOR=
echo.
call :ColorText 0c "Error"
echo You need to type something! (It doesn't matter what)
goto :chooseciainfo

:nextversion
echo.
call :ColorText 0e "------------------=[BannerTool GUI]=------------------"
echo.
call :ColorText 0e "Specify the following info for the CIA version"

:chooseverinfo
echo.
SET /p "VERSION_MAJOR=First number version O.x.x : (Please, only insert one number) "
IF "%VERSION_MAJOR%" == "" goto :wrongverselect
SET /p "VERSION_MINOR=Second number version x.O.x : (Please, only insert one number) "
IF "%VERSION_MINOR%" == "" goto :wrongverselect
SET /p "VERSION_MICRO=Third number version x.x.O : (Please, only insert one number) "
IF "%VERSION_MICRO%" == "" goto :wrongverselect

echo.
call :ColorText 0e "------------------=[BannerTool GUI]=------------------"
echo.
echo CIA's version : %VERSION_MAJOR%.%VERSION_MINOR%.%VERSION_MICRO%
echo.
:selectVER
SET /p "CHOICE=Is this info correct? (y: yes, n: no) "
IF [%CHOICE%]==[y] goto :secondnext
IF [%CHOICE%]==[n] SET VERSION_MAJOR=
IF [%CHOICE%]==[n] SET VERSION_MINOR=
IF [%CHOICE%]==[n] SET VERSION_MICRO=
IF [%CHOICE%]==[n] goto :nextversion
echo.
call :ColorText 0c "Error"
echo Invalid option, Select an valid option.
echo.
goto :selectVER

:wrongverselect
SET VERSION_MAJOR=
SET VERSION_MINOR=
SET VERSION_MICRO=
echo.
call :ColorText 0c "Error"

echo You need to insert an number!

goto :chooseverinfo

:secondnext
md "C:\devkitPro\libctru_backup"
md "C:\devkitPro\libctru_modified"
md "C:\devkitPro\libctru_modified\include"
md "C:\devkitPro\libctru_modified\lib"
xcopy /e /v "programs\include" "C:\devkitPro\libctru_modified\include"
xcopy /e /v "programs\lib" "C:\devkitPro\libctru_modified\lib"
move /y "C:\devkitPro\libctru\lib" ""C:\devkitPro\libctru_backup\lib"
move /y "C:\devkitPro\libctru\include" ""C:\devkitPro\libctru_backup\include"
move /y "C:\devkitPro\libctru_modified\lib" ""C:\devkitPro\libctru\lib"
move /y "C:\devkitPro\libctru_modified\include" ""C:\devkitPro\libctru\include"

bannertool.exe makebanner -ci "app/banner.cgfx" -a "app/BannerAudio.wav" -o "app/banner.bin"
IF "%cgfxFile%" == "Found" bannertool.exe makebanner -i "app/banner.png" -a "app/BannerAudio.wav" -o "app/png_banner.bin"
IF "%cgfxFile%" == "Not Found" bannertool.exe makebanner -i "app/banner.png" -a "app/BannerAudio.wav" -o "app/banner.bin"
bannertool.exe makesmdh -i "app/icon.png" -s "%CIA_NAME%" -l "%CIA_DESCRIPTION%" -p "%CIA_AUTHOR%" -o "app/icon.bin"

copy "app\icon.bin"
move /y icon.bin TWiLight_Menu++_Launcher.smdh
goto :makethecia

:ColorText
echo off
echo %DEL% > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

:makethecia
make
move /y "C:\devkitPro\libctru\lib" ""C:\devkitPro\libctru_modified\lib"
move /y "C:\devkitPro\libctru\include" ""C:\devkitPro\libctru_modified\include"
move /y "C:\devkitPro\libctru_backup\lib" ""C:\devkitPro\libctru\lib"
move /y "C:\devkitPro\libctru_backup\include" ""C:\devkitPro\libctru\include"
rd "C:\devkitPro\libctru_backup"
rd /S /Q "C:\devkitPro\libctru_modified"
pause
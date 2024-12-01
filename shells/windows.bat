@echo off
setlocal EnableDelayedExpansion

:: Version configuration
set CHROME_VERSION=131.0.6778.85
set BASE_URL=https://storage.googleapis.com/chrome-for-testing-public

:: Detect architecture
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set CHROME_ARCH=win64
) else (
    set CHROME_ARCH=win32
)

echo Starting setup script...

:: Create utils directory if it doesn't exist
if not exist "utils" mkdir utils

:: Download and install Chrome
echo Downloading Google Chrome...
powershell -Command "& {Invoke-WebRequest -Uri '%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chrome-%CHROME_ARCH%.zip' -OutFile 'chrome-%CHROME_ARCH%.zip'}"
powershell -Command "& {Expand-Archive -Path 'chrome-%CHROME_ARCH%.zip' -DestinationPath '.' -Force}"

:: Move Chrome files
echo Installing Chrome...
xcopy /E /I /Y "chrome-%CHROME_ARCH%\*" "utils\"

:: Cleanup Chrome files
del /F /Q "chrome-%CHROME_ARCH%.zip"
rmdir /S /Q "chrome-%CHROME_ARCH%"

:: Download and install Chromedriver
echo Downloading Chromedriver...
powershell -Command "& {Invoke-WebRequest -Uri '%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chromedriver-%CHROME_ARCH%.zip' -OutFile 'chromedriver-%CHROME_ARCH%.zip'}"
powershell -Command "& {Expand-Archive -Path 'chromedriver-%CHROME_ARCH%.zip' -DestinationPath '.' -Force}"

:: Move Chromedriver files
echo Installing Chromedriver...
xcopy /Y "chromedriver-%CHROME_ARCH%\chromedriver.exe" "utils\"

:: Cleanup Chromedriver files
del /F /Q "chromedriver-%CHROME_ARCH%.zip"
rmdir /S /Q "chromedriver-%CHROME_ARCH%"

:: Add utils to PATH
echo Adding utils directory to PATH...
setx PATH "%CD%\utils;%PATH%"

echo Setup completed successfully!
echo Please restart your terminal for PATH changes to take effect.

endlocal
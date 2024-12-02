@echo off
setlocal EnableDelayedExpansion

:: Version configuration
set CHROME_VERSION=131.0.6778.85
set BASE_URL=https://storage.googleapis.com/chrome-for-testing-public

:: Detect architecture
wmic os get osarchitecture | find "64" > nul
if %errorlevel% equ 0 (
    set "CHROME_ARCH=win64"
    echo Sistema detectado: 64-bit Windows
) else (
    set "CHROME_ARCH=win32"
    echo Sistema detectado: 32-bit Windows
)

echo Starting setup script...

:: Create utils directory if it doesn't exist
if not exist "utils" mkdir utils

:: Download and install Chrome
echo Downloading Google Chrome...
where curl.exe >nul 2>&1
if %errorlevel% equ 0 (
    curl.exe --location --output "chrome-%CHROME_ARCH%.zip" "%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chrome-%CHROME_ARCH%.zip"
    if %errorlevel% neq 0 goto :download_error
) else (
    bitsadmin /transfer ChromeDownload /download /priority normal "%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chrome-%CHROME_ARCH%.zip" "%CD%\chrome-%CHROME_ARCH%.zip"
    if %errorlevel% neq 0 goto :download_error
)

echo Download completed successfully.
echo Attempting to extract Chrome...

:: Check if the zip file exists
if not exist "chrome-%CHROME_ARCH%.zip" goto :file_error

:: Extract Chrome files
powershell -command "Expand-Archive -Path 'chrome-%CHROME_ARCH%.zip' -DestinationPath '.' -Force"
if %errorlevel% neq 0 goto :extract_error

:: Move Chrome files
echo Installing Chrome...
xcopy /E /I /Y "chrome-%CHROME_ARCH%\*" "utils\"
if %errorlevel% neq 0 goto :move_error

:: Cleanup Chrome files
del /F /Q "chrome-%CHROME_ARCH%.zip"
rmdir /S /Q "chrome-%CHROME_ARCH%"

:: Download and install Chromedriver
echo Downloading Chromedriver...
where curl.exe >nul 2>&1
if %errorlevel% equ 0 (
    curl.exe --location --output "chromedriver-%CHROME_ARCH%.zip" "%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chromedriver-%CHROME_ARCH%.zip"
    if %errorlevel% neq 0 goto :download_error
) else (
    bitsadmin /transfer ChromedriverDownload /download /priority normal "%BASE_URL%/%CHROME_VERSION%/%CHROME_ARCH%/chromedriver-%CHROME_ARCH%.zip" "%CD%\chromedriver-%CHROME_ARCH%.zip"
    if %errorlevel% neq 0 goto :download_error
)

echo Attempting to extract Chromedriver...
powershell -command "Expand-Archive -Path 'chromedriver-%CHROME_ARCH%.zip' -DestinationPath '.' -Force"
if %errorlevel% neq 0 goto :extract_error

:: Move Chromedriver files
echo Installing Chromedriver...
xcopy /Y "chromedriver-%CHROME_ARCH%\chromedriver.exe" "utils\"
if %errorlevel% neq 0 goto :move_error

:: Cleanup Chromedriver files
del /F /Q "chromedriver-%CHROME_ARCH%.zip"
rmdir /S /Q "chromedriver-%CHROME_ARCH%"

:: Add utils to PATH
echo Adding utils directory to PATH...
setx PATH "%CD%\utils;%PATH%"
if %errorlevel% neq 0 goto :path_error

goto :end

:download_error
echo Error during download.
goto :error

:file_error
echo ZIP file not found after download.
goto :error

:extract_error
echo Error extracting the ZIP file.
goto :error

:move_error
echo Error moving files to utils directory.
goto :error

:path_error
echo Error updating PATH environment variable.
goto :error

:error
echo An error occurred during installation.
echo Please check your permissions and internet connection and try again.
pause
exit /b 1

:end
echo Setup completed successfully!
echo Please restart your terminal for PATH changes to take effect.
pause
exit /b 0
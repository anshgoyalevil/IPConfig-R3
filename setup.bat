@echo off
:: Check for administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script requires administrator privileges. Please run as administrator.
    pause
    exit /b
)

:: Ask the user for their extension ID
set /p extensionID="Enter your Chrome extension ID (from chrome://extensions/): "

:: Step 1: Copy the .bat script to a location on the user's system
echo Copying the .bat script to your Documents folder...
set scriptDir=%USERPROFILE%\Documents\run_bat
set "currentDir=%~dp0"
if not exist %scriptDir% mkdir %scriptDir%
copy "%currentDir%run_bat.bat" "%scriptDir%"
if %errorLevel% neq 0 (
    echo Error: Failed to copy .bat script. Ensure you have the necessary permissions.
    pause
    exit /b
)

:: Step 2: Create the Native Messaging Host Manifest
echo Creating the Native Messaging Host manifest...
set manifestDir="%LOCALAPPDATA%\Google\Chrome\User Data\NativeMessagingHosts"
if not exist %manifestDir% mkdir %manifestDir%
(
    echo { 
    echo   "name": "com.ansh.runbat",
    echo   "description": "Run a bat script from a Chrome extension",
    echo   "path": "%scriptDir%\\run_bat.bat",
    echo   "type": "stdio",
    echo   "allowed_origins": [
    echo     "chrome-extension://%extensionID%/"
    echo   ]
    echo }
) > %manifestDir%\com.ansh.runbat.json
if %errorLevel% neq 0 (
    echo Error: Failed to create manifest file. Ensure the path is correct and accessible.
    pause
    exit /b
)

:: Step 3: Add registry entry for Native Messaging Host
echo Adding registry entry for Chrome...
reg add HKEY_CURRENT_USER\Software\Google\Chrome\NativeMessagingHosts\com.ansh.runbat /ve /t REG_SZ /d %manifestDir%\com.ansh.runbat.json /f
if %errorLevel% neq 0 (
    echo Error: Failed to add registry entry. Ensure you have the necessary permissions.
    pause
    exit /b
)

:: Completion message
echo Setup completed successfully. You can now use the Chrome extension to run the .bat script!
pause

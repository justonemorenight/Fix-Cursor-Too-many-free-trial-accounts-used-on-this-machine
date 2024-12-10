@echo off
:: Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:: Set file path
set "storage_file=%APPDATA%\Cursor\User\globalStorage\storage.json"

:: Check if file exists
if not exist "%storage_file%" (
    echo Error: storage.json not found at %storage_file%
    pause
    exit /b
)

:: Generate random values
for /f "delims=" %%a in ('powershell -Command "[Guid]::NewGuid().ToString()"') do set "uuid=%%a"
for /f "delims=" %%a in ('powershell -Command "-join ((48..57) + (97..102) | Get-Random -Count 64 | ForEach-Object {[char]$_})"') do set "hex1=%%a"
for /f "delims=" %%a in ('powershell -Command "-join ((48..57) + (97..102) | Get-Random -Count 64 | ForEach-Object {[char]$_})"') do set "hex2=%%a"

:: Remove read-only attribute
attrib -r "%storage_file%"

:: Create new JSON content
echo {> "%storage_file%"
echo   "telemetry.macMachineId": "%hex1%",>> "%storage_file%"
echo   "telemetry.machineId": "%hex2%",>> "%storage_file%"
echo   "telemetry.devDeviceId": "%uuid%">> "%storage_file%"
echo }>> "%storage_file%"

:: Set read-only attribute
attrib +r "%storage_file%"

echo Done! File has been updated with new random values.
echo.
echo New values:
echo macMachineId: %hex1%
echo machineId: %hex2%
echo devDeviceId: %uuid%
echo.
pause 
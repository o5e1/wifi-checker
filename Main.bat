@echo off
title Network Information Utility
echo ====================================================
echo            Network Informant            
echo ====================================================
echo.
echo Gathering Network Information...
echo.

setlocal enabledelayedexpansion
set counter=1
:find_name
set filename=network_info!counter!.txt
if exist "!filename!" (
    set /a counter+=1
    goto find_name
)

echo Saving to: "!filename!"
echo --------- NETWORK INFORMATION --------- > "!filename!"

echo --------- IP Configuration --------- >> "!filename!"
ipconfig /all >> "!filename!"
echo IP Configuration Done!

echo. >> "!filename!"
echo --------- Active Connections --------- >> "!filename!"
netstat -n >> "!filename!"
echo Active Connections Done!

echo. >> "!filename!"
echo --------- ARP Table --------- >> "!filename!"
arp -a >> "!filename!"
echo ARP Table Done!

echo. >> "!filename!"
echo --------- DNS and Routing Table --------- >> "!filename!"
route print >> "!filename!"
echo DNS and Routing Done!

echo. >> "!filename!"
echo --------- Wireless Network Passwords --------- >> "!filename!"
for /f "tokens=4 delims=: " %%a in ('netsh wlan show profiles ^| findstr " : "') do (
    echo. >> "!filename!"
    echo Profile: %%a >> "!filename!"
    netsh wlan show profile name="%%a" key=clear | findstr "Key Content" >> "!filename!"
)
echo Wireless Network Passwords Done!

echo.
echo Network information, including Wi-Fi passwords, has been saved to "!filename!".
pause >nul
start "!filename!"

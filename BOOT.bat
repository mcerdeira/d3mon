echo "STARTING d3MONs SERVER version 6.6.6"
echo off

for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set ip=%ip:~1%
echo REACT_APP_LOCAL_IP=%ip% > .\proxy-gamepad\web-gamepad\.env
pause

start "" npm --prefix .\proxy-gamepad\web-gamepad\ run start 
start "" node .\proxy-gamepad\service\service.js
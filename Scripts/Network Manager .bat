@echo off
  
 title Windows 网络测试脚本程序

rem 获取管理员权限
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
  
 :allstart
  
 cls
  echo       ┌──────────────────────────────────────────────────────────────────────┐
  echo       │                                                                      │
  echo       │                       Windows 网络检查测试脚本                       │
  echo       │                Windows Network Inspection Test Script                │
  echo       │                                                                      │
  echo       │                                    https://www.dreamstart.site       │
  echo       │                                                                      │
  echo       ├──────────────────────────────────────────────────────────────────────┤
  echo       │       --------------------------------------------------------       │
  echo       │                                                                      │
  echo       │       请输入数字选择 Enter the System Identification Nnumber :       │
  echo       │                                                                      │
  echo       │       1) 自动进行网络测试                                            │
  echo       │                                                                      │
  echo       │       2) 手动检测处理网络                                            │
  echo       │                                                                      │
  echo       │       3) 重启Windows                                                 │
  echo       │                                                                      │
  echo       │                                                                      │
  echo       │       0) Exit                                                        │
  echo       │                                                                      │
  echo       │       --------------------------------------------------------       │
  echo       └──────────────────────────────────────────────────────────────────────┘
  
 set in=
  
 set /p in=请输入:
  
 if "%in%"=="1" goto autonetwork
  
 if "%in%"=="2" goto networktest
  
 if "%in%"=="3" goto reboot
  
 if "%in%"=="0" goto allclose
  
rem 自动进行网络测试 
:autonetwork
rem cd/d %~dp0
cd %TEMP%
SET SJ=%RANDOM%/327
if not exist "folder\log\networkrn\" (MD folder\log\networkrn\)
set log=folder\log\networkrn\%date:~0,3%%date:~5,2%%date:~8,2%%sj%.log
@mode con lines=32 cols=100
rem 回送地址
set ip1=127.0.0.1
rem ip地址

for /f "tokens=16" %%i in ('ipconfig ^|find /i "ipv4"') do set ip2=%%i
if "%ip2%"=="" (goto xp1) else goto 2
:xp1
for /f "tokens=15 " %%i in ('ipconfig ^|find /i "ipv4"') do (
set ip2=%%i
if "%ip2%"=="" (goto xp2) else goto 2
)
:xp2
for /f "tokens=15 " %%i in ('ipconfig ^|find /i "IP Address"') do set ip2=%%i
rem 网关地址
:2
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr 默认网关') do set ip3=%%i
if "%ip3%"=="" (goto xpwg) else goto 3
:xpwg
for /f "tokens=2 delims=:" %%i in ('ipconfig^|findstr Gateway') do set ip3=%%i 
if "%ip3%"=="" (goto debug3) else goto 3
:3
cls
rem 外网地址
rem 我的服务器地址
set ip4=10000.gd.cn
set ip5=www.baidu.com
rem 到这里结束
echo.
echo                                  networkrn
echo.
echo                           ————————————
echo.
echo                            回送地址:%ip1%
echo.
echo                            本机地址:%ip2%
echo.
echo                            网关地址:%ip3%
echo.
echo                            广东电信:%ip4%
echo.
echo                            测试网址:%ip5%
echo.
echo                          —————————————
echo.
Ping/n 3 127.0.0.1 > NUL 
echo 开始测试
cls
echo log:[%time%]startting
echo log:[%time%]pinging %ip1%
ping %ip1% > NUL
if errorlevel 1 (set test1=×  & goto xs) else set test1=√ 
echo log:[%time%]pinging %ip1%:%test1%


echo log:[%time%]pinging %ip2%
ping %ip2% > nul
if errorlevel 1 (set test2=×  & goto xs) else set test2=√
echo [%time%]pinging %ip2%:%test1%

echo log:[%time%]pinging %ip3%
ping %ip3% > NUL
if errorlevel 1 (set test3=×  & goto xs) else set test3=√
echo log:[%time%]pinging %ip1%:%test1%

echo log:[%time%]pinging %ip4%
ping %ip4% > NUL
if errorlevel 1 (set test4=×  & goto xs) else set test4=√
echo log:[%time%]pinging %ip4%:%test1%

echo log:[%time%]pinging %ip5%
ping %ip5% > nul
if errorlevel 1 (set test5=×  & goto xs) else set test5=√
echo log:[%time%]pinging %ip5%:%test1%
:xs
if "%test1%"=="" (set test1=?)
if "%test2%"=="" (set test2=?)
if "%test3%"=="" (set test3=?)
if "%test4%"=="" (set test4=?)
if "%test5%"=="" (set test5=?)
cls
echo √代表成功
echo ×代表失败
echo ? 代表未测试
echo                        测试结果
echo —————————————————————————
echo.
echo                      回送地址:%test1%            
echo.
echo                      本机地址:%test2%            
echo.
echo                      内网网关:%test3%           
echo.
echo                      广东电信:%test4%
echo.
echo                      具体网址:%test5%                  
echo.
echo —————————————————————————
if %test1%==×  (goto hs)
if %test2%==×  (goto bip)
if %test3%==×  (goto wg)
if %test4%==×  (goto gw)
if %test5%==×  (goto ww)
goto 3
:hs
if exist "failed1.txt" (del failed1.txt & echo 问题依然复现)
echo.
echo —————————————————————————
echo.
echo 检测出了新问题（PING不通回送地址）
echo 解决方案：
echo IP堆栈故障，检查重装TCP/IP协议
pause
goto allstart

:bip
if exist "failed1.txt" (del failed1.txt & echo 已修复无法ping通回送地址地址问题)
echo.
echo 检测出了新问题（PING不通本机IP）
echo.
echo —————————————————————————
echo 问题导致原因：
echo 网络适配器（网卡或MODEM）故障
echo 解决方案：
echo 1.检查网卡驱动是否正常
echo 2.将IP地址设置为自动
pause
goto allstart

:wg
if exist "failed1.txt" (del failed1.txt & echo 已修复无法ping通回送地址地址问题)
if exist "failed2.txt" (del failed2.txt & echo 已修复无法ping通本机ip问题)
echo.
echo 检测出了新问题（PING不通内网网关）
echo.
echo —————————————————————————
echo 可能导致的原因：
echo 1.IP地址分配问题，内网IP冲突
echo 2.内网故障，网络设备延时太大
echo 解决方案：
echo 1.设置IP自动分配
echo 2.联系网络管理员
pause
goto allstart

:gw
if exist "failed1.txt" (del failed1.txt & echo 已修复无法ping通回送地址地址问题)
if exist "failed2.txt" (del failed2.txt & echo 已修复无法ping通本机ip问题)
if exist "failed3.txt" (del failed3.txt & echo 已修复无法ping通网关ip问题)
echo.
echo 检测出了新问题（PING不通外网）
echo.
echo —————————————————————————
echo 可能导致的原因：
echo 1.网络设置问题（LSP问题）
echo 2.光猫异常（ISP问题）
echo 3.外网中断（ISP问题）
echo 解决方案：
echo 1.重置LSP: 管理员权限运行CMD，执行netsh winsock reset
echo   重启电脑便可完成重置LSP
echo 2.检查光猫光信号是否正常（绿色：正常，红色：光信号异常）
echo 3.联系网络供应商（中国电信）
pause
goto allstart

:ww
if exist "failed1.txt" (del failed1.txt & echo 已修复无法ping通回送地址地址问题)
if exist "failed2.txt" (del failed2.txt & echo 已修复无法ping通本机ip问题)
if exist "failed3.txt" (del failed3.txt & echo 已修复无法ping通网关ip问题)
echo.
echo 检测出了新问题（PING不通百度）
echo.
echo —————————————————————————
echo 可能导致的原因：
echo 网络设置问题（DNS，LSP问题）
echo 解决方案：
echo 1.重置LSP: 管理员权限运行CMD，执行netsh winsock reset
echo   重启电脑便可完成重置LSP
echo 2.联系网络供应商（中国电信）
pause
goto allstart

:3
if exist "failed1.txt" (del failed1.txt & echo 已修复无法ping通回送地址地址问题)
if exist "failed2.txt" (del failed2.txt & echo 已修复无法ping通本机ip问题)
if exist "failed3.txt" (del failed3.txt & echo 已修复无法ping通网关ip问题)
if exist "failed4.txt" (del failed4.txt & echo 已修复无法ping通外网问题)
echo.
echo 网络正常，检测没有发现问题……
echo.
echo —————————————————————————
echo 如果还是无法上网，建议：
echo 1.检查电脑时间是否正确，重置时钟，修改电脑时间
echo 2.重置LSP: 管理员权限运行CMD，执行netsh winsock reset
echo   重启电脑便可完成重置LSP
echo 3.清空hosts（C:\Windows\System32\drivers\etc\hosts)
echo 4.设置IP，DNS自动获取
echo 5.操作完成，问题依然存在，请联系网络管理员
pause
goto allstart
  
rem 手动进行网络测试 
  
:networktest
 cls
  echo       ┌──────────────────────────────────────────────────────────────────────┐
  echo       │                                                                      │
  echo       │                       Windows 手动进行测试网络                       │
  echo       │                Windows Network Inspection Test Script                │
  echo       │                                                                      │
  echo       │                                    https://www.dreamstart.site       │
  echo       │                                                                      │
  echo       ├──────────────────────────────────────────────────────────────────────┤
  echo       │       --------------------------------------------------------       │
  echo       │                                                                      │
  echo       │       请输入数字选择 Enter the System Identification Nnumber :       │
  echo       │                                                                      │
  echo       │       [1] 检测网关(192.168.1.1) [发送5个数据包]                      │
  echo       │                                                                      │
  echo       │       [2] 检测目的网络可达性 [发送5个数据包]                         │
  echo       │                                                                      │
  echo       │       [3] 检测路由路径 [Tracert IP/域名]                             │
  echo       │                                                                      │
  echo       │       [4] 域名解析查询（nslookup 域名）                              │
  echo       │                                                                      │
  echo       │       [5] 重置TCP/IP协议接口（LSP）                                  │
  echo       │                                                                      │
  echo       │       [6] 清除本机DNS缓存                                            │
  echo       │                                                                      │
  echo       │                                                                      │
  echo       │       0) 返回上一层                                                  │
  echo       │                                                                      │
  echo       │       --------------------------------------------------------       │
  echo       └──────────────────────────────────────────────────────────────────────┘

set /p s=请输入您要的功能:

if %s%==1 goto A

if %s%==2 goto B

if %s%==3 goto T

if %s%==4 goto H

if %s%==5 goto K

if %s%==6 goto C

if %s%==0 goto allstart

cls
echo 您的输入错误!
goto networktest

:A
ping.exe 192.168.1.1 -n 5
cls
goto networktest

:B
set /p w=请输入你要PING的域名或IP地址：
ping.exe %w%  -n 5
ping -n 3 127.1 >nul
cls
goto networktest

:T
set /p d=请输入你要Tracert的域名或IP地址：
tracert %d%
ping -n 3 127.1 >nul
cls
goto networktest

:H
set /p c=请输入你要查询的域名：
nslookup %c%
ping -n 3 127.1 >nul
goto networktest

:K
echo 正在重置TCP/IP协议接口（LSP）......
netsh winsock reset
ping -n 3 127.1 >nul
goto networktest

:C
echo 清除本机DNS缓存......
ipconfig /flushdns
ping -n 3 127.1 >nul
goto networktest




rem 重启Windows
  
:reboot
echo 正在进行重启，请稍后……
shutdown.exe /r -t 0
goto allclose
 

:allclose
echo 按任意键退出
pause
exit#########
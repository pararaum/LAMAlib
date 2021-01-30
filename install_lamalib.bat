@rem makelib.bat
@rem an MSDOS batch file (runs on Windows) to reassemble all parts of the library for the LAMAlib project
@rem and to install it in cc65 
@rem 
@rem Usage: install_lamalib
@rem cc65 tools need to be installed on your system and to be in your path
@rem
@rem Version: 0.2
@rem Date: 2020-05-11
@rem Author: Wil Elmenreich (wilfried at gmx dot at)
@rem License: The Unlicense (public domain)

@echo off
setlocal ENABLEDELAYEDEXPANSION

cd lib-functions
set count=0
for %%f in (*.s) do (
    ca65 -t c64 %%f
    set /a count+=1
)

for %%f in (*.o) do (
    ar65 d ..\LAMAlib.lib %%f
    ar65 a ..\LAMAlib.lib %%f
)

echo Library has been created with %count% modules in it.
cd ..

rem find cc65 directory
for /F %%I in ('where cc65.exe') do (
  for %%J in ("%%I\..\..") do set "CC65PATH=%%~fJ"
)

@copy LAMAlib*.inc "%CC65PATH%\asminc"
@copy LAMAlib.lib "%CC65PATH%\lib"


rem  Define some useful colorcode vars:
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESCchar=%%E"
set "green=%ESCchar%[92m"
set "yellow=%ESCchar%[93m"
set "magenta=%ESCchar%[95m"
set "cyan=%ESCchar%[96m"
set "white=%ESCchar%[97m"
set "black=%ESCchar%[30m"
set "reset=%ESCchar%[0m"
set "bold=%ESCchar%[1m"

echo %white%
echo *********************************************************************************************
echo * Congratulations, LAMAlib has been installed^^!                                              *
echo *                                                                                           *
echo * To use it,                                                                                *
echo * add the line %cyan%include "LAMAlib.inc"%white% at the top of your assembler file                      *
echo * and assemble with command %cyan%cl65 yourprog.s -lib LAMAlib.lib -C c64-asm.cfg -o yourprog.prg%white% *
echo * There is no overhead to your assembled program for unused functions                       *
echo *********************************************************************************************%reset%

pause
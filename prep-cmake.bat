@echo off

:: checkout the Batchography book

setlocal

if not defined IDASDK (
    echo IDASDK environment variable not set.
    goto :eof
)

if not exist %IDASDK%\include\idax\xkernwin.hpp (
    echo IDAX framework not properly installed in the IDA SDK folder.
    echo See: https://github.com/ida-cmake/idax
    goto :eof
)

if not exist %IDASDK%\ida-cmake\common.cmake (
    echo ida-cmake not properly installed in the IDA SDK folder.
    echo See: https://github.com/allthingsida/ida-cmake
    goto :eof
)

if "%1"=="clean" (
    if exist build rmdir /s /q build
    goto :eof
)

if not exist build cmake -B build -S . -A x64 -DEA64=YES

if "%1"=="build" cmake --build build --config Release

echo.
echo All done!
echo.
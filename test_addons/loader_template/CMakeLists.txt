cmake_minimum_required(VERSION 3.27)
project(qscripts_native)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include IDA SDK bootstrap
include($ENV{IDASDK}/ida-cmake/bootstrap.cmake)
find_package(idasdk REQUIRED)

# Add loader
ida_add_loader(qscripts_native
    SOURCES
        driver.cpp
        main.cpp
        idasdk.h
    DEBUG_ARGS
        "-t"
)

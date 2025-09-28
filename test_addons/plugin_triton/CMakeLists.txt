cmake_minimum_required(VERSION 3.27)
project(qscripts_native_triton)

# Make sure 'tritonenv.bat' script has been called and the proper environment variables are set

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include IDA SDK bootstrap
include($ENV{IDASDK}/ida-cmake/bootstrap.cmake)
find_package(idasdk REQUIRED)

# Add plugin with Triton support
ida_add_plugin(qscripts_native_triton
    SOURCES
        driver.cpp
        main.cpp
    INCLUDES
        $ENV{TRITON_INCLUDES}
    LIBRARIES
        $ENV{TRITON_LIB}
    DEBUG_ARGS
        ${CMAKE_CURRENT_LIST_DIR}/junk64.bin.i64
)

# Disable specific warnings
target_compile_options(qscripts_native_triton PRIVATE /wd4267 /wd4244)

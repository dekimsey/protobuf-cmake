
include_directories( ${PROTOBUF_ROOT}/src )

# Set relative rpath for protoc to be able to find libs after installed
set(CMAKE_INSTALL_RPATH "\$ORIGIN/../lib")

cmake_policy(SET CMP0015 NEW)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

if(WIN32 AND BUILD_SHARED_LIBS AND MSVC)
    add_definitions("-DPROTOBUF_USE_DLLS")
endif()

add_definitions("-D_GNU_SOURCE=1")

# config.h is generated from cmake now, so use on all platforms
configure_file("config.h.in" "config.h")
include_directories(${CMAKE_CURRENT_BINARY_DIR})
add_definitions( -DHAVE_CONFIG_H )

if( MSVC )
  add_definitions(
    -D_CRT_SECURE_NO_WARNINGS=1
    /wd4244 /wd4267 /wd4018 /wd4355 /wd4800 /wd4251 /wd4996 /wd4146 /wd4305
    )
else()
  add_definitions( -Wno-deprecated )
endif()

# Easier to support different versions of protobufs
function(append_if_exist OUTPUT_LIST)
    set(${OUTPUT_LIST})
    foreach(fil ${ARGN})
        if(EXISTS ${fil})
            list(APPEND ${OUTPUT_LIST} "${fil}")
        else()
            message("Warning: file missing: ${fil}")
        endif()
    endforeach()
    set(${OUTPUT_LIST} ${${OUTPUT_LIST}} PARENT_SCOPE)
endfunction()

# Install locations
set(BIN_DIR     bin)
set(INCLUDE_DIR include)
set(LIB_DIR     lib)


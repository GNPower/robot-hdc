CMAKE_MINIMUM_REQUIRED(VERSION 3.16)

# Set the project name
project(my_hdc)

# add_subdirectory(hdc)

include_directories(
        ${CMAKE_CURRENT_SOURCE_DIR}/hdc/include
)

add_executable(myhdc
        test.cpp)
target_include_directories(myhdc
PRIVATE
    hdc/include)
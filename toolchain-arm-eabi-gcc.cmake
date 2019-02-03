include(CMakeForceCompiler)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR cortex-m4)
set ( CMAKE_WARN_DEPRECATED 0 )

find_program(ARM_CC arm-none-eabi-gcc ${TOOLCHAIN_DIR}/bin)
find_program(ARM_CXX arm-none-eabi-g++ ${TOOLCHAIN_DIR}/bin)
#find_program(ARM_OBJCOPY arm-none-eabi-objcopy ${TOOLCHAIN_DIR}/bin)
#find_program(ARM_SIZE_TOOL arm-none-eabi-size ${TOOLCHAIN_DIR}/bin)

message(${TOOLCHAIN_DIR})
message(${ARM_CC})
message(${ARM_CXX})
CMAKE_FORCE_C_COMPILER(${ARM_CC} GNU)
CMAKE_FORCE_CXX_COMPILER(${ARM_CXX} GNU)

SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32L476RGTx_FLASH.ld)

set(CMAKE_ARM_FLAGS
        "-mcpu=cortex-m4 -mthumb -fno-common -ffunction-sections -fdata-sections"
        )

#set(CMAKE_EXE_LINKER_FLAGS
#        "${CMAKE_EXE_LINKER_FLAGS} -specs=nano.specs")

if (CMAKE_SYSTEM_PROCESSOR STREQUAL "cortex-m4")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_ARM_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_ARM_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CMAKE_ARM_FLAGS}")
else ()
    message(WARNING
            "Processor not recognised in toolchain file, "
            "compiler flags not configured."
            )
endif ()

# fix long strings (CMake appends semicolons)
string(REGEX REPLACE ";" " " CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "")

set(BUILD_SHARED_LIBS OFF)


#SET(COMMON_FLAGS "-mcpu=cortex-m0 -mthumb -mthumb-interwork -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0")
#SET(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -std=c++11")
#SET(CMAKE_C_FLAGS "${COMMON_FLAGS} -std=gnu99")
#SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-gc-sections -T ${LINKER_SCRIPT}")
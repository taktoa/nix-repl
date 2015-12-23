cmake_minimum_required(VERSION 2.8.11)
project(NIX_REPL)

find_package(PkgConfig REQUIRED)

pkg_check_modules(Nix REQUIRED nix-main nix-expr nix-store)

include_directories(${Nix_INCLUDE_DIRS})
link_directories(${Nix_LIBRARY_DIRS})
add_definitions(${Nix_CFLAGS_OTHER})

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -std=c++0x")

add_executable(nix-repl src/nix-repl.cc)

target_link_libraries(nix-repl
                      ${Nix_LIBRARIES}
                      readline)

install(TARGETS nix-repl
        RUNTIME DESTINATION bin
        ARCHIVE DESTINATION lib)

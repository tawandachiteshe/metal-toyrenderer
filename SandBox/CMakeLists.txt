cmake_minimum_required(VERSION 3.19)
project(Sandbox)

set(CMAKE_CXX_STANDARD 17)
set(TOY_ENGINE_DIR ${PROJECT_SOURCE_DIR}/../ToyEngine)
add_subdirectory(${TOY_ENGINE_DIR} ${TOY_ENGINE_DIR}/bin)

add_executable(${PROJECT_NAME}
        SandBox2D.mm
        SandBox2D.h
        SandboxApp.mm
        )

target_include_directories(${PROJECT_NAME} PUBLIC ${TOY_ENGINE_DIR}/third_party/glm)
target_include_directories(${PROJECT_NAME} PUBLIC ${TOY_ENGINE_DIR}/third_party/imgui-docking)
target_include_directories(${PROJECT_NAME} PUBLIC ${TOY_ENGINE_DIR}/third_party/glfw/include)
target_include_directories(${PROJECT_NAME} PUBLIC ${TOY_ENGINE_DIR})
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})

target_link_libraries(
        ${PROJECT_NAME}
        MTLToyGameEngine
)
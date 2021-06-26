cmake_minimum_required(VERSION 3.19)
project(untitled)

set(CMAKE_CXX_STANDARD 20)

#add_subdirectory(third_party/crosswindow)
add_subdirectory(third_party/glfw)
add_subdirectory(third_party/glm)




# ❎ When creating your executable use CrossWindow's abstraction function:


add_executable(
        # Target
        ${PROJECT_NAME}
        # Source Files (make sure to surround in quotations so CMake treats it as a list)
        main.mm
        third_party/stb_image.h
        third_party/stb_image.mm
        Application.mm Application.h Renderer.mm Renderer.h Window.mm Window.h VertexBuffer.mm VertexBuffer.h Shader.mm Shader.h BufferLayout.h IndexBuffer.mm IndexBuffer.h RenderCommand.mm RenderCommand.h Texture.mm Texture.h)

# 🔗 Link CrossWindow to your project:

target_include_directories(${PROJECT_NAME} PUBLIC third_party/glm)

target_link_libraries(
        ${PROJECT_NAME}
        glfw
        "-framework AppKit"
        "-framework Metal"
        "-framework QuartzCore"
)
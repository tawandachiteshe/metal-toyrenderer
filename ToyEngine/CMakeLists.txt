cmake_minimum_required(VERSION 3.19)
project(MTLToyGameEngine)

set(CMAKE_CXX_STANDARD 17)

#add_subdirectory(third_party/crosswindow)
add_subdirectory(third_party/glfw)
add_subdirectory(third_party/glm)
add_subdirectory(third_party/imgui-docking)



# ❎ When creating your executable use CrossWindow's abstraction function:


add_library(
        # Target
        ${PROJECT_NAME}
        # Source Files (make sure to surround in quotations so CMake treats it as a list)
        third_party/stb_image.h
        third_party/stb_image.mm
        Renderer/Renderer2D.h
        Renderer/Renderer2D.mm
        Renderer/Renderer.mm
        Renderer/Renderer.h
        Window/Window.mm
        Window/Window.h
        Renderer/VertexBuffer.mm
        Renderer/VertexBuffer.h
        Renderer/Shader.mm
        Renderer/Shader.h
        Renderer/BufferLayout.h
        Renderer/IndexBuffer.mm
        Renderer/IndexBuffer.h
        Renderer/RenderCommand.mm
        Renderer/RenderCommand.h
        Renderer/Texture.mm
        Renderer/Texture.h
        Renderer/FrameBuffer.mm
        Renderer/FrameBuffer.h
        Renderer/IMGUI/ImGuiDock.mm
        Renderer/IMGUI/ImGuiDock.h
        Renderer/IMGUI/ImGuiLayer.mm
        Renderer/IMGUI/ImGuiLayer.h
        Core/Layer.mm
        Core/Layer.h
        Events/Event.h
        Core/Layer.mm
        Core/Layer.h
        Core/Timestep.mm
        Core/Timestep.h
        Core/KeyCodes.h
        Core/LayerStack.mm
        Core/LayerStack.h
        Core/Time.h
        Core/Base.h
        Core/Application.mm
        Core/Application.h
        Core/EntryPoint.h
        Core/Input.h
        Events/ApplicationEvent.h
        Events/KeyEvent.h
        Events/MouseEvent.h
        Renderer/OrthoCamera.mm
        Renderer/OrthoCamera.h
        Renderer/OrthoCameraController.mm
        Renderer/OrthoCameraController.h
        Renderer/UniformBuffer.mm
        Renderer/UniformBuffer.h
        Renderer/Camera.h
        Renderer/EditorCamera.mm
        Renderer/EditorCamera.h
        Core/Input.mm)

# 🔗 Link CrossWindow to your project:

target_include_directories(${PROJECT_NAME} PUBLIC third_party/glm)
target_include_directories(${PROJECT_NAME} PUBLIC third_party/imgui-docking)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})

target_link_libraries(
        ${PROJECT_NAME}
        glfw
        IMGUI
        "-framework Metal" "-framework MetalKit" "-framework Cocoa" "-framework IOKit" "-framework CoreVideo" "-framework QuartzCore"
)
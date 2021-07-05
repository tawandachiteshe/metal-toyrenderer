cmake_minimum_required(VERSION 3.19)
project(IMGUI)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CXX_FLAGS "-ObjC++ -fobjc-weak -fobjc-arc")

#SOURCES += $(IMGUI_DIR)/imgui.cpp $(IMGUI_DIR)/imgui_demo.cpp $(IMGUI_DIR)/imgui_draw.cpp $(IMGUI_DIR)/imgui_tables.cpp $(IMGUI_DIR)/imgui_widgets.cpp
#SOURCES += $(IMGUI_DIR)/backends/imgui_impl_glfw.cpp $(IMGUI_DIR)/backends/imgui_impl_metal.mm

add_library(${PROJECT_NAME}
        imgui.cpp
        imgui_demo.cpp
        imgui_draw.cpp
        imgui_tables.cpp
        imgui_widgets.cpp
        imgui_impl_glfw.cpp
        imgui_impl_metal.mm
        )

target_include_directories(${PROJECT_NAME} PUBLIC ../glfw/include)
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})
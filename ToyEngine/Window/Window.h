//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_WINDOW_H
#define UNTITLED_WINDOW_H

#define GLFW_INCLUDE_NONE
#define GLFW_EXPOSE_NATIVE_COCOA
#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>
#import <utility>
#include "Core/Base.h"
#include "Events/Event.h"
#include <functional>
#include <string>

static void quit(GLFWwindow *window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, GLFW_TRUE);
    }
}

struct WindowProps
{
    std::string Title;
    uint32_t Width;
    uint32_t Height;

    WindowProps(const std::string& title = "Metal Toy Renderer",
                uint32_t width = 1600,
                uint32_t height = 900)
            : Title(title), Width(width), Height(height)
    {
    }
};


class Window {


public:
    using EventCallbackFn = std::function<void(Event&)>;

    ~Window();

    void OnUpdate();

    uint32_t GetWidth() const { return m_Data.Width; }
    uint32_t GetHeight() const {  return m_Data.Height; }

    // Window attributes
    void SetEventCallback(const EventCallbackFn& callback) { m_Data.eventCallbackFn = callback; }
    void SetVSync(bool enabled) { m_IsVsync = enabled; }
    bool IsVSync() const { return m_IsVsync; }
    void Shutdown();

     GLFWwindow* GetNativeWindow() const { return m_window; }

public:
    Window(const WindowProps& props);
    void PollEvents();
    bool IsWindowOpen() { return !glfwWindowShouldClose(m_window); }
    void Release();

private:

    struct WindowData {
        EventCallbackFn eventCallbackFn;
        std::string Title;
        uint32_t Width;
        uint32_t Height;
    };

    GLFWwindow *m_window;
    WindowData m_Data;
    bool m_IsVsync = false;

};


#endif //UNTITLED_WINDOW_H

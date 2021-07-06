//
// Created by __declspec on 25/6/2021.
//

#include "Window.h"
#import <QuartzCore/QuartzCore.h>
#import <Renderer/Renderer.h>
#import <Events/ApplicationEvent.h>
#import <Events/KeyEvent.h>
#import <Events/MouseEvent.h>
#import <Renderer/Swapchain.h>


static uint8_t s_GLFWWindowCount = 0;

static void GLFWErrorCallback(int error, const char* description)
{
    //HZ_CORE_ERROR("GLFW Error ({0}): {1}", error, description);
}


void Window::Release() {

    glfwDestroyWindow(m_window);
    glfwTerminate();
}

Window::~Window() {
    Release();
}

Window::Window(const WindowProps &props) {

    if (s_GLFWWindowCount == 0)
    {
        glfwInit();

    }

    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    m_window = glfwCreateWindow(props.Width, props.Height, props.Title.c_str(), NULL, NULL);
    ++s_GLFWWindowCount;
    Swapchain::Init(props.Width, props.Height);
    NSWindow *nswindow = glfwGetCocoaWindow(m_window);
    nswindow.contentView.layer = Swapchain::GetSwapchain();
    nswindow.contentView.wantsLayer = YES;


    glfwSetWindowUserPointer(m_window, &m_Data);

    glfwSetWindowSizeCallback(m_window, [](GLFWwindow* window, int width, int height)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);
        data.Width = static_cast<uint32_t>(width);
        data.Height = static_cast<uint32_t>(height);

        WindowResizeEvent event(width, height);
        data.eventCallbackFn(event);
    });

    glfwSetWindowCloseCallback(m_window, [](GLFWwindow* window)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);
        WindowCloseEvent event;
        data.eventCallbackFn(event);
    });

    glfwSetKeyCallback(m_window, [](GLFWwindow* window, int key, int scancode, int action, int mods)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);

        switch (action)
        {
            case GLFW_PRESS:
            {
                KeyPressedEvent event(key, 0);
                data.eventCallbackFn(event);
                break;
            }
            case GLFW_RELEASE:
            {
                KeyReleasedEvent event(key);
                data.eventCallbackFn(event);
                break;
            }
            case GLFW_REPEAT:
            {
                KeyPressedEvent event(key, 1);
                data.eventCallbackFn(event);
                break;
            }
        }
    });

    glfwSetCharCallback(m_window, [](GLFWwindow* window, unsigned int keycode)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);

        KeyTypedEvent event(keycode);
        data.eventCallbackFn(event);
    });

    glfwSetMouseButtonCallback(m_window, [](GLFWwindow* window, int button, int action, int mods)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);

        switch (action)
        {
            case GLFW_PRESS:
            {
                MouseButtonPressedEvent event(button);
                data.eventCallbackFn(event);
                break;
            }
            case GLFW_RELEASE:
            {
                MouseButtonReleasedEvent event(button);
                data.eventCallbackFn(event);
                break;
            }
        }
    });

    glfwSetScrollCallback(m_window, [](GLFWwindow* window, double xOffset, double yOffset)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);

        MouseScrolledEvent event((float)xOffset, (float)yOffset);
        data.eventCallbackFn(event);
    });

    glfwSetCursorPosCallback(m_window, [](GLFWwindow* window, double xPos, double yPos)
    {
        WindowData& data = *(WindowData*)glfwGetWindowUserPointer(window);

        MouseMovedEvent event((float)xPos, (float)yPos);
        data.eventCallbackFn(event);
    });


}


void Window::OnUpdate() {
    glfwPollEvents();
    Swapchain::Swapbuffers();
}

void Window::Shutdown() {

    glfwDestroyWindow(m_window);
    --s_GLFWWindowCount;

    if (s_GLFWWindowCount == 0)
    {
        glfwTerminate();
    }

}


//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_WINDOW_H
#define UNTITLED_WINDOW_H

#define GLFW_INCLUDE_NONE
#define GLFW_EXPOSE_NATIVE_COCOA
#include <GLFW/glfw3.h>
#include <GLFW/glfw3native.h>

static void quit(GLFWwindow *window, int key, int scancode, int action, int mods)
{
    if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS) {
        glfwSetWindowShouldClose(window, GLFW_TRUE);
    }
}



class Window {

private:
    GLFWwindow *window = nullptr;
public:
    void Init(void *swapchain);
    GLFWwindow* GetWindow() { return window; }
    void PollEvents();
    bool IsWindowOpen() { return !glfwWindowShouldClose(window); }
    void Release();

    ~Window();

};


#endif //UNTITLED_WINDOW_H

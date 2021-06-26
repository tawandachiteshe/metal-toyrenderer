//
// Created by __declspec on 25/6/2021.
//

#include "Window.h"
#import <QuartzCore/QuartzCore.h>


void Window::Init(void *swapchain) {
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    window = glfwCreateWindow(1280, 800, "GLFW Metal", NULL, NULL);
    NSWindow *nswindow = glfwGetCocoaWindow(window);
    nswindow.contentView.layer = (CAMetalLayer*)swapchain;
    nswindow.contentView.wantsLayer = YES;

    glfwSetKeyCallback(window, quit);
}

void Window::PollEvents() {
    glfwPollEvents();
}

void Window::Release() {

    glfwDestroyWindow(window);
    glfwTerminate();
}

Window::~Window() {
    Release();
}


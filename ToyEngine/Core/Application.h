//
// Created by __declspec on 5/7/2021.
//



#ifndef UNTITLED_APPLICATION_H
#define UNTITLED_APPLICATION_H

#import <string>
#import <Window/Window.h>
#import <Renderer/IMGUI/ImGuiLayer.h>
#import <Events/Event.h>
#import <Events/ApplicationEvent.h>
#import "Layer.h"
#import "LayerStack.h"


int main(int argc, char** argv);

struct ApplicationCommandLineArgs
{
    int Count = 0;
    char** Args = nullptr;
};

class Application
{
public:
    Application(const std::string& name = "Hazel App", ApplicationCommandLineArgs args = ApplicationCommandLineArgs());
    virtual ~Application();

    void OnEvent(Event& e);

    void PushLayer(Layer* layer);
    void PushOverlay(Layer* layer);

    Window& GetWindow() { return *m_Window; }

    void Close();

    ImGuiLayer* GetImGuiLayer() { return m_ImGuiLayer; }

    static Application& Get() { return *s_Instance; }

    ApplicationCommandLineArgs GetCommandLineArgs() const { return m_CommandLineArgs; }
private:
    void Run();
    bool OnWindowClose(WindowCloseEvent& e);
    bool OnWindowResize(WindowResizeEvent& e);
private:
    ApplicationCommandLineArgs m_CommandLineArgs;
    Scope<Window> m_Window;
    ImGuiLayer* m_ImGuiLayer;
    bool m_Running = true;
    bool m_Minimized = false;
    LayerStack m_LayerStack;
    float m_LastFrameTime = 0.0f;
private:
    static Application* s_Instance;
    friend int ::main(int argc, char** argv);
};

// To be defined in CLIENT
Application* CreateApplication(ApplicationCommandLineArgs args);


#endif //UNTITLED_APPLICATION_H

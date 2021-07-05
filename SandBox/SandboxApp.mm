//
// Created by __declspec on 5/7/2021.
//


#import <Core/Application.h>
#import "SandBox2D.h"
#import "Core/EntryPoint.h"

class Sandbox : public Application
{
public:
    Sandbox()
    {
        // PushLayer(new ExampleLayer());
        PushLayer(new SandBox2D());
    }

    ~Sandbox()
    {
    }
};


Application* CreateApplication(ApplicationCommandLineArgs args)
{
    return new Sandbox();
}

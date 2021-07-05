//
// Created by __declspec on 5/7/2021.
//

#ifndef UNTITLED_ENTRYPOINT_H
#define UNTITLED_ENTRYPOINT_H

extern Application* CreateApplication(ApplicationCommandLineArgs args);

int main(int argc, char** argv)
{
    auto app = CreateApplication({ argc, argv });
    app->Run();
    delete app;
}

#endif //UNTITLED_ENTRYPOINT_H

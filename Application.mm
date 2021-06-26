//
// Created by __declspec on 25/6/2021.
//

#include "Application.h"

struct Vertex {
    glm::vec3 position;
    glm::vec4 color;
};


void Application::Init() {

    window = std::make_shared<Window>();
    renderer = std::make_shared<Renderer>();

    renderer->Init();
    window->Init(renderer->GetSwapChain());

    Vertex positions[] = { {{0.0f, 1.0f,  0.0f}, {1.0f, 0.0f, 1.0f, 1.0f}},
                           {{-1.0f, -1.0f, 0.0f}, {1.0f, 1.0f, 0.0f, 1.0f}},
                           {{1.0f, -1.0f, 0.0f}, {0.0f, 0.0f, 1.0f, 1.0f}} };

    uint32_t indices[] = {
            0, 2, 1
    };


    vertexBuffer = std::make_shared<VertexBuffer>((void*)positions, sizeof(positions));

    vertexBuffer->SetLayout({{ShaderDataType::Float3, "position"},
                                    {ShaderDataType::Float4, "color"}});

    indexBuffer = std::make_shared<IndexBuffer>(indices, 3);

    whiteShader = std::make_shared<Shader>("Shaders/whiteShader.mm");
    whiteShader->SetVertexLayout(vertexBuffer->GetLayout());
}

void Application::Run() {

    while (window->IsWindowOpen()) {
        window->PollEvents();
        renderer->SwapChain();
        Render();
    }


}

void Application::Render() {
    renderer->Clear(glm::vec4(1, 0, 0, 1));
    renderer->BeginRender(vertexBuffer, indexBuffer, whiteShader);
    renderer->EndRender();
}

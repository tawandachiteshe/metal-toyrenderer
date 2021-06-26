//
// Created by __declspec on 25/6/2021.
//

#include "Application.h"
#include <glm/gtx/transform.hpp>
#include <glm/gtc/matrix_transform.hpp>

struct Vertex {
    glm::vec3 position;
    glm::vec4 color;
    glm::vec2 uv;
};


void Application::Init() {


    uint32_t width = 1280;
    uint32_t height = 800;
    float aspectRatio = (float) width / (float) height;
    float zoomLevel = 0.75f;
    projectionview =
            glm::ortho(-aspectRatio * zoomLevel, aspectRatio * zoomLevel, -zoomLevel, zoomLevel) * glm::mat4(1.0f);
    window = std::make_shared<Window>();
    renderer = std::make_shared<Renderer>();

    renderer->Init();
    window->Init(renderer->GetSwapChain());

    Vertex positions[] = {{{-0.5f, -0.5f, 0.0f}, {1.0f, 0.0f, 1.0f, 1.0f}, {0.0f, 0.0f}},
                          {{0.5f,  -0.5f, 0.0f}, {1.0f, 1.0f, 0.0f, 1.0f}, {1.0f, 0.0f}},
                          {{0.5f,  0.5f,  0.0f}, {0.0f, 1.0f, 1.0f, 1.0f}, {1.0f, 1.0f}},
                          {{-0.5f, 0.5f,  0.0f}, {0.0f, 1.0f, 1.0f, 1.0f}, {0.0f, 1.0f}}};

    uint32_t indices[] = {
            0, 1, 2, 0, 2, 3
    };

    texture = std::make_shared<Texture>("textures/waifu.png");


    vertexBuffer = std::make_shared<VertexBuffer>((void *) positions, sizeof(positions));

    vertexBuffer->SetLayout({{ShaderDataType::Float3, "position"},
                             {ShaderDataType::Float4, "color"},
                             {ShaderDataType::Float2, "uv"}});

    indexBuffer = std::make_shared<IndexBuffer>(indices, 6);

    whiteShader = std::make_shared<Shader>("Shaders/whiteShader.metal");
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
    static float rotate_ = 0.0f;
    rotate_ += 1.0f / 60.0f;
    glm::mat4 rotate = projectionview * glm::rotate(glm::mat4(1.0f), glm::radians(rotate_*15.0f), glm::vec3(0, 0, 1));
            renderer->Clear(glm::vec4(0.3f, 0.3f, 0.3f, 1));
    renderer->Submit(vertexBuffer, indexBuffer);
    texture->Bind();
    renderer->BeginRender(whiteShader, rotate);
    whiteShader->SetMat4(rotate);
    renderer->EndRender();
}

//
// Created by __declspec on 25/6/2021.
//



#include "Application.h"
#import "Renderer/RenderCommand.h"
#include <glm/gtx/transform.hpp>
#include <glm/gtc/matrix_transform.hpp>
#import "Renderer/Renderer2D.h"

struct Vertex {
    glm::vec3 position;
    glm::vec4 color;
    glm::vec2 uv;
};


void Application::Init() {

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

    texture = std::make_shared<Texture>("Assets/textures/waifu.png");
    texture2 = std::make_shared<Texture>(800, 600);


    vertexBuffer = std::make_shared<VertexBuffer>(sizeof(positions));
    vertexBuffer->SetData((void *) positions, sizeof(positions));

    vertexBuffer->SetLayout({{ShaderDataType::Float3, "position"},
                             {ShaderDataType::Float4, "color"},
                             {ShaderDataType::Float2, "uv"}});

    indexBuffer = std::make_shared<IndexBuffer>(indices, 6);

    whiteShader = std::make_shared<Shader>("Assets/Shaders/whiteShader.metal");
    whiteShader->SetVertexLayout(vertexBuffer->GetLayout());
    whiteShader2 = std::make_shared<Shader>("Assets/Shaders/blueandlit.metal");
    whiteShader2->SetVertexLayout(vertexBuffer->GetLayout());

    Renderer2D::Init();

    framebuffer = std::make_shared<FrameBuffer>(800, 600);

}

void Application::Run() {

    while (window->IsWindowOpen()) {
        window->PollEvents();

        renderer->SwapChain();
        Render();
        renderer->Present();
    }

}

void Application::Render() {

    auto windowWidth = (float)Window::GetWindowSize().first;
    auto windowHeight = (float)Window::GetWindowSize().second;
    float aspectRatio = (float) windowWidth / (float) windowHeight;
    float zoomLevel = 0.75f;

    glm::mat4 adjust = {
            1.0f, 0.0f, 0.0f, 0.0f,
            0.0f, 1.0f, 0.0f, 0.0f,
            0.0f, 0.0f, -1.0f, -1.0f,
            0.0f, 0.0f, 0.0f, 1.0f
    };

    projectionview =
            adjust * glm::ortho(-aspectRatio * zoomLevel, aspectRatio * zoomLevel, -zoomLevel, zoomLevel) * glm::mat4(1.0f);

    static float rotate_ = 0.0f;
    rotate_ += 1.0f / 60.0f;
    glm::mat4 rotate = projectionview * glm::rotate(glm::mat4(1.0f), glm::radians(rotate_ * 15.0f), glm::vec3(0, 0, 1));
    renderer->Clear(glm::vec4(0.3f, 0.3f, 0.3f, 1));

    glm::mat4 rotate2 =
            projectionview * glm::rotate(glm::mat4(1.0f), glm::radians(rotate_ * 35.0f), glm::vec3(0, 0, 1));

    renderer->Clear(glm::vec4(0.3f, 0.3f, 0.3f, 1));


    texture2->SetTexture(framebuffer->GetTexture());

    RenderCommand::SetCommandEncoder(Renderer::GetEncoder());
    Renderer2D::BeginScene(projectionview);
    Renderer2D::DrawRotatedQuad({0.0f, 0.0f, 1.0f}, {1.0f, 1.0f}, rotate_ * 25.0f, texture, 10.0f, {1.0f, 1.0f, 1.0f, 1.0f});
    Renderer2D::DrawRotatedQuad({0.0f, 0.5f, 1.0f}, {1.0f, 1.0f}, 0.0f, texture2, 1.0f, {1.0f, 1.0f, 1.0f, 1.0f});
    Renderer2D::EndScene();
    RenderCommand::EndCommandEncoder();




    framebuffer->Bind();
    framebuffer->SetClearColor({1.0f, 0.0f, 0.0f, 1.0f});

    RenderCommand::SetCommandEncoder(framebuffer->GetEncoder());
    texture->Bind();
    renderer->Submit(vertexBuffer, indexBuffer, whiteShader);
    renderer->BeginRender(rotate);
    renderer->Draw();
    renderer->EndRender();
    RenderCommand::EndCommandEncoder();

//    RenderCommand::SetCommandEncoder(framebuffer->GetEncoder());
//    Renderer2D::BeginScene(projectionview);
//    Renderer2D::DrawRotatedQuad({0.0f, 0.0f, 1.0f}, {1.0f, 1.0f}, rotate_ * 25.0f, texture, 10.0f, {1.0f, 1.0f, 1.0f, 1.0f});
//    Renderer2D::DrawRotatedQuad({0.0f, 0.5f, 1.0f}, {1.0f, 1.0f}, 90.0f, texture2, 1.0f, {1.0f, 1.0f, 1.0f, 1.0f});
//    Renderer2D::EndScene();
//    RenderCommand::EndCommandEncoder();


}

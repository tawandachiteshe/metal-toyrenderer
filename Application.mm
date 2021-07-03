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

    texture = std::make_shared<Texture>(1, 1);
    const uint32_t data = 0xFF0000FF;
    texture->SetData((void*)&data, sizeof(data));



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
}

void Application::Run() {

    while (window->IsWindowOpen()) {
        window->PollEvents();
        @autoreleasepool {

            renderer->SwapChain();
            Render();
            renderer->EndEncoding();

        }
    }

}

void Application::Render() {
    static float rotate_ = 0.0f;
    rotate_ += 1.0f / 60.0f;
    glm::mat4 rotate = projectionview * glm::rotate(glm::mat4(1.0f), glm::radians(rotate_ * 15.0f), glm::vec3(0, 0, 1));
    renderer->Clear(glm::vec4(0.3f, 0.3f, 0.3f, 1));

    glm::mat4 rotate2 =
            projectionview * glm::rotate(glm::mat4(1.0f), glm::radians(rotate_ * 25.0f), glm::vec3(0, 0, 1));
    renderer->Clear(glm::vec4(0.3f, 0.3f, 0.3f, 1));

//    texture->Bind();
//    renderer->Submit(vertexBuffer, indexBuffer, whiteShader);
//    renderer->BeginRender(rotate);
//    renderer->Draw();
//    renderer->EndRender();
//
//    renderer->Submit(vertexBuffer, indexBuffer, whiteShader);
//    renderer->BeginRender(rotate2);
//    renderer->Draw();
//    renderer->EndRender();

    texture->Bind();
    Renderer2D::BeginScene();
    Renderer2D::DrawQuad({0.0f, 0.0f, 1.0f}, {0.2f, 0.2f}, {1.0f, 1.0f, 1.0f, 1.0f});
    Renderer2D::DrawQuad({0.0f, 0.6f, 1.0f}, {0.2f, 0.2f}, {1.0f, 0.0f, 0 .0f, 1.0f});
    Renderer2D::EndScene();


            //    renderer->Submit(vertexBuffer, indexBuffer, whiteShader2);
//    renderer->BeginRender(whiteShader2);
//    renderer->Draw(vertexBuffer, indexBuffer, rotate);
//    renderer->Draw(vertexBuffer, indexBuffer, rotate2);
//    renderer->EndRender();


}

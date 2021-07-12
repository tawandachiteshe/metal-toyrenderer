//
// Created by __declspec on 5/7/2021.
//

#include <Renderer/RenderCommand.h>
#import <Renderer/Renderer2D.h>
#include "SandBox2D.h"
#include "Core/Input.h"
#include "imgui.h"

struct Vertex {
    glm::vec3 position;
    glm::vec4 color;
    glm::vec2 uv;
};

static float frameTime = 0.0f;

void SandBox2D::OnImGuiRender() {

    ImGui::Begin("Tawanda");
    ImGui::Text("Frame time %f", frameTime);
    ImGui::Text("FPS %f", (1000.0f / frameTime));
    ImGui::End();

}

void SandBox2D::OnAttach() {

}

void SandBox2D::OnDetach() {

}

void SandBox2D::OnUpdate(Timestep ts) {
    m_CameraController.OnUpdate(ts);
    frameTime = ts.GetMilliseconds();
    //if u dont clear doesnt work
    RenderCommand::Clear({1.0f, 0.0f, 0.0f, 1.0f});
    texture->Bind();

    Renderer::BeginRender(m_CameraController.GetCamera());
    Renderer::Submit(vertexBuffer, indexBuffer, whiteShader);
    Renderer::EndRender();

//
//    Renderer2D::BeginScene( m_CameraController.GetCamera().GetProjectionMatrix());
//    Renderer2D::DrawQuad({0.0f, 0.0f, 1.0f}, {1.0f, 1.0f}, {1.0f, 1.0f, 1.0f, 1.0f});
//    Renderer2D::EndScene();

}

void SandBox2D::OnEvent(Event &e) {
    m_CameraController.OnEvent(e);

}

SandBox2D::SandBox2D() :
        Layer("Sandbox2D"), m_CameraController(1280.0f / 720.0f), m_SquareColor({ 0.2f, 0.3f, 0.8f, 1.0f })
{

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

}

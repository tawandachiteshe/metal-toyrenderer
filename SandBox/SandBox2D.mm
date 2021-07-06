//
// Created by __declspec on 5/7/2021.
//

#include <Renderer/RenderCommand.h>
#include "SandBox2D.h"
#include "imgui.h"

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
    frameTime = ts.GetMilliseconds();
    //if u dont clear doesnt work
    RenderCommand::Clear({1.0f, 0.0f, 0.0f, 1.0f});

}

void SandBox2D::OnEvent(Event &e) {

}

SandBox2D::SandBox2D() :
        Layer("Sandbox2D"), m_CameraController(1280.0f / 720.0f), m_SquareColor({ 0.2f, 0.3f, 0.8f, 1.0f })
{

}

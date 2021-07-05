//
// Created by __declspec on 5/7/2021.
//

#include "SandBox2D.h"

void SandBox2D::OnImGuiRender() {

}

void SandBox2D::OnAttach() {

}

void SandBox2D::OnDetach() {

}

void SandBox2D::OnUpdate(Timestep ts) {

}

void SandBox2D::OnEvent(Event &e) {

}

SandBox2D::SandBox2D() :
        Layer("Sandbox2D"), m_CameraController(1280.0f / 720.0f), m_SquareColor({ 0.2f, 0.3f, 0.8f, 1.0f })
{

}

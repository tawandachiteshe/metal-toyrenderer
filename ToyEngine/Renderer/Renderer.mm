//
// Created by __declspec on 25/6/2021.
//

#include "Renderer.h"
#import "Shader.h"
#include <iostream>
#import <GLFW/glfw3.h>
#include "RenderCommand.h"
#import "Window/Window.h"
#import "InitMetal.h"
#import "Renderer2D.h"
#import "Swapchain.h"


Scope<Renderer::SceneData> Renderer::s_SceneData = CreateScope<Renderer::SceneData>();

void Renderer::Init() {
    InitMetal::Init();
    Renderer2D::Init();
}


void Renderer::Clear(const glm::vec4 &color) {
    InitMetal::Clear(color);
}


void Renderer::BeginRender(const EditorCamera& camera) {

    s_SceneData->ViewProjectionMatrix = camera.GetViewProjection();
}

void Renderer::EndRender() {
}

void
Renderer::Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer, const std::shared_ptr<Shader>& shader, const glm::mat4& transform) {

    shader->Bind();
    shader->SetMat4(s_SceneData->ViewProjectionMatrix);
    shader->SetMat4(transform, 1);
    RenderCommand::DrawIndexed(vertexBuffer, indexBuffer);

}

void Renderer::OnWindowResize(uint32_t width, uint32_t height) {
    //setview port here
    Swapchain::SetSize(width, height);
}


void Renderer::Shutdown() {
    //TODO: Clear shit here
}



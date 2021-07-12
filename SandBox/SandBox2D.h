//
// Created by __declspec on 5/7/2021.
//

#ifndef METAL_TOYRENDERER_SANDBOX2D_H
#define METAL_TOYRENDERER_SANDBOX2D_H


#include <Renderer/OrthoCameraController.h>
#include <Core/Layer.h>
#include <Renderer/Renderer.h>
#include <Renderer/Texture.h>

class SandBox2D : public Layer{
public:
    SandBox2D();

    virtual ~SandBox2D() = default;

    virtual void OnAttach() override;

    virtual void OnDetach() override;

    void OnUpdate(Timestep ts) override;

    virtual void OnImGuiRender() override;

    void OnEvent(Event &e) override;

private:
    std::shared_ptr<Renderer> renderer;
    std::shared_ptr<VertexBuffer> vertexBuffer;
    std::shared_ptr<IndexBuffer> indexBuffer;
    std::shared_ptr<Shader> whiteShader;
    std::shared_ptr<Shader> whiteShader2;
    std::shared_ptr<Texture> texture;
    std::shared_ptr<Texture> texture2;
    glm::mat4 projectionview;
    OrthoCameraController m_CameraController;

    glm::vec4 m_SquareColor = {0.2f, 0.3f, 0.8f, 1.0f};
};


#endif //METAL_TOYRENDERER_SANDBOX2D_H

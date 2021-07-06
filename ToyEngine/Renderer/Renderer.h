//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_RENDERER_H
#define UNTITLED_RENDERER_H


#import <MacTypes.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>
#include <glm/glm.hpp>
#include "Core/Base.h"
#include "OrthoCamera.h"
#import "Shader.h"
#import "VertexBuffer.h"
#import "IndexBuffer.h"

class Renderer {

private:

    struct SceneData
    {
        glm::mat4 ViewProjectionMatrix;
    };

    static Scope<SceneData> s_SceneData;

public:

    static void Init();

    static void DrawIndexed(const Ref<VertexBuffer>& vertexBuffer, const Ref<IndexBuffer>& indexBuffer, const Ref<Shader>& shader, uint32_t count = 0);

    static void Clear(const glm::vec4 &color);

    static void BeginRender(const OrthoCamera& camera);

    static void EndRender();

    static void OnWindowResize(uint32_t width, uint32_t height);

    static void Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,
                const std::shared_ptr<Shader> &shader);

    static void Shutdown();
};


#endif //UNTITLED_RENDERER_H

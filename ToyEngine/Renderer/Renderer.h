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
#import "EditorCamera.h"

class Renderer {

private:

    struct SceneData
    {
        glm::mat4 ViewProjectionMatrix;
    };

    static Scope<SceneData> s_SceneData;

public:

    static void Init();

    static void Clear(const glm::vec4 &color);

    static void BeginRender(const EditorCamera& camera);

    static void EndRender();

    static void OnWindowResize(uint32_t width, uint32_t height);

    static void Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,
                const std::shared_ptr<Shader> &shader, const glm::mat4& transform = glm::mat4(1.0f));

    static void Shutdown();
};


#endif //UNTITLED_RENDERER_H

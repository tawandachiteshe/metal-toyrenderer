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
    static id <MTLDevice> device;
    static id <MTLCommandQueue> queue;
    static CAMetalLayer *swapchain;
    glm::vec4 clearColor;
    static id <CAMetalDrawable> surface;
    static id <MTLCommandBuffer> commandBuffer;
    static MTLRenderPassDescriptor *renderPass;
    static id <MTLRenderCommandEncoder> commandEncoder;

private:

    struct SceneData
    {
        glm::mat4 ViewProjectionMatrix;
    };

    static Scope<SceneData> s_SceneData;

public:

    static void Init();

    static id <MTLDevice> GetDevice() { return device; }

    static MTLRenderPassDescriptor *GetRenderPass() { return renderPass; }

    static id <MTLCommandBuffer> GetCommandBuffer() { return commandBuffer; }

    static id <MTLRenderCommandEncoder> GetCommandEncoder() {return commandEncoder; }

    static void DrawIndexed(const Ref<VertexBuffer>& vertexBuffer, const Ref<IndexBuffer>& indexBuffer, const Ref<Shader>& shader, uint32_t count = 0);

    static CAMetalLayer *GetSwapChain() { return swapchain; }

    void Clear(const glm::vec4 &color = glm::vec4(0.33f, 0.33f, 0.33f, 1.0f));

    static void BeginRender(const OrthoCamera& camera);

    void EndRender();

    static void OnWindowResize(uint32_t width, uint32_t height);

    static void Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,
                const std::shared_ptr<Shader> &shader);

    static void Shutdown();
};


#endif //UNTITLED_RENDERER_H

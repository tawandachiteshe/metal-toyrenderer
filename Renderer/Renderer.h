//
// Created by __declspec on 25/6/2021.
//

#ifndef UNTITLED_RENDERER_H
#define UNTITLED_RENDERER_H


#import <MacTypes.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>
#include <glm/glm.hpp>
#import "VertexBuffer.h"
#import "Shader.h"
#import "IndexBuffer.h"
#include <memory>

class Renderer {

private:
    static id <MTLDevice> device;
    id <MTLCommandQueue> queue = nil;
    CAMetalLayer *swapchain = nil;
    glm::vec4 clearColor;
    static id <CAMetalDrawable> surface;
    static id <MTLCommandBuffer> commandBuffer;
    static MTLRenderPassDescriptor *renderPass;
    static id <MTLRenderCommandEncoder> encoder;
    std::shared_ptr<VertexBuffer> vertexBuffer;
    std::shared_ptr<IndexBuffer> indexBuffer;
    std::shared_ptr<Shader> shader;

public:

    void Init();

    void SwapChain();

    static id <MTLDevice> GetDevice() { return device; }

    static id <MTLRenderCommandEncoder> GetEncoder() { return encoder; }

    static MTLRenderPassDescriptor *GetRenderPass() { return renderPass; }

    static id <MTLCommandBuffer> GetCommandBuffer() { return commandBuffer; }

    static id <CAMetalDrawable> GetSurface() { return surface; }

    static void EndEncoding() {
        [encoder endEncoding];
        [commandBuffer presentDrawable:Renderer::GetSurface()];
        [commandBuffer commit];
    }

    CAMetalLayer *GetSwapChain() { return swapchain; }

    void Clear(const glm::vec4 &color = glm::vec4(0.33f, 0.33f, 0.33f, 1.0f));

    void BeginRender(const glm::mat4 &transform=glm::mat4(1.0f));

    void EndRender();

    void Draw();

    void Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,
                const std::shared_ptr<Shader> &shader);

};


#endif //UNTITLED_RENDERER_H

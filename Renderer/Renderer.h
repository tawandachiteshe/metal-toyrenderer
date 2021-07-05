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
#import "RenderCommand.h"

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
    static bool isMainFrame;
public:
    static bool GetIsMainFrame();

public:
    static void SetIsMainFrame(bool isMainFrame);

private:
    std::shared_ptr<VertexBuffer> vertexBuffer;
    std::shared_ptr<IndexBuffer> indexBuffer;
    std::shared_ptr<Shader> shader;

public:

    void Init();

    void Present() {
        [commandBuffer presentDrawable:surface];
        [commandBuffer commit];
        [commandBuffer waitUntilCompleted];
    }

    void SwapChain();

    static id <MTLDevice> GetDevice() { return device; }

    static id <MTLRenderCommandEncoder> GetEncoder() { return encoder; }

    static MTLRenderPassDescriptor *GetRenderPass() { return renderPass; }

    static id <MTLCommandBuffer> GetCommandBuffer() { Renderer::isMainFrame = true; return commandBuffer; }

    static id <CAMetalDrawable> GetSurface() { return surface; }

    static void SetEncoder(id <MTLRenderCommandEncoder> commandEncoder);


    CAMetalLayer *GetSwapChain() { return swapchain; }

    void Clear(const glm::vec4 &color = glm::vec4(0.33f, 0.33f, 0.33f, 1.0f));

    void BeginRender(const glm::mat4 &transform=glm::mat4(1.0f));

    void EndRender();

    void Draw();

    void Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,
                const std::shared_ptr<Shader> &shader);

};


#endif //UNTITLED_RENDERER_H

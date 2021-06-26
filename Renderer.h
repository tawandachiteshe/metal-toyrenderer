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
    static id<MTLDevice> device;
    id<MTLCommandQueue> queue = nil;
    CAMetalLayer *swapchain = nil;
    glm::vec4 clearColor;
    id<CAMetalDrawable> surface;
    id<MTLCommandBuffer> commandBuffer;
    MTLRenderPassDescriptor *renderPass;
    static id<MTLRenderCommandEncoder> encoder;

public:

    void Init();
    void SwapChain();
    static id<MTLDevice> GetDevice() { return device; }
    static id<MTLRenderCommandEncoder> GetEncoder() { return encoder; }
    CAMetalLayer* GetSwapChain() { return swapchain; }
    void Clear(const glm::vec4 &color = glm::vec4(0.33f, 0.33f, 0.33f, 1.0f));
    void BeginRender(const std::shared_ptr<VertexBuffer>& vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,const std::shared_ptr<Shader> &shader);
    void EndRender();

};


#endif //UNTITLED_RENDERER_H

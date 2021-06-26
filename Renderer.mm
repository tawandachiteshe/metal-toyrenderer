//
// Created by __declspec on 25/6/2021.
//

#include "Renderer.h"
#import "Shader.h"
#include <iostream>


id <MTLDevice> Renderer::device = nil;
id <MTLRenderCommandEncoder> Renderer::encoder = nil;

void Renderer::Init() {

    device = MTLCreateSystemDefaultDevice();
    queue = [device newCommandQueue];
    swapchain = [CAMetalLayer layer];
    swapchain.pixelFormat = MTLPixelFormatBGRA8Unorm;
    swapchain.framebufferOnly = YES;
    swapchain.device = device;
    swapchain.opaque = YES;

}

void Renderer::SwapChain() {

    surface = [swapchain nextDrawable];
    renderPass = [MTLRenderPassDescriptor renderPassDescriptor];
    renderPass.colorAttachments[0].clearColor = MTLClearColorMake(clearColor.r, clearColor.g, clearColor.b,
                                                                  clearColor.a);;
    renderPass.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPass.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPass.colorAttachments[0].texture = surface.texture;
    commandBuffer = [queue commandBuffer];

}

void Renderer::Clear(const glm::vec4 &color) {

    clearColor = color;

}

void Renderer::BeginRender(const std::shared_ptr<VertexBuffer> &vertexBuffer,
                           const std::shared_ptr<IndexBuffer> &indexBuffer, const std::shared_ptr<Shader> &shader) {

    encoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPass];
    shader->Bind();
    [encoder setVertexBuffer:vertexBuffer->GetBuffer() offset:0 atIndex:0];
    [encoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:indexBuffer->GetCount() indexType:MTLIndexTypeUInt32
                       indexBuffer:indexBuffer->GetBuffer() indexBufferOffset:0];

}

void Renderer::EndRender() {
    [encoder endEncoding];
    [commandBuffer presentDrawable:surface];
    [commandBuffer commit];
}



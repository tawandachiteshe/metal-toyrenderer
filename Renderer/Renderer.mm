//
// Created by __declspec on 25/6/2021.
//

#include "Renderer.h"
#import "Shader.h"
#include <iostream>
#include "RenderCommand.h"


id <MTLDevice> Renderer::device = nil;
id <MTLRenderCommandEncoder> Renderer::encoder = nil;
MTLRenderPassDescriptor* Renderer::renderPass = nil;
id<MTLCommandBuffer> Renderer::commandBuffer = nil;

void Renderer::Init() {

    device = MTLCreateSystemDefaultDevice();
    queue = [device newCommandQueue];
    swapchain = [CAMetalLayer layer];
    swapchain.pixelFormat = MTLPixelFormatBGRA8Unorm;
    swapchain.framebufferOnly = YES;
    swapchain.device = device;
    swapchain.opaque = YES;


    MTLViewport viewport =
            {
                    .originX = 0.0,
                    .originY = 0.0,
                    .width = 1280,
                    .height = 800,
                    .znear = 0.0,
                    .zfar = 1.0
            };
    [encoder setViewport:viewport];



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

void Renderer::BeginRender(const std::shared_ptr<Shader> &shader, const glm::mat4& transform) {

    shader->Bind();
    shader->SetMat4(transform);

}

void Renderer::EndRender() {

    RenderCommand::DrawIndexed(vertexBuffer, indexBuffer);

    [encoder endEncoding];
    [commandBuffer presentDrawable:surface];
    [commandBuffer commit];
}

void
Renderer::Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer) {
    encoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPass];
    this->vertexBuffer = vertexBuffer;
    this->indexBuffer = indexBuffer;
}



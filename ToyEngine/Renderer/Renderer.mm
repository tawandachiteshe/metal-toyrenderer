//
// Created by __declspec on 25/6/2021.
//

#include "Renderer.h"
#import "Shader.h"
#include <iostream>
#import <GLFW/glfw3.h>
#include "RenderCommand.h"
#import "Window/Window.h"

id <MTLDevice> Renderer::device = nil;
id <MTLRenderCommandEncoder> Renderer::commandEncoder = nil;
CAMetalLayer* Renderer::swapchain = nil;
id <MTLCommandQueue> Renderer::queue = nil;
MTLRenderPassDescriptor* Renderer::renderPass = nil;
id<MTLCommandBuffer> Renderer::commandBuffer = nil;
id<CAMetalDrawable> Renderer::surface = nil;
Scope<Renderer::SceneData> Renderer::s_SceneData = CreateScope<Renderer::SceneData>();

void Renderer::Init() {

    device = MTLCreateSystemDefaultDevice();
    queue = [device newCommandQueue];
    swapchain = [CAMetalLayer layer];
    swapchain.pixelFormat = MTLPixelFormatBGRA8Unorm;
    swapchain.framebufferOnly = NO;
    swapchain.device = device;
    swapchain.opaque = YES;

}


void Renderer::Clear(const glm::vec4 &color) {

    surface = [swapchain nextDrawable];
    renderPass = [MTLRenderPassDescriptor renderPassDescriptor];
    renderPass.colorAttachments[0].clearColor = MTLClearColorMake(clearColor.r, clearColor.g, clearColor.b,
                                                                  clearColor.a);;
    renderPass.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPass.colorAttachments[0].storeAction = MTLStoreActionStore;
    renderPass.colorAttachments[0].texture = surface.texture;

    commandBuffer = [queue commandBuffer];
    commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPass];
}


void Renderer::BeginRender(const OrthoCamera& camera) {
    s_SceneData->ViewProjectionMatrix = camera.GetViewProjectionMatrix();
}

void Renderer::EndRender() {

}

void
Renderer::Submit(const std::shared_ptr<VertexBuffer> &vertexBuffer, const std::shared_ptr<IndexBuffer> &indexBuffer,const std::shared_ptr<Shader>& shader) {

    shader->Bind();
    shader->SetMat4(s_SceneData->ViewProjectionMatrix);
    DrawIndexed(vertexBuffer, indexBuffer, shader);

}

void Renderer::OnWindowResize(uint32_t width, uint32_t height) {

}

void Renderer::DrawIndexed(const Ref<VertexBuffer> &vertexBuffer,
                           const Ref<IndexBuffer> &indexBuffer, const Ref<Shader> &shader,
                           uint32_t count) {


    [commandEncoder setRenderPipelineState:shader->GetPipelineState()];

    [commandEncoder setVertexBuffer:vertexBuffer->GetBuffer() offset:0 atIndex:0];
    [commandEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:count == 0 ? indexBuffer->GetCount() : count indexType:MTLIndexTypeUInt32
                              indexBuffer:indexBuffer->GetBuffer() indexBufferOffset:0];

    [commandBuffer presentDrawable:surface];
    [commandBuffer commit];
    [commandBuffer waitUntilCompleted];
}

void Renderer::Shutdown() {
    //TODO: Clear shit here
}



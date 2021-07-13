//
// Created by __declspec on 6/7/2021.
//

#include "InitMetal.h"
#import "Swapchain.h"

id<MTLDevice> InitMetal::device = nil;
id<MTLCommandQueue> InitMetal::commandQueue = nil;
MTLRenderPassDescriptor* InitMetal::renderPassDescriptor = nil;
id<MTLCommandBuffer> InitMetal::commandBuffer = nil;
id <MTLRenderCommandEncoder> InitMetal::renderEncoder = nil;

void InitMetal::Init() {
    device = MTLCreateSystemDefaultDevice();
    commandQueue = [device newCommandQueue];
    renderPassDescriptor = [MTLRenderPassDescriptor new];
}

id<MTLDevice> InitMetal::GetDevice() {
    return device;
}

MTLRenderPassDescriptor *InitMetal::GetRenderPassDescriptor() {
    return renderPassDescriptor;
}

void InitMetal::Clear(const glm::vec4 &clearColor) {

    //Swaochain before clear
    commandBuffer = [commandQueue commandBuffer];

    renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(clearColor.r, clearColor.b, clearColor.g, clearColor.a);
    renderPassDescriptor.colorAttachments[0].texture = Swapchain::GetTexture();
    renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
    renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;

    renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor: renderPassDescriptor];
}

void InitMetal::DrawIndexed(const Ref<VertexBuffer> &vertexBuffer, const Ref<IndexBuffer> &indexBuffer,
                           uint32_t count) {

    [renderEncoder setVertexBuffer:vertexBuffer->GetBuffer() offset:0 atIndex:0];
    [renderEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:count == 0 ? indexBuffer->GetCount() : count indexType:MTLIndexTypeUInt32
                              indexBuffer:indexBuffer->GetBuffer() indexBufferOffset:0];

}



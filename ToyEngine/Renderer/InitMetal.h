//
// Created by __declspec on 6/7/2021.
//

#ifndef SANDBOX_INITMETAL_H
#define SANDBOX_INITMETAL_H

#import <Metal/Metal.h>
#import <glm/vec4.hpp>
#import <Core/Base.h>
#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "Shader.h"

class InitMetal {
private:
    static MTLRenderPassDescriptor *renderPassDescriptor;
    static id<MTLCommandBuffer> commandBuffer;
    static id <MTLRenderCommandEncoder> renderEncoder;

public:
    static MTLRenderPassDescriptor *GetRenderPassDescriptor();

private:
    static id<MTLDevice> device;
    static id<MTLCommandQueue> commandQueue;

public:
    static id<MTLCommandBuffer> GetCommandBuffer() { return commandBuffer; }
    static id <MTLRenderCommandEncoder> GetCommandEncoder() {return renderEncoder; }
    static void Init();
    static id<MTLDevice> GetDevice();
    static void Clear(const glm::vec4& clearColor);
    static void DrawIndexed(const Ref<VertexBuffer> &vertexBuffer,
                               const Ref<IndexBuffer> &indexBuffer, const Ref<Shader> &shader,
                               uint32_t count);

};


#endif //SANDBOX_INITMETAL_H

//
// Created by __declspec on 5/7/2021.
//

#import <glm/gtc/type_ptr.hpp>
#include "UniformBuffer.h"
#import "Renderer.h"

void UniformBuffer::SetData(const void *data, uint32_t size, uint32_t offset) {
    memcpy(uniformBuffer.contents, data, size);
    [Renderer::GetCommandEncoder() setVertexBuffer: uniformBuffer offset: offset atIndex:1];
}

UniformBuffer::UniformBuffer(uint32_t size, uint32_t binding) {

    uniformBuffer = [Renderer::GetDevice() newBufferWithLength: size options: MTLResourceStorageModeShared];


}

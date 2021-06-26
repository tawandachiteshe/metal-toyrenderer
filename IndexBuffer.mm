//
// Created by __declspec on 26/6/2021.
//

#include "IndexBuffer.h"
#import "Renderer.h"

IndexBuffer::IndexBuffer(uint32_t *data, uint32_t count): count(count) {

    indexBuffer = [Renderer::GetDevice() newBufferWithBytes:data length:sizeof(uint32_t) * count options:MTLResourceOptionCPUCacheModeDefault];

}

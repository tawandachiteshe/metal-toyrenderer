//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_RENDERCOMMAND_H
#define UNTITLED_RENDERCOMMAND_H

#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "Shader.h"
#include <memory>

class RenderCommand {

private:
    static id<MTLRenderCommandEncoder> commandEncoder;
    static MTLRenderPassDescriptor* renderPassDescriptor;

public:
    static id <MTLRenderCommandEncoder> GetCommandEncoder();

public:
    static void SetCommandEncoder(id <MTLRenderCommandEncoder> encoder);
    static void EndCommandEncoder();

public:
    static void DrawIndexed(const std::shared_ptr<VertexBuffer>& vertexBuffer, const std::shared_ptr<IndexBuffer>& indexBuffer, const std::shared_ptr<Shader>& shader, uint32_t count = 0);
    static void Init();

};


#endif //UNTITLED_RENDERCOMMAND_H

//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_RENDERCOMMAND_H
#define UNTITLED_RENDERCOMMAND_H

#import "VertexBuffer.h"
#import "IndexBuffer.h"
#import "Shader.h"

#include <memory>

class RenderCommand {

private:
    static id<MTLRenderCommandEncoder> commandEncoder;

public:
    static void DrawIndexed(const std::shared_ptr<VertexBuffer>& vertexBuffer, const std::shared_ptr<IndexBuffer>& indexBuffer, const std::shared_ptr<Shader>& shader, uint32_t count = 0);
    static void Init();

};


#endif //UNTITLED_RENDERCOMMAND_H

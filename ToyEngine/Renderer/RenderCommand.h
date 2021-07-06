//
// Created by __declspec on 26/6/2021.
//

#ifndef UNTITLED_RENDERCOMMAND_H
#define UNTITLED_RENDERCOMMAND_H

#include "VertexBuffer.h"
#include "IndexBuffer.h"
#include "Shader.h"
#include <memory>
#import <Core/Base.h>

class RenderCommand {

public:
    static void DrawIndexed(const Ref<VertexBuffer>& vertexBuffer, const Ref<IndexBuffer>& indexBuffer, const Ref<Shader>& shader, uint32_t count = 0);
    static void Clear(const glm::vec4& clearColor = glm::vec4(0.33f, 0.33f, 0.33f, 1.0f));

};


#endif //UNTITLED_RENDERCOMMAND_H

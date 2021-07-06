//
// Created by __declspec on 26/6/2021.
//

#include "RenderCommand.h"
#import "Renderer.h"



void RenderCommand::DrawIndexed(const std::shared_ptr<VertexBuffer> &vertexBuffer,
                                const std::shared_ptr<IndexBuffer> &indexBuffer, const std::shared_ptr<Shader>& shader, uint32_t count) {

    Renderer::DrawIndexed(vertexBuffer, indexBuffer, shader,count);

}

void RenderCommand::Clear(const glm::vec4 &clearColor) {
    Renderer::Clear(clearColor);
}


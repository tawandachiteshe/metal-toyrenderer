//
// Created by __declspec on 26/6/2021.
//

#include "RenderCommand.h"
#import "Renderer.h"
#import "InitMetal.h"


void RenderCommand::DrawIndexed(const std::shared_ptr<VertexBuffer> &vertexBuffer,
                                const std::shared_ptr<IndexBuffer> &indexBuffer, uint32_t count) {

    InitMetal::DrawIndexed(vertexBuffer, indexBuffer, count);

}

void RenderCommand::Clear(const glm::vec4 &clearColor) {
    Renderer::Clear(clearColor);
}

